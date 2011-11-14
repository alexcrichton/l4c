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

  type func_table = (bool * Tree.typ * Tree.typ list) Symbol.table
  type struct_table = ((int * T.typ) Symbol.table * int) Symbol.table
  type temp_table = (Temp.temp * Tree.typ) Symbol.table
  type env = func_table * struct_table * temp_table
  type state = T.stm list * (Graph.node_id * T.edge) list * Graph.node_id

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
    | typ_size _ _ = raise Fail "Invalid type"

  (* struct_off : 'a * 'b * 'c -> A.typ -> Symbol.symbol -> int
   *
   * Fetches the offset of a field in a struct
   * @param env the environment tuple, where the third element is the table of
   *        struct information
   * @param typ the struct type to lookup
   * @param field the name of the field to find the offset for
   * @return the offset of the field into the struct.
   *)
  fun struct_off (_, s : struct_table, _) (A.STRUCT id) field =
        Symbol.look' (#1 (Symbol.look' s id)) field
    | struct_off _ _ _ = raise Fail "Invalid struct"

  (* const : int -> T.exp
   *
   * Helper function to quickly go from an integer to a constant expression
   *)
  fun const n = T.CONST (Word32.fromInt n, T.WORD)
  fun constq n = T.CONST (Word32.fromInt n, T.QUAD)

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
  fun trans_exp ((_, _, env) : env, _ : T.cfgraph, state : state)
                (A.Var id) _ = let
        val (temp, typ) = Symbol.look' env id
      in
        (state, T.TEMP ((temp, ref ~1), typ))
      end
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
    | trans_exp ((e as (funs, _, _)), g, state) (A.Call (name, EL)) _ = let
        fun ev (d, (s, dests)) = let
              val (s', result) = trans_exp (e, g, s) d false
            in (s', dests @ [result]) end
        val (state', args) = foldl ev (state, []) EL
        val (isext, rettyp, argtyps) = Symbol.look' funs name
        val label =
          if isext then Label.extfunc (Symbol.name name)
          else Label.intfunc (Symbol.name name)
        val result = T.TEMP ((Temp.new(), ref ~1), rettyp)
        val call = T.CALL (label, rettyp, ListPair.zip (args, argtyps))
      in
        (change_state (state', T.MOVE (result, call)), result)
      end
    | trans_exp (_, _, state) A.Null _ = (state, constq 0)
    | trans_exp ((e as (_, structs, _)), g, state) (A.AllocArray (typ, exp)) _ =
      let
        val (state', e') = trans_exp (e, g, state) exp false
        val func = Label.extfunc (if safe () then "salloc_array" else "calloc")
        val temp = T.TEMP ((Temp.new(), ref ~1), T.QUAD)
        val call = T.CALL (func, T.QUAD,
                           [(e', T.QUAD),
                            (constq (typ_size structs typ), T.QUAD)])
      in
        (change_state (state', T.MOVE (temp, call)), temp)
      end
    | trans_exp ((_, structs, _), _, state) (A.Alloc typ) _ = let
        val func = Label.extfunc (if safe () then "salloc" else "calloc")
        val temp = T.TEMP ((Temp.new(), ref ~1), T.QUAD)
        val call = T.CALL (func, T.QUAD,
                           [(constq 1, T.QUAD),
                           (constq (typ_size structs typ), T.QUAD)])
      in
        (change_state (state, T.MOVE (temp, call)), temp)
      end
    | trans_exp (e, g, s) (A.ArrSub (e1, e2, ref typ)) a = let
        val (s', e1')  = trans_exp (e, g, s) e1 false
        val (s'', e2') = trans_exp (e, g, s') e2 false
        val (_, structs, _) = e
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
        val s' = protect_access (s', e')
      in
        if a then (s', e')
        else let val t = T.TEMP ((Temp.new(), ref ~1), trans_typ typ) in
          (change_state (s', T.MOVE (t, T.MEM(e', trans_typ typ))), t)
        end
      end
    | trans_exp (env as (e, _, _)) (A.Field (exp, id, ref typ)) a = let
        val (s', exp') = trans_exp env exp true
        val (off, size) = struct_off e typ id
        val addr = T.BINOP (T.ADD, exp', const off)
        val dest = T.MEM (addr, size)
      in
        if a then (s', addr)
        else let val t = T.TEMP ((Temp.new(), ref ~1), size) in
          (change_state (s', T.MOVE (t, dest)), t)
        end
      end
    | trans_exp env (A.Marked data) a = trans_exp env (Mark.data data) a

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
                         val (_, typ) = struct_off e (!t) id
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
        val (state, e') = trans_exp env exp false
        val id = commit g (change_state (state, T.COND e'))
        val (tid, fid) = (new_id g, new_id g)
        val tstate = trans_stm (e, g, ([], [(id, T.TRUE)], tid)) s1 lp
        val fstate = trans_stm (e, g, ([], [(id, T.FALSE)], fid)) s2 lp
        val tid = commit g tstate
        val fid = commit g fstate
      in ([], [(tid, T.BRANCH), (fid, T.ALWAYS)], new_id g) end
    | trans_stm (env as (e, g, state)) (A.While (exp, s)) _ = let
        val pred = commit g state
        val G.GRAPH graph = g
        val eid = new_id g
        val (state, e') = trans_exp (e, g, ([], [(pred, T.ALWAYS)], eid))
                                    exp false
        val eid' = commit g (change_state (state, T.COND e'))
        val blist = ref []
        val bstate = trans_stm (e, g, ([], [(eid', T.TRUE)], new_id g)) s
                               (blist, eid)
        val bid = commit g bstate
        val _ = #add_edge graph (bid, eid, T.ALWAYS)
      in ([], (eid', T.FALSE) :: (!blist), new_id g) end
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
    | trans_stm (env as (f, g, _)) (A.Seq (s1, s2)) lp = let
        val state = trans_stm env s1 lp
      in trans_stm (f, g, state) s2 lp end
    | trans_stm ((f, s, e), g, state) (A.Declare (id, typ, stm)) lp = let
        val e' = Symbol.bind e (id, (Temp.new (), trans_typ typ))
      in trans_stm ((f, s, e'), g, state) stm lp end
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
  fun translate_fun (funs, structs) (A.Fun (typ, name, args, body)) = let
        fun bind ((typ, id), e) =
              Symbol.bind e (id, (Temp.new (), trans_typ typ))
        val e = foldr bind Symbol.empty args
        val graph_rec = DG.graph (Symbol.name name, (), 10)
        val G.GRAPH g = graph_rec
        val id = new_id graph_rec
        val _ = trans_stm ((funs, structs, e), graph_rec, ([], [], id))
                          (A.remove_for body A.Nop)
                          (ref [], ~1)
        val _ = #set_entries g [id]
        val targs = map (fn (_, id) => Symbol.look' e id) args
      in
        SOME (Label.intfunc (Symbol.name name), trans_typ typ, targs, graph_rec)
      end
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
          | build_funs (_, s) = s
        val funs = foldr build_funs Symbol.empty p
        fun field_size structs ((typ, id), (s, n)) = let
              val size = typ_size structs typ
              val pad = if n mod size = 0 then 0 else 4 (* TODO: real math *)
              val typ' = trans_typ typ
            in
              (Symbol.bind s (id, (n + pad, typ')), n + pad + size)
            end
        fun build_struct (A.Struct (id, L), s) =
              Symbol.bind s (id, foldl (field_size s) (Symbol.empty, 0) L)
          | build_struct (_, s) = s
        val structs = foldl build_struct Symbol.empty p
      in List.mapPartial (translate_fun (funs, structs)) p end

end
