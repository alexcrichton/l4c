(* L4 Compiler
 * AST -> IR translator
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TRANS =
sig
  val translate : Ast.program -> Tree.program
end

structure Trans :> TRANS =
struct

  structure A = Ast
  structure T = Tree
  structure G = Graph
  structure DG = DirectedGraph(DynArray)
  structure HT = HashTable

  type struct_table = ((int * T.typ) Symbol.table * int) Symbol.table

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

  fun address (T.MEM (a, _)) = a
    | address b = b

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

  (* trans_exp : 'a -> A.exp -> T.stm list * T.exp
   *
   * Translates an AST expression into an IR expression.
   *
   * @param env the environment so far
   * @param exp the expression to convert
   *
   * @return A tuple of statements and an IR expression. The statement list is
   *         commands that need to be executed beforehand, and the expression
   *         contains the result of this operation.
   *)
  fun trans_exp (_, _, env) (A.Var id) _ = let
        val (temp, typ) = Symbol.look' env id
      in
        ([], T.TEMP (temp, ~1, typ))
      end
    | trans_exp _ (A.Bool b) _ = ([], const (if b then 1 else 0))
    | trans_exp _ (A.Const w) _ = ([], T.CONST (w, T.WORD))
    | trans_exp env (A.UnaryOp (A.NEGATIVE, A.Const w)) _ =
        ([], T.CONST(~w, T.WORD))
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
    | trans_exp env (A.BinaryOp (oper, e1, e2)) a = let
        val (e1s, e1') = trans_exp env e1 a
        val (e2s, e2') = trans_exp env e2 a
        val (stms, e)  = (e1s @ e2s, T.BINOP (trans_oper oper, e1', e2'))
      in
        if oper <> A.DIVIDEDBY andalso oper <> A.MODULO then (stms, e)
        else
          (* Divides and mods can have side effects. Make sure that they always
             happen by moving the result of the operation into a temp *)
          let val t = T.TEMP(Temp.new(), ~1, T.WORD) in
            (stms @ [T.MOVE (t, e)], t)
          end
      end
    | trans_exp env (A.Ternary (e1, e2, e3, ref typ)) a = let
        val (l1, l2) = (Label.new "ternary_true", Label.new "ternary_end")
        val t = T.TEMP (Temp.new(), ~1, trans_typ typ)
        val (e1s, e1') = trans_exp env e1 false
        val (e2s, e2') = trans_exp env e2 a
        val (e3s, e3') = trans_exp env e3 a
      in
        (e1s @ [T.GOTO (l1, SOME e1')] @
         e3s @ [T.MOVE (t, e3'), T.GOTO (l2, NONE), T.LABEL l1] @
         e2s @ [T.MOVE (t, e2'), T.LABEL l2], t)
      end
    | trans_exp (env as (funs, _, _)) (A.Call (name, EL)) _ = let
        fun ev (d, (instrs, dests)) = let
              val (dinstrs, dest) = trans_exp env d false
            in (dinstrs @ instrs, dest::dests) end
        val (instrs, args) = foldr ev ([], []) EL
        val (isext, rettyp, argtyps) = Symbol.look' funs name
        val label =
          if isext then Label.extfunc (Symbol.name name)
          else Label.intfunc (Symbol.name name)
        val result = T.TEMP (Temp.new(), ~1, rettyp)
        val call = T.CALL (label, rettyp, ListPair.zip (args, argtyps))
      in
        (instrs @ [T.MOVE (result, call)], result)
      end
    | trans_exp _ A.Null _ = ([], constq 0)
    | trans_exp (env as (_, structs, _)) (A.AllocArray (typ, e)) _ = let
        val (es, e') = trans_exp env e false
      in
        (es, T.CALL (Label.extfunc "calloc", T.QUAD,
                     [(e', T.QUAD), (constq (typ_size structs typ), T.QUAD)]))
      end
    | trans_exp (_, structs, _) (A.Alloc typ) _ =
        ([], T.CALL (Label.extfunc "calloc", T.QUAD,
                     [(constq 1, T.QUAD),
                      (constq (typ_size structs typ), T.QUAD)]))
    | trans_exp (env as (_, structs, _)) (A.ArrSub (e1, e2, ref typ)) a = let
        val (e1s, e1') = trans_exp env e1 false
        val (e2s, e2') = trans_exp env e2 false
        val offset = T.BINOP(T.MUL, e2', const (typ_size structs typ))
        val dest = T.MEM (T.BINOP (T.ADD, e1', offset), trans_typ typ)
      in
        if a then (e1s @ e2s, address dest)
        else let val t = T.TEMP (Temp.new(), ~1, trans_typ typ) in
          (e1s @ e2s @ [T.MOVE (t, dest)], t)
        end
      end
        (*(e1s @ e2s, if a then address dest else dest) end*)
    | trans_exp env (A.Deref (e, ref typ)) a = let
        val (es, e') = trans_exp env e false
      in
        if a then (es, e')
        else let val t = T.TEMP (Temp.new(), ~1, trans_typ typ) in
          (es @ [T.MOVE (t, T.MEM(e', trans_typ typ))], t)
        end
      end
    | trans_exp env (A.Field (e, id, ref typ)) a = let
        val (es, e') = trans_exp env e true
        val (off, size) = struct_off env typ id
        val dest = T.MEM (T.BINOP (T.ADD, address e', const off), size)
      in
        if a then (es, address dest)
        else let val t = T.TEMP (Temp.new(), ~1, size) in
          (es @ [T.MOVE (t, dest)], t)
        end
      end
    | trans_exp env (A.Marked data) a = trans_exp env (Mark.data data) a

  fun commit (G.GRAPH g) block preds = let
        val nid = #new_id g ()
        val _ = if List.length (#entries g ()) <> 0 then ()
                else #set_entries g [nid]
      in
        #add_node g (nid, block);
        app (fn (pred, edge) => #add_edge g (pred, nid, edge)) preds;
        nid
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
  fun trans_stm (env, _, stms, preds) (A.Assign (e1, oper_opt, e2)) _ = let
        fun unmark (A.Marked data) = unmark (Mark.data data)
          | unmark e = e

        val (e1s, e1'') = trans_exp env e1 true
        val e1' = case unmark e1
                    of (A.ArrSub (_,_,t) | A.Deref (_,t)) =>
                       T.MEM (e1'', trans_typ (!t))
                     | (A.Field (_, id, t)) => let
                         val (_, typ) = struct_off env (!t) id
                       in
                         T.MEM(e1'', typ)
                       end
                     | _ => e1''
        val (e2s, e2') = trans_exp env e2 false
        val (e3s, e3') =
          case oper_opt
            of SOME oper => (e2s, T.BINOP (trans_oper oper, e1', e2'))
              | NONE => (e2s, e2')
      in
        (stms @ e1s @ e3s @ [T.MOVE (e1', e3')], preds)
      end
    | trans_stm (env, g, stms, preds) (A.If(e, s1, s2)) lp = let
        val (es, e') = trans_exp env e false
        val id = commit g (stms @ es @ [T.COND e']) preds
        val (tstms, tpreds) = trans_stm (env, g, [], [(id, T.TRUE)]) s1 lp
        val (fstms, fpreds) = trans_stm (env, g, [], [(id, T.FALSE)]) s2 lp
        val tid = commit g tstms tpreds
        val fid = commit g fstms fpreds
      in ([], [(tid, T.ALWAYS), (fid, T.ALWAYS)]) end
    | trans_stm (env, g, stms, preds) (A.While (e, s)) _ = let
        val pred = commit g stms preds
        val (es, e') = trans_exp env e false
        val eid = commit g (es @ [T.COND e']) [(pred, T.ALWAYS)]
        val blist = ref []
        val (bstms, bpreds) = trans_stm (env, g, [], [(eid, T.TRUE)]) s
                                        (blist, eid)
        val bid = commit g bstms bpreds
        val G.GRAPH graph = g
        val _ = #add_edge graph (bid, eid, T.ALWAYS)
      in ([], (eid, T.FALSE) :: (!blist)) end
    | trans_stm (_, g, stms, preds) A.Continue (_, cexp) = let
        val id = commit g stms preds
        val G.GRAPH graph = g
      in #add_edge graph (id, cexp, T.ALWAYS); ([], []) end
    | trans_stm (_, g, stms, preds) A.Break (blist, _) =
        (blist := (commit g stms preds, T.ALWAYS) :: (!blist); ([], []))
    | trans_stm (env, g, stms, preds) (A.Return e) _ = let
        val (einstrs, e') = trans_exp env e false
        val _ = commit g (stms @ einstrs @ [T.RETURN e']) preds
      in ([], []) end
    | trans_stm (env as (f, g, _, _)) (A.Seq (s1, s2)) lp = let
        val (s', p') = trans_stm env s1 lp
      in trans_stm (f, g, s', p') s2 lp end
    | trans_stm ((f, s, e), g, stms, preds) (A.Declare (id, typ, stm)) lp = let
        val e' = Symbol.bind e (id, (Temp.new (), trans_typ typ))
      in trans_stm ((f, s, e'), g, stms, preds) stm lp end
    | trans_stm (env, _, stms, preds) (A.Express e) _ = let
        val t = T.TEMP (Temp.new(), ~1, T.QUAD) (* TODO: figure out type for real *)
        val (instrs, exp) = trans_exp env e false
      in (stms @ instrs @ [T.MOVE (t, exp)], preds) end
    | trans_stm (_, _, stms, preds) A.Nop _ = (stms, preds)
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
        fun bind ((typ, id), e) = Symbol.bind e (id, (Temp.new (), trans_typ typ))
        val e = foldr bind Symbol.empty args
        val table = HT.mkTable (Symbol.hash, Symbol.equal) (10, Fail "uh oh")
        val graph_rec = DG.graph (Symbol.name name, table, 10)
        val _ = app (fn (_, s) => HT.insert table (s, 1)) args
        val _ = trans_stm ((funs, structs, e), graph_rec, [], [])
                          (A.remove_for body A.Nop)
                          (ref [], ~1)
        val targs = map (fn (t, id) => (id, trans_typ t)) args
        val G.GRAPH g = graph_rec
        val order = GraphDFS.postorder_numbering (G.GRAPH g)
                                                 (List.hd (#entries g ()))
        val _ = Array.appi (fn (i, v) => if v >= 0 then ()
                                         else #remove_node g i) order
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
