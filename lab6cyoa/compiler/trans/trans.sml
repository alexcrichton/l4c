(* L5 Compiler
 * AST -> IR translator
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TRANS =
sig
  val translate : Ast.program -> Tree.cfg
end

structure Trans :> TRANS =
struct

  structure A = Ast
  structure T = Tree
  structure G = Graph
  structure DG = DirectedGraph(DynArray)
  structure HT = HashTable

  type class_table = ((int * A.ident)Symbol.table * A.ident option) Symbol.table
  type func_table = (bool * Tree.typ * Tree.typ list) Symbol.table
  type struct_table = ((int * T.typ) Symbol.table * int) Symbol.table
  type temp_table = (Temp.temp * Tree.typ) Symbol.table

  type env = {classes: class_table,
              cur_class: A.ident option,
              cur_fun: A.ident,
              funs: func_table,
              structs: struct_table,
              temps: temp_table}

  type state = T.stm list * (Graph.node_id * T.edge) list * Graph.node_id

  fun dump_classes c = let
        fun dump_funs cfuns fname =
            let val (idx, from) = Symbol.look' cfuns fname in
              print ("  " ^ Symbol.name fname ^ "\t=> " ^ Int.toString idx ^
                     ", " ^ Symbol.name from ^ "\n")
            end
        fun dump_class cname =
            let val (ftables, extends) = Symbol.look' c cname in
              print ("class " ^ Symbol.name cname);
              case extends
                of SOME parent => print (" extends " ^ Symbol.name parent)
                | NONE => ();
              print "\n";
              app (dump_funs ftables) (Symbol.keys ftables)
            end
      in
        print "Class table:\n";
        app dump_class (Symbol.keys c);
        print "\n"
      end

  fun dump_funs f = (
      print "Funs table:\n";
      app (fn s => print ("  " ^ Symbol.name s ^ "\n")) (Symbol.keys f);
      print "\n")

  (* typ_size : 'a -> A.typ -> int
   *
   * Calculates the size of a type
   * @param T the table of structs
   * @param typ the type to size
   * @return the size of the type
   *)
  fun typ_size _ A.INT  = 4
    | typ_size _ A.BOOL = 4
    | typ_size _ (A.PTR _) = 8
    | typ_size _ (A.ARRAY _) = 8
    | typ_size (s : struct_table) (A.STRUCT id) = #2 (Symbol.look' s id)
    | typ_size s (A.CLASS id) = #2 (Symbol.look' s id) + 8
    | typ_size _ _ = raise Fail "Invalid type"

  (* struct_off : struct_table -> A.typ -> Symbol.symbol -> int
   *
   * Fetches the offset of a field in a struct
   * @param env the environment tuple, where the third element is the table of
   *        struct information
   * @param typ the struct type to lookup
   * @param field the name of the field to find the offset for
   * @return the offset of the field into the struct.
   *)
  fun struct_off (s : struct_table) (A.STRUCT id | A.CLASS id) field =
        Symbol.look' (#1 (Symbol.look' s id)) field
    | struct_off _ _ _ = raise Fail "Invalid struct"

  (* const : int -> T.exp
   *
   * Helper function to quickly go from an integer to a constant expression
   *)
  fun const n = T.CONST (Word32.fromInt n, T.WORD)
  fun constq n = T.CONST (Word32.fromInt n, T.QUAD)

  (* scopedl? : symbol * symbol -> symbol/label
   *
   * Concatenates the symbols into an appropriate label for scoped functions
   *)
  fun scoped (s1, s2) = Symbol.symbol (Symbol.name s1 ^ "$$" ^ Symbol.name s2)
  fun scopedl (s1, s2) = Label.scoped_func (Symbol.name s1, Symbol.name s2)

  (* change_state : state * T.stm -> state
   *
   * Changes the state given such that the given statement is appended to the
   * end of the list of statements in the state.
   *)
  fun change_state ((stms, preds, id), stm) = (stms @ [stm], preds, id)

  (* safe : unit -> bool
   *
   * Returns whether safe compilation should be turned on or not with respect
   * to memory references
   *)
  fun safe () = not (Flag.isset Options.flag_unsafe) andalso
                    Flag.isset Options.flag_safe

  (* protect_access : state * T.exp -> state
   *
   * Protects a memory access at the given address. If memory safety is turned
   * on, the given state is modified appropriately to include a check.
   * Otherwise, the state is not modified.
   *)
  fun protect_access (state, addr) =
        if not (safe ()) then state
        else let val e = T.BINOP (T.EQ, addr, constq 0) in
          change_state (state, T.GOTO (Label.extfunc "raise_segv", SOME e))
        end

  (* protect_arr_access : T.exp * state * T.exp -> state
   *
   * Performs bounds checking on array indices.
   *
   * @param arr_addr the expression for the address of the array
   * @param state the current state of the program
   * @param arr_idx the index into the array to check
   * @return the altered state with bounds checking if safety is turned on
   *)
  fun protect_arr_access (arr_addr, state, arr_idx) = let
        val abrt = Label.extfunc "raise_segv"
        val size = T.MEM (T.BINOP (T.SUB, arr_addr, constq 8), T.WORD)
        val check1 = T.BINOP (T.LT, arr_idx, const 0)
        val check2 = T.BINOP (T.LTE, size, arr_idx)
      in
        if not (safe ()) then state
        else change_state (change_state (state, T.GOTO (abrt, SOME check1)),
                           T.GOTO (abrt, SOME check2))
      end

  (* trans_typ : A.typ -> T.typ
   * Translates types from AST types to Tree types
   *)
  fun trans_typ (A.STRUCT _ | A.ARRAY _ | A.PTR _) = T.QUAD
    | trans_typ _ = T.WORD

  (* trans_oper : A.binop -> T.binop
   *
   * Translates an AST binop to a IR binop
   *)
  fun trans_oper A.PLUS      = T.ADD
    | trans_oper A.MINUS     = T.SUB
    | trans_oper A.TIMES     = T.MUL
    | trans_oper A.DIVIDEDBY = T.DIV
    | trans_oper A.MODULO    = T.MOD
    | trans_oper A.LESS      = T.LT
    | trans_oper A.LESSEQ    = T.LTE
    | trans_oper A.EQUALS    = T.EQ
    | trans_oper A.NEQUALS   = T.NEQ
    | trans_oper A.BAND      = T.AND
    | trans_oper A.BOR       = T.OR
    | trans_oper A.XOR       = T.XOR
    | trans_oper A.LSHIFT    = T.LSH
    | trans_oper A.RSHIFT    = T.RSH
    | trans_oper _           = raise Fail "Invalid binop translation"

  (* commit : graph -> T.block -> G.node_id list -> G.node_id
   *
   * Commits the given block to the graph.
   * @param g the graph to add to
   * @param block the block of statements to add as a node
   * @param preds the predecessors of this node
   * @return the node id of the node created
   *)
  fun commit (G.GRAPH g) (block, preds, nid) =
        (#add_node g (nid, block);
         app (fn (pred, edge) => #add_edge g (pred, nid, edge)) preds;
         nid)

  (* new_id : graph -> node_id
   *
   * Returns a new node id for the graph. It does it correctly unlike the
   * stupid built-in one.
   *)
  fun new_id (G.GRAPH g) = let
        val id = #new_id g ()
        val _ = #add_node g (id, [])
      in id end

  (* class_table * func_table -> symbol * symbol -> bool * typ * typ list
   *
   * Looks up the function in the specified class or in its parents.
   *)
  fun lookup_fun (ctable : class_table, funs) (class, method) =
      let val (_, loc) = Symbol.look' (#1 (Symbol.look' ctable class)) method in
        Symbol.look' funs (scoped (loc, method))
      end

  (* trans_args : env * graph -> (A.exp * (state * T.exp list)) ->
   *                             state * T.exp list
   *
   * Translates a list of arguments, returning the new state and the list of
   * arguments as expressions in the same order.
   *)
  fun trans_args (env, g) (d, (s, dests)) = let
        val (s', result) = trans_exp (env, g, s) d false
      in (s', dests @ [result]) end

  (* trans_exp : 'a -> A.exp -> bool -> state * T.exp
   *
   * Translates an AST expression into an IR expression.
   *
   * @param env the environment so far
   * @param exp the expression to convert
   * @param addr true if an address is desired, or false if an actual expression
   *             is required
   *
   * @return A tuple of state and an IR expression. The state represents the
   *         the current state of the block in construction upon return, and the
   *         expression returned is a pure one with no side effects when
   *         evaluated, and hence can be safely thrown away.
   *)
  and trans_exp (env as (e : env, _ : T.cfgraph, state : state)) (A.Var id) a =
      (let
        (* Look up the variable in the environment, then in the class *)
        exception ClassVar
        val (temp, typ) = case Symbol.look (#temps e) id
                            of SOME t => t
                             | NONE   => raise ClassVar
      in
        (state, T.TEMP ((temp, ref ~1), typ))
      end handle ClassVar => let
        val (s', this) = trans_exp env A.This false
        val class = valOf (#cur_class e)
        val (off, size) = struct_off (#structs e) (A.CLASS class) id
      in
        (s', T.MEM (T.BINOP (T.ADD, this, constq off), size))
      end)
    | trans_exp (_, _, s) (A.Bool b) _ = (s, const (if b then 1 else 0))
    | trans_exp (_, _, s) (A.Const w) _ = (s, T.CONST (w, T.WORD))
    | trans_exp (_, _, s) (A.UnaryOp (A.NEGATIVE, A.Const w)) _ =
        (s, T.CONST(~w, T.WORD))
    | trans_exp env (A.UnaryOp (A.NEGATIVE, e)) a =
        trans_exp env (A.BinaryOp (A.MINUS, A.Const Word32Signed.ZERO, e)) a
    | trans_exp env (A.UnaryOp (A.INVERT, e)) a =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt ~1), e)) a
    | trans_exp env (A.UnaryOp (A.BANG, e)) a =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt 1), e)) a
    | trans_exp env (A.BinaryOp (A.GREATER, e1, e2)) a =
        trans_exp env (A.BinaryOp (A.LESS, e2, e1)) a
    | trans_exp env (A.BinaryOp (A.GREATEREQ, e1, e2)) a =
        trans_exp env (A.BinaryOp (A.LESSEQ, e2, e1)) a
    | trans_exp env (A.BinaryOp (A.LAND, e1, e2)) a =
        trans_exp env (A.Ternary (e1, e2, A.Bool false, ref A.BOOL)) a
    | trans_exp env (A.BinaryOp (A.LOR, e1, e2)) a =
        trans_exp env (A.Ternary (e1, A.Bool true, e2, ref A.BOOL)) a
    | trans_exp (e, g, s) (A.BinaryOp (oper, e1, e2)) a = let
        val (s', e1')  = trans_exp (e, g, s)  e1 a
        val (s'', e2') = trans_exp (e, g, s') e2 a
        val result  = T.BINOP (trans_oper oper, e1', e2')
      in
        if oper <> A.DIVIDEDBY andalso oper <> A.MODULO then (s'', result)
        else
          (* Divides and mods can have side effects. Make sure that they always
             happen by moving the result of the operation into a temp *)
          let val t = T.TEMP((Temp.new(), ref ~1), T.WORD) in
            (change_state (s'', T.MOVE (t, result)), t)
          end
      end
    | trans_exp (e, g, s) (A.Ternary (e1, e2, e3, ref typ)) a = let
        fun tmp t = T.TEMP ((t, ref ~1), trans_typ typ)
        val t = Temp.new ()
        val (s', e1') = trans_exp (e, g, s) e1 false
        val id = commit g (change_state (s', T.COND e1'))
        val (tid, fid) = (new_id g, new_id g)
        val (state2, e2') = trans_exp (e, g, ([], [(id, T.TRUE)],  tid)) e2 a
        val (state3, e3') = trans_exp (e, g, ([], [(id, T.FALSE)], fid)) e3 a
        val id2 = commit g (change_state (state2, T.MOVE (tmp t, e2')))
        val id3 = commit g (change_state (state3, T.MOVE (tmp t, e3')))
      in
        (([], [(id2, T.ALWAYS), (id3, T.ALWAYS)], new_id g), tmp t)
      end
    | trans_exp (e as {funs, ...}, g, state) (A.Call (name, EL)) _ = let
        val (state', args) = foldl (trans_args (e, g)) (state, []) EL
        val (isext, rettyp, argtyps) = Symbol.look' funs name
        val label =
          if isext then Label.extfunc (Symbol.name name)
          else Label.intfunc (Symbol.name name)
        val result = T.TEMP ((Temp.new(), ref ~1), rettyp)
        val call = T.CALL (T.ELABEL label, rettyp, ListPair.zip (args, argtyps))
      in
        (change_state (state', T.MOVE (result, call)), result)
      end
    | trans_exp (_, _, state) A.Null _ = (state, constq 0)
    | trans_exp (e as {structs, ...}, g, state) (A.AllocArray (typ, exp)) _ =
      let
        val (state', e') = trans_exp (e, g, state) exp false
        val func = Label.extfunc (if safe () then "salloc_array" else "calloc")
        val temp = T.TEMP ((Temp.new(), ref ~1), T.QUAD)
        val call = T.CALL (T.ELABEL func, T.QUAD,
                           [(e', T.QUAD),
                            (constq (typ_size structs typ), T.QUAD)])
      in
        (change_state (state', T.MOVE (temp, call)), temp)
      end
    | trans_exp ({structs, ...}, _, state) (A.Alloc typ) _ = let
        val func = Label.extfunc (if safe () then "salloc" else "calloc")
        val temp = T.TEMP ((Temp.new(), ref ~1), T.QUAD)
        val call = T.CALL (T.ELABEL func, T.QUAD,
                           [(constq 1, T.QUAD),
                           (constq (typ_size structs typ), T.QUAD)])
      in
        (change_state (state, T.MOVE (temp, call)), temp)
      end
    | trans_exp (e as {structs, ...}, g, s) (A.ArrSub (e1, e2, ref typ)) a = let
        val (s', e1')  = trans_exp (e, g, s) e1 false
        val (s'', e2') = trans_exp (e, g, s') e2 false
        val offset = T.BINOP (T.MUL, e2', const (typ_size structs typ))
        val addr = T.BINOP (T.ADD, e1', offset)
        val dest = T.MEM (addr, trans_typ typ)
        val s'' = protect_access (s'', e1')
        val s'' = protect_arr_access (e1', s'', e2')
      in
        if a then (s'', addr)
        else let val t = T.TEMP ((Temp.new(), ref ~1), trans_typ typ) in
          (change_state (s'', T.MOVE (t, dest)), t)
        end
      end
    | trans_exp env (A.Deref (e, ref typ)) a = let
        val (s', e') = trans_exp env e false
        val s' = case typ of A.STRUCT _ => protect_access (s', e') | _ => s'
      in
        if a then (s', e')
        else let val t = T.TEMP ((Temp.new(), ref ~1), trans_typ typ) in
          (change_state (s', T.MOVE (t, T.MEM(e', trans_typ typ))), t)
        end
      end
    | trans_exp (env as ({structs, ...}, _, _)) (A.Field (exp, id, ref typ)) a =
      let
        val (s', exp') = trans_exp env exp true
        val (off, size) = struct_off structs typ id
        val addr = T.BINOP (T.ADD, exp', constq off)
        val dest = T.MEM (addr, size)
      in
        if a then (s', addr)
        else let val t = T.TEMP ((Temp.new(), ref ~1), size) in
          (change_state (s', T.MOVE (t, dest)), t)
        end
      end
    | trans_exp (env as {funs, classes, ...}, g, s)
                (A.Invoke (e, (ref class, method), args)) a = let
        val (s', e') = trans_exp (env, g, s) e true
        (* calculate the address of the function *)
        val (index, _) = Symbol.look' (#1 (Symbol.look' classes class)) method
        val addr = T.MEM (T.BINOP (T.ADD, T.MEM (e', T.QUAD),
                                   constq (index * 8)), T.QUAD)
        (* setup the function call *)
        val (state', args) = foldl (trans_args (env, g)) (s', []) args
        val (_, rettyp, argtyps) = lookup_fun (classes, funs) (class, method)
        val result = T.TEMP ((Temp.new(), ref ~1), rettyp)
        val call = T.CALL (addr, rettyp, ListPair.zipEq (e' :: args, argtyps))
      in
        (change_state (state', T.MOVE (result, call)), result)
      end
    | trans_exp (e as {funs, ...}, g, s) (A.Allocate (c, args)) a = let
        val (s', e') = trans_exp (e, g, s) (A.Alloc (A.CLASS c)) a
        val s'' = change_state (s', T.MOVE (T.MEM (e', T.QUAD),
                    T.ELABEL (Label.vtable (Symbol.name c))))

        val (state', args) = foldl (trans_args (e, g)) (s'', [e']) args
        val (_, rettyp, argtyps) = Symbol.look' funs (scoped (c, c))
        val label = scopedl (c, c)
        val result = T.TEMP ((Temp.new(), ref ~1), rettyp)
        val call = T.CALL (T.ELABEL label, rettyp, ListPair.zip (args, argtyps))
      in
        (change_state (state', T.MOVE (result, call)), e')
      end
    | trans_exp env A.This a = trans_exp env (A.Var (Symbol.symbol "this")) a
    | trans_exp (env as (e as {classes, cur_class, cur_fun, ...}, g, s))
                (A.Super (id, E)) a = let
        val class = valOf cur_class
        val parent = valOf (#2 (Symbol.look' classes class))
        val (E', to_call) = case id
                              of SOME i => (E, i)
                               | NONE => if Symbol.equal (cur_fun, class)
                                         then (A.This :: E, parent)
                                         else (E, cur_fun)
      in
        trans_exp env (A.Call (scoped (parent, to_call), E')) a
      end
    | trans_exp env (A.Marked data) a = trans_exp env (Mark.data data) a

  (* trans_conditional : env * (id * T.edge) * (id * T.edge) -> T.exp -> unit
   *
   * Translates a conditional expression to jump to the correct locations in
   * the graph. The graph is modified appropriately to include the given
   * condition and all necessary edges for jumps.
   *
   * @param (e, g, s) the currently known environment
   * @param (tid, tedge) the node id and type of edge to be jumped to in the
   *                     true case
   * @param (fid, fedge) same as tid/tedge, except for false case
   * @param exp the expression which should be conditionally jumped on
   *)
  fun trans_conditional env (A.Marked data) =
        trans_conditional env (Mark.data data)
    | trans_conditional ((e, g, s), (tid, tedge), (fid, fedge))
                        (A.BinaryOp (A.LOR, e1, e2)) = let
        val next = new_id g
        val _ = trans_conditional ((e, g, s),
                                     (tid, T.TBRANCH), (next, T.FALSE)) e1
        val _ = trans_conditional ((e, g, ([], [], next)),
                                     (tid, tedge), (fid, fedge)) e2
      in () end
    | trans_conditional ((e, g, s), (tid, tedge), (fid, fedge))
                        (A.BinaryOp (A.LAND, e1, e2)) = let
        val next = new_id g
        val _ = trans_conditional ((e, g, s),
                                     (next, T.TRUE), (fid, T.FBRANCH)) e1
        val _ = trans_conditional ((e, g, ([], [], next)),
                                     (tid, tedge), (fid, fedge)) e2
      in () end
    | trans_conditional (env as (_, g, _), (tid, tedge), (fid, fedge)) exp = let
        val (state', exp') = trans_exp env exp false
        val id = commit g (change_state (state', T.COND exp'))
        val G.GRAPH graph = g
      in
        #add_edge graph (id, tid, tedge);
        #add_edge graph (id, fid, fedge)
      end

  (* trans_stm : 'a -> A.stm -> Label.label * Label.label -> T.program
   *
   * Translates statements from the AST to the IL representation. This assumes
   * that the AST has no for loops
   *
   * @param env the current environment so far
   * @param stms the list of statements to convert from the AST
   * @param (break, continue) labels of where to go if we're translating a
            break or continue statement.
   * @return a list of statements in the IL.
   *)
  fun trans_stm (env as (e, g, _)) (A.Assign (e1, oper_opt, e2)) _ = let
        fun unmark (A.Marked data) = unmark (Mark.data data)
          | unmark e = e

        val (s', e1'') = trans_exp env e1 true
        val e1' = case unmark e1
                    of (A.ArrSub (_, _, t) | A.Deref (_, t)) =>
                         T.MEM (e1'', trans_typ (!t))
                     | (A.Field (_, id, t)) => let
                         val (_, typ) = struct_off (#structs e) (!t) id
                       in
                         T.MEM(e1'', typ)
                       end
                     | _ => e1''
        val (s'', e2') = trans_exp (e, g, s') e2 false
        val e3' =
          case oper_opt
            of SOME oper => T.BINOP (trans_oper oper, e1', e2')
             | NONE => e2'
      in
        change_state (s'', T.MOVE (e1', e3'))
      end
    | trans_stm (env as (e, g, _)) (A.If (exp, s1, s2)) lp = let
        val (tid, fid) = (new_id g, new_id g)
        val _ = trans_conditional (env, (tid, T.TRUE), (fid, T.FALSE)) exp
        val tstate = trans_stm (e, g, ([], [], tid)) s1 lp
        val fstate = trans_stm (e, g, ([], [], fid)) s2 lp
        val tid' = commit g tstate
        val fid' = commit g fstate
      in ([], [(tid', T.BRANCH), (fid', T.ALWAYS)], new_id g) end
    | trans_stm (env as (e, g, state)) (A.While (exp, s)) _ = let
        val pred = commit g state
        val G.GRAPH graph = g
        val (eid, bid, endid) = (new_id g, new_id g, new_id g)
        val _ = trans_conditional ((e, g, ([], [(pred, T.ALWAYS)], eid)),
                                   (bid, T.TRUE), (endid, T.FALSE)) exp
        val blist = ref []
        val bstate = trans_stm (e, g, ([], [], bid)) s (blist, eid)
        val bid' = commit g bstate
        val _ = #add_edge graph (bid', eid, T.ALWAYS)
      in ([], !blist, endid) end
    | trans_stm (_, g, state) A.Continue (_, cexp) = let
        val id = commit g state
        val G.GRAPH graph = g
      in #add_edge graph (id, cexp, T.BRANCH); ([], [], new_id g) end
    | trans_stm (_, g, state) A.Break (blist, _) =
        (blist := (commit g state, T.BRANCH) :: (!blist);
         ([], [], new_id g))
    | trans_stm (env as (_, g, _)) (A.Return e) _ = let
        val (state, e') = trans_exp env e false
        val _ = commit g (change_state (state, T.RETURN e'))
      in ([], [], new_id g) end
    | trans_stm (env as (e, g, _)) (A.Seq (s1, s2)) lp = let
        val state = trans_stm env s1 lp
      in trans_stm (e, g, state) s2 lp end
    | trans_stm (e as {temps, ...}, g, state) (A.Declare (id, typ, stm)) lp =
      let
        val e' = Symbol.bind temps (id, (Temp.new (), trans_typ typ))
        val newenv = {temps=e', funs=(#funs e), classes=(#classes e),
                      cur_class=(#cur_class e), cur_fun=(#cur_fun e),
                      structs=(#structs e)}
      in trans_stm (newenv, g, state) stm lp end
    | trans_stm env (A.Express e) _ = let
        val t = T.TEMP ((Temp.new(), ref ~1), T.QUAD)
        val (state, e') = trans_exp env e false
      in change_state (state, T.MOVE (t, e')) end
    | trans_stm (_, _, state) A.Nop _ = state
    | trans_stm env (A.Markeds data) lp = trans_stm env (Mark.data data) lp
    | trans_stm _ (A.For _) _ = raise Fail "no for loops!"

  (* translate_fun : 'a -> Ast.gdecl -> T.func
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param (funs, structs) the known functions and structs so far
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun trans_fun (classes, funs, structs, class) (lbl, typ, name, args, body) =
      let
        fun bind ((typ, id), e) =
              Symbol.bind e (id, (Temp.new (), trans_typ typ))
        val temps = foldr bind Symbol.empty args
        val graph_rec = DG.graph (Label.name lbl,
                                  DynArray.array (10, ~1), 10)
        val G.GRAPH g = graph_rec
        val id = new_id graph_rec
        val env = {classes=classes, funs=funs, structs=structs, cur_class=class,
                   temps=temps, cur_fun=name} : env
        val state = trans_stm (env, graph_rec, ([], [], id))
                              (A.remove_for body A.Nop)
                              (ref [], ~1)
        val _ = commit graph_rec (change_state (state, T.RETURN (constq 0)))
        val _ = #set_entries g [id]
        val targs = map (fn (_, id) => Symbol.look' temps id) args
      in
        SOME (lbl, trans_typ typ, targs, graph_rec)
      end
  and translate_fun (classes, funs, structs) (A.Fun (typ, name, args, body)) =
        trans_fun (classes, funs, structs, NONE)
                  (Label.intfunc (Symbol.name name), typ, name, args, body)
    | translate_fun (classes, funs, structs)
                    (A.CFun (class, typ, name, args, body)) =
        let val this = (A.PTR (A.CLASS class), Symbol.symbol "this") in
          trans_fun (classes, funs, structs, SOME class)
                    (scopedl (class, name), typ, name,
                     this::args, body)
        end
    | translate_fun env (A.Markedg data) = translate_fun env (Mark.data data)
    | translate_fun _ _ = NONE

  (* translate : Ast.program -> T.program
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate p = let
        fun build_funs (A.ExtDecl (t, id, L), s) =
              Symbol.bind s (id, (true, trans_typ t,
                                  map trans_typ (#1 (ListPair.unzip L))))
          | build_funs (A.Fun (t, id, L, _), s) =
              Symbol.bind s (id, (false, trans_typ t,
                                  map trans_typ (#1 (ListPair.unzip L))))
          | build_funs (A.CFun (c, t, id, L, b), s) =
              let val this = (A.PTR (A.CLASS c), Symbol.symbol "this") in
                build_funs (A.Fun (t, scoped (c, id), this::L, b), s)
              end
          | build_funs (A.Markedg data, s) = build_funs (Mark.data data, s)
          | build_funs (_, s) = s
        val funs = foldr build_funs Symbol.empty p

        fun field_size structs ((typ, id), (s, n)) = let
              val size = typ_size structs typ
              val pad = if size = 0 orelse n mod size = 0 then 0
                        else 4 (* TODO: real math *)
              val typ' = trans_typ typ
            in
              (Symbol.bind s (id, (n + pad, typ')), n + pad + size)
            end
        fun cfield_size structs (A.CField f, fs) = field_size structs (f, fs)
          | cfield_size structs (A.Markedc data, fs) =
              cfield_size structs (Mark.data data, fs)
          | cfield_size structs (_, fs) = fs
        fun build_struct (A.Struct (id, L), s) =
              Symbol.bind s (id, foldl (field_size s) (Symbol.empty, 0) L)
          | build_struct (A.Class (id, L, parent), s) = let
              val base = case parent
                           of NONE     => (Symbol.empty, 8)
                            | SOME ext => Symbol.look' s ext
              in
                Symbol.bind s (id, foldl (cfield_size s) base L)
              end
          | build_struct (A.Markedg data, s) = build_struct (Mark.data data, s)
          | build_struct (_, s) = s
        val structs = foldl build_struct Symbol.empty p

        fun cfun_idx class (A.CFunDecl (_, id, _), s) = let
              val idx = case Symbol.look s id
                          of SOME (idx, _) => idx
                           | NONE => Symbol.count s
            in Symbol.bind s (id, (idx, class)) end
          | cfun_idx class (A.Markedc data, s) =
              cfun_idx class (Mark.data data, s)
          | cfun_idx _ (_, s) = s
        fun build_classes (A.Class (id, L, parent), c) = let
              val base = case parent
                           of NONE     => Symbol.empty
                            | SOME ext => #1 (Symbol.look' c ext)
              in
                Symbol.bind c (id, (foldl (cfun_idx id) base L, parent))
              end
          | build_classes (A.Markedg data, c) =
              build_classes (Mark.data data, c)
          | build_classes (_, c) = c
        val classes = foldl build_classes Symbol.empty p

        (*val _ = dump_classes classes
        val _ = dump_funs funs*)

        fun get_vtable ((class, (tbl, _)), map) = Symbol.bind map (class, tbl)
        val vtable  = foldl get_vtable Symbol.empty (Symbol.elemsi classes)
      in
        (List.mapPartial (translate_fun (classes, funs, structs)) p,
         vtable)
      end

end
