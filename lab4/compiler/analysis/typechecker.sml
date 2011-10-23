(* L4 Compiler
 * TypeChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TYPE_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val typecheck : Ast.program -> unit
end;

structure TypeChecker :> TYPE_CHECK =
struct
  structure A = Ast
  structure LP = ListPair

  (* typ_name : A.typ -> string
   * Helper method to get a string description of a type
   *)
  fun typ_name A.BOOL = "bool"
    | typ_name A.INT  = "int"
    | typ_name A.NULL = "(null)"
    | typ_name (A.PTR typ) = (typ_name typ) ^ "*"
    | typ_name (A.ARRAY typ) = (typ_name typ) ^ "[]"
    | typ_name (A.STRUCT ident) = "struct " ^ Symbol.name ident
    | typ_name (A.TYPEDEF ident) = Symbol.name ident

  fun typs_equal (A.BOOL, A.BOOL) = true
    | typs_equal (A.INT, A.INT)   = true
    | typs_equal (A.NULL, A.NULL) = true
    | typs_equal ((A.PTR _, A.NULL)|(A.NULL, A.PTR _)) = true
    | typs_equal (A.PTR t1, A.PTR t2) = typs_equal (t1, t2)
    | typs_equal (A.ARRAY t1, A.ARRAY t2) = typs_equal (t1, t2)
    | typs_equal (A.STRUCT s1, A.STRUCT s2) = Symbol.equal (s1, s2)
    | typs_equal _ = false

  fun type_small (A.STRUCT _) = false
    | type_small _ = true

  fun is_lvalue (A.Var _) = true
    | is_lvalue (A.Field (e, _)) = is_lvalue e
    | is_lvalue (A.Deref e) = is_lvalue e
    | is_lvalue (A.ArrSub (e, _)) = is_lvalue e
    | is_lvalue (A.Marked e) = is_lvalue (Mark.data e)
    | is_lvalue _ = false

  fun ensure_small ext t = if type_small t then () else
                            (ErrorMsg.error ext ("Type must be small: " ^
                            typ_name t); raise ErrorMsg.Error)

  (* tc_equal : A.typ * A.typ -> Mark.ext option -> unit
   *
   * @param t1, t2 the types to test for equivalence
   * @param ext    the extent that these types show up in
   *
   * @raise ErrorMsg.Error if the types are not equal
   *)
  fun tc_equal (t1, t2) ext = if typs_equal (t1, t2) then () else (
        ErrorMsg.error ext ("type mismatch, " ^ typ_name t1 ^ " != " ^
                            typ_name t2);
        raise ErrorMsg.Error)

  fun resolve_struct ext structs id field = let
        val s = case Symbol.look structs id
                  of SOME t => t
                   | NONE => (ErrorMsg.error ext ("Undeclared struct: " ^
                                                  Symbol.name id);
                              raise ErrorMsg.Error)
        val table = case s of SOME t => t
                        | NONE => (ErrorMsg.error ext ("Undefined struct: " ^
                                                       Symbol.name id);
                                   raise ErrorMsg.Error)
      in
        case Symbol.look table field
          of SOME typ => typ
           | NONE => (ErrorMsg.error ext ("Unknown field " ^ Symbol.name field);
                      raise ErrorMsg.Error)
      end

  (* tc_ensure : A.typ Symbol.table -> A.exp * A.typ -> Mark.ext option -> unit
   *
   * Ensures that the provided statement is of the provided type.
   *
   * @param env see tc_exp and tc_stm
   * @param e   the expression to check
   * @param t   the expected type of the expression
   * @param ext see tc_exp and tc_stm
   *
   * @raise ErrorMsg.Error if there's a typecheck error or the expression isn't
   *                       of the expected type
   * @return nothing if the expression is of the right type.
   *)
  fun tc_ensure env (e,t) ext = tc_equal (t, tc_exp env e ext) ext

  (* tc_exp : A.typ Symbol.table -> A.exp -> Mark.ext option -> A.typ
   *
   * Typecheck a single expression.
   *
   * @param env the currently known environment of variables and their types
   * @param exp the expression to typecheck
   * @param ext the current extents of the statement in the source file
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return the type of the expression if it is well formed
   *)
  and tc_exp (env' as (_, _, env)) (A.Var id) ext =
      (case Symbol.look env id
         of NONE => (ErrorMsg.error ext ("undeclared variable `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error)
          | SOME t => t)
    | tc_exp (env' as (funs, _, env)) (A.Call (id, args)) ext =
      (case Symbol.look env id
         of SOME _ => (ErrorMsg.error ext ("'" ^ Symbol.name id ^ "' is not" ^
                                           " a function!");
                       raise ErrorMsg.Error)
          | NONE   => ();
      case Symbol.look funs id
         of NONE => (ErrorMsg.error ext ("undeclared function `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error)
          | SOME (t, types) => let
                        fun tc_args ([], []) = ()
                          | tc_args (e::E, t::T) =
                              (tc_ensure env' (e, t) ext; tc_args (E, T))
                          | tc_args _ = (ErrorMsg.error ext ("Wrong number of" ^
                                         " variables for: " ^ Symbol.name id);
                                         raise ErrorMsg.Error)
                      in
                        tc_args (args, types); t
                      end)
    | tc_exp _ (A.Bool _) _ = A.BOOL
    | tc_exp _ (A.Const _) _ = A.INT
    | tc_exp _ A.Null _ = A.PTR A.INT (* TODO: all types! *)
    | tc_exp _ (A.Alloc typ) _ = A.PTR typ
    | tc_exp env (A.AllocArray (typ, e)) ext =
        (tc_ensure env (e, A.INT) ext; A.ARRAY typ)
    | tc_exp (env as (_, structs, _)) (A.Field (e, field)) ext =
        (case tc_exp env e ext
           of A.STRUCT id => resolve_struct ext structs id field
            | _ => (ErrorMsg.error ext "Should have a struct type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.ArrSub (e1, e2)) ext =
        (tc_ensure env (e2, A.INT) ext;
         case tc_exp env e1 ext
           of A.ARRAY typ => typ
            | _ => (ErrorMsg.error ext "Should have an array type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.Deref e) ext =
        (case tc_exp env e ext
           of A.PTR typ => typ
            | _ => (ErrorMsg.error ext "Should have a pointer type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.BinaryOp (A.LESSEQ,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATER,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATEREQ,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.NEQUALS,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext =
        (tc_ensure env (e1, tc_exp env e2 ext) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.LAND,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext =
        (tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e2, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (_,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.INT)
    | tc_exp env (A.UnaryOp (A.BANG,e)) ext =
        (tc_ensure env (e, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.UnaryOp (_,e)) ext = (tc_ensure env (e, A.INT) ext; A.INT)
    | tc_exp env (A.Ternary (e1,e2,e3)) ext = let
        val t2 = tc_exp env e2 ext
      in
        tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e3, t2) ext; t2
      end
    | tc_exp env (A.Marked marked_exp) _ =
        tc_exp env (Mark.data marked_exp) (Mark.ext marked_exp)

  (* tc_stm : A.typ Symbol.table -> Ast.stm -> Mark.ext option -> bool -> unit
   *
   * Typecheck a single statement in a program.
   *
   * @param env    the currently known environment of variables and their types
   * @param stm    the statement to typecheck
   * @param ext    the current extents of the statement in the source file
   * @param lp,typ true if we're inside of a loop & the return type
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return nothing
   *)
  fun tc_stm (env' as (_,_,env)) (A.Assign (e1, _, e2)) ext _ =
        if is_lvalue e1 then tc_ensure env' (e2, tc_exp env' e1 ext) ext
        else (ErrorMsg.error ext "not an lvalue"; raise ErrorMsg.Error)
    | tc_stm env (A.If (e,s1,s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s1 ext lp;
         tc_stm env s2 ext lp)
    | tc_stm env (A.While (e,s)) ext (_, typ) =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext (true, typ))
    | tc_stm env (A.For (s,e,s1,s2)) ext (lp, typ) =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext (lp, typ);
         tc_stm env s1 ext (true, typ); tc_stm env s2 ext (true, typ))
    | tc_stm _ A.Continue ext (lp, _) = if lp then () else (
        ErrorMsg.error ext "'continue' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm _ A.Break ext (lp, _) = if lp then () else (
        ErrorMsg.error ext "'break' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm env (A.Return e) ext (_, typ) = tc_ensure env (e, typ) ext
    | tc_stm env (A.Express e) ext _ = (tc_exp env e ext; ())
    | tc_stm _ A.Nop _ _ = ()
    | tc_stm env (A.Seq (s1,s2)) ext lp =
        (tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm (funs, structs, env) (A.Declare (id,t,s)) ext lp =
        (ensure_small ext t;
        case Symbol.look env id
          of NONE   => tc_stm (funs, structs, Symbol.bind env (id, t)) s ext lp
           | SOME _ => (ErrorMsg.error ext ("Redeclared variable: " ^
                                             Symbol.name id);
                         raise ErrorMsg.Error))
    | tc_stm env (A.Markeds marked_stm) _ lp =
        tc_stm env (Mark.data marked_stm) (Mark.ext marked_stm) lp

  (* typecheck : A.program -> unit
   *
   * Performs static analysis on the program to typecheck it. An error is raised
   * if there is a type problem, otherwise nothing happens.
   *
   * @param prog the program to typecheck
   *)
  fun typecheck L = let
        val funs = ref Symbol.empty
        val structs = ref Symbol.empty

        fun bind_fun ext (typ, id, params) = let
              val types = #1 (LP.unzip params)
              val _ = app (ensure_small ext) (typ::types)
            in
              case Symbol.look (!funs) id
                of NONE => (funs := Symbol.bind (!funs) (id, (typ, types)))
                 | SOME(t, T) =>
                    (tc_equal (t, typ) ext;
                     LP.appEq (fn ts => tc_equal ts ext) (types, T))
              handle UnequalLengths =>
                (ErrorMsg.error ext ("Function '" ^ Symbol.name id ^ "' " ^
                                 "has a different number of args than before");
                 raise ErrorMsg.Error)
            end

        fun decl_struct _ id =
              case Symbol.look (!structs) id
                of NONE => structs := Symbol.bind (!structs) (id, NONE)
                 | SOME _ => ()

        fun bind_struct ext (id, fields) = let
              fun add_field ((typ, ident), tbl) = (
                    case typ
                      of (A.STRUCT id' | A.PTR (A.STRUCT id')) =>
                          if not (Symbol.equal (id, id')) then () else
                          (ErrorMsg.error ext "Cannot define nested structure";
                          raise ErrorMsg.Error)
                       | _ => ();
                    case Symbol.look tbl ident
                      of NONE => Symbol.bind tbl (ident, typ)
                       | _ => (ErrorMsg.error ext ("Duplicate field: " ^
                              Symbol.name ident); raise ErrorMsg.Error))
              val table = foldl add_field Symbol.empty fields
            in
              case Symbol.look (!structs) id
                of SOME (SOME T) => raise Fail "Redefined struct"
                 | _ => structs := Symbol.bind (!structs) (id, SOME table)
            end

        fun tc_gdecl _ (A.Markedg data) =
              tc_gdecl (Mark.ext data) (Mark.data data)
          | tc_gdecl ext (A.ExtDecl d) = bind_fun ext d
          | tc_gdecl ext (A.IntDecl d) = bind_fun ext d
          | tc_gdecl ext (A.Typedef (_, _)) = ()
          | tc_gdecl ext (A.StrDecl id) = decl_struct ext id
          | tc_gdecl ext (A.Struct s) = bind_struct ext s
          | tc_gdecl ext (A.Fun (typ, ident, args, stm)) = let
              fun bind_arg ((typ, id), env) =
                    (if type_small typ then case Symbol.look env id
                       of SOME t => (ErrorMsg.error ext ("Duplicate argument" ^
                                     " name: " ^ Symbol.name id);
                                     raise ErrorMsg.Error)
                        | NONE => Symbol.bind env (id, typ)
                     else (ErrorMsg.error ext ("Function arguments must " ^
                                               "have small types");
                           raise ErrorMsg.Error))
            in
              bind_fun ext (typ, ident, args);
              tc_stm (!funs, !structs, foldl bind_arg Symbol.empty args) stm
                     NONE (false, typ)
            end
      in app (tc_gdecl NONE) L end

end
