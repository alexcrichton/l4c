(* L5 Compiler
 * TypeChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

structure TypeChecker :> ANALYSIS =
struct
  structure A = Ast
  structure LP = ListPair

  val err = ErrorMsg.error
  fun str sym = "`" ^ Symbol.name sym ^ "'"

  (* typ_name : A.typ -> string
   * Helper method to get a string description of a type
   *)
  val typ_name = A.Print.pp_typ

  (* typs_equal : A.typ * A.typ -> bool
   *
   * @return true if the two types are the same
   *)
  fun typs_equal (A.BOOL, A.BOOL) = true
    | typs_equal (A.INT, A.INT)   = true
    | typs_equal (A.NULL, A.NULL) = true
    | typs_equal ((A.PTR _, A.NULL)|(A.NULL, A.PTR _)) = true
    | typs_equal (A.PTR t1, A.PTR t2) = typs_equal (t1, t2)
    | typs_equal (A.ARRAY t1, A.ARRAY t2) = typs_equal (t1, t2)
    | typs_equal (A.STRUCT s1, A.STRUCT s2) = Symbol.equal (s1, s2)
    | typs_equal (A.FUN (t1, L1), A.FUN (t2, L2)) =
        typs_equal (t1, t2) andalso ListPair.allEq typs_equal (L1, L2)
    | typs_equal _ = false

  (* type_small : A.typ -> bool
   *
   * @return true if the given type is a small type
   *)
  fun type_small (A.STRUCT _) = false
    | type_small _ = true

  (* is_lvalue : A.exp -> bool
   *
   * @return true if the given expressionc an be considered an lvalue
   *)
  fun is_lvalue (A.Var _) = true
    | is_lvalue (A.Field (e, _, _)) = is_lvalue e
    | is_lvalue (A.Deref (e, _)) = is_lvalue e
    | is_lvalue (A.ArrSub (e, _, _)) = is_lvalue e
    | is_lvalue (A.Marked e) = is_lvalue (Mark.data e)
    | is_lvalue _ = false

  (* ensure_small : Mark.ext option -> typ -> unit
   *
   * Ensures that a type is small by raising an exception otherwise.
   * @raise ErrorMsg.Error if the type is large
   *)
  fun ensure_small ext t = if type_small t then () else
                            (err ext ("Type must be small: " ^ typ_name t);
                             raise ErrorMsg.Error)

  (* ensure_typ_defined : Mark.ext option -> 'a -> A.typ
   *
   * Ensures that the provided type is defined and available for allocation.
   * Currently, this only applies to structs, which could possibly have been
   * forward-declared, but not defined just yet.
   *
   * @param ext the current extents in the file
   * @param env the current environment of known structs
   * @param typ the type in question
   * @raise ErrorMsg.Error if the given type is not defined for allocation
   *)
  fun ensure_typ_defined ext (_, structs, _) (A.STRUCT id) =
        (case Symbol.look structs id
           of SOME(SOME _) => ()
            | _ => (err ext ("Struct not defined: " ^ str id);
                    raise ErrorMsg.Error))
    | ensure_typ_defined _ _ _ = ()

  (* tc_equal : A.typ * A.typ -> Mark.ext option -> unit
   *
   * @param t1, t2 the types to test for equivalence
   * @param ext    the extent that these types show up in
   *
   * @raise ErrorMsg.Error if the types are not equal
   *)
  fun tc_equal (t1, t2) ext = if typs_equal (t1, t2) then () else (
        err ext ("type mismatch, " ^ typ_name t1 ^ " != " ^ typ_name t2);
        raise ErrorMsg.Error)

  (* resolve_struct : Mark.ext option -> 'a -> Symbol.symbol -> Symbol.symbol
   *                                  -> typ
   *
   * @param ext the extents of the current expression
   * @param structs a table of known structs
   * @param id the name of the struct to look up
   * @param field the name of the field to look up
   *
   * @return the type of the field, if it exists
   * @raise ErrorMsg.Error if the struct does not exist, is not defined, or
   *        the field does not exist
   *)
  fun resolve_struct ext structs id field = let
        val s = case Symbol.look structs id
                  of SOME t => t
                   | NONE => (err ext ("Undeclared struct: " ^ str id);
                              raise ErrorMsg.Error)
        val table = case s of SOME t => t
                        | NONE => (err ext ("Undefined struct: " ^ str id);
                                   raise ErrorMsg.Error)
      in
        case Symbol.look table field
          of SOME typ => typ
           | NONE => (err ext ("Unknown field " ^ str field);
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
  fun tc_ensure env (e, t) ext = tc_equal (t, tc_exp env e ext) ext

  (* tc_exp : 'a -> A.exp -> Mark.ext option -> A.typ
   *
   * Typecheck a single expression.
   *
   * @param env the currently known environment
   * @param exp the expression to typecheck
   * @param ext the current extents of the statement in the source file
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return the type of the expression if it is well formed
   *)
  and tc_exp (env' as (funs, _, env)) (A.Var id) ext =
      (case Symbol.look env id
         of SOME t => t
          | NONE => case Symbol.look funs id
                      of SOME (t, typs, _) => A.PTR (A.FUN (t, typs))
                       | _ => (err ext ("undeclared variable " ^ str id);
                               raise ErrorMsg.Error))
    | tc_exp env (A.Call (e, args, r)) ext =
        (case tc_exp env e ext
           of A.PTR (A.FUN (t, types)) => let
                fun tc_args ([], []) = ()
                  | tc_args (e::E, t::T) =
                      (tc_ensure env (e, t) ext; tc_args (E, T))
                  | tc_args _ = (err ext ("Wrong number of variables");
                                 raise ErrorMsg.Error)
              in
                tc_args (args, types);
                r := (t, types);
                t
              end
            | _ => (err ext "not a function!"; raise ErrorMsg.Error))
    | tc_exp _ (A.Bool _) _ = A.BOOL
    | tc_exp _ (A.Const _) _ = A.INT
    | tc_exp _ A.Null _ = A.NULL
    | tc_exp env (A.Alloc typ) ext = (ensure_typ_defined ext env typ; A.PTR typ)
    | tc_exp env (A.AllocArray (typ, e)) ext =
        (tc_ensure env (e, A.INT) ext; ensure_typ_defined ext env typ;
         A.ARRAY typ)
    | tc_exp (env as (_, structs, _)) (A.Field (e, field, tr)) ext =
        (case tc_exp env e ext
           of (t as A.STRUCT id) => (tr := t;
                                     resolve_struct ext structs id field)
            | _ => (err ext "Should have a struct type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.ArrSub (e1, e2, r)) ext =
        (tc_ensure env (e2, A.INT) ext;
         case tc_exp env e1 ext
           of A.ARRAY typ => (r := typ; typ)
            | _ => (err ext "Should have an array type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.Deref (e, tref)) ext =
        (case tc_exp env e ext
           of A.PTR typ => (tref := typ; typ)
            | _ => (err ext "Should have a pointer type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.BinaryOp ((A.LESS | A.GREATER | A.GREATEREQ | A.LESSEQ),
                              e1, e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.BOOL)
    | tc_exp env (A.BinaryOp ((A.EQUALS | A.NEQUALS), e1, e2)) ext = let
        val t1 = tc_exp env e1 ext
      in
        (tc_ensure env (e2, t1) ext; ensure_small ext t1; A.BOOL)
      end
    | tc_exp env (A.BinaryOp ((A.LOR | A.LAND), e1, e2)) ext =
        (tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e2, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (_, e1, e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.INT)
    | tc_exp env (A.UnaryOp (A.BANG, e)) ext =
        (tc_ensure env (e, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.UnaryOp (_, e)) ext = (tc_ensure env (e, A.INT) ext; A.INT)
    | tc_exp env (A.Ternary (e1, e2, e3, tref)) ext = let
        val t2 = tc_exp env e2 ext
      in
        tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e3, t2) ext;
        tref := t2; t2
      end
    | tc_exp env (A.Marked marked_exp) _ =
        tc_exp env (Mark.data marked_exp) (Mark.ext marked_exp)

  (* tc_stm : 'a -> Ast.stm -> Mark.ext option -> (bool * A.typ) -> unit
   *
   * Typecheck a single statement in a program.
   *
   * @param env    the currently known environment
   * @param stm    the statement to typecheck
   * @param ext    the current extents of the statement in the source file
   * @param lp,typ true if we're inside of a loop & the return type
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return nothing
   *)
  fun tc_stm env (A.Assign (e1, _, e2)) ext _ = let
        val typ1 = tc_exp env e1 ext
      in
        if is_lvalue e1 then (tc_ensure env (e2, typ1) ext;
                              ensure_small ext typ1)
        else (err ext "not an lvalue"; raise ErrorMsg.Error)
      end
    | tc_stm env (A.If (e, s1, s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s1 ext lp;
         tc_stm env s2 ext lp)
    | tc_stm env (A.While (e, s)) ext (_, typ) =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext (true, typ))
    | tc_stm env (A.DoWhile (e, s)) ext (_, typ) =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext (true, typ))
    | tc_stm env (A.For (s, e, s1, s2)) ext (lp, typ) =
        (tc_ensure env (e, A.BOOL) ext; tc_stm env s ext (lp, typ);
         tc_stm env s1 ext (true, typ); tc_stm env s2 ext (true, typ))
    | tc_stm _ A.Continue ext (lp, _) = if lp then () else (
        err ext "'continue' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm _ A.Break ext (lp, _) = if lp then () else (
        err ext "'break' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm env (A.Return e) ext (_, typ) = tc_ensure env (e, typ) ext
    | tc_stm env (A.Express e) ext _ = (tc_exp env e ext; ())
    | tc_stm _ A.Nop _ _ = ()
    | tc_stm env (A.Seq (s1, s2)) ext lp =
        (tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm (g as (funs, structs, env)) (A.Declare (id, t, exp, s)) ext lp =
        (ensure_small ext t;
        case Symbol.look env id
          of SOME _ => (err ext ("Redeclared variable: " ^ str id);
                        raise ErrorMsg.Error)
           | NONE   => (case exp of NONE => ()
                           | SOME exp => tc_ensure g (exp, t) ext;
                        tc_stm (funs, structs, Symbol.bind env (id, t)) s ext
                               lp))
    | tc_stm env (A.Markeds marked_stm) _ lp =
        tc_stm env (Mark.data marked_stm) (Mark.ext marked_stm) lp

  (* analyze : A.program -> unit
   *
   * Performs static analysis on the program to typecheck it. An error is raised
   * if there is a type problem, otherwise nothing happens.
   *
   * @param prog the program to typecheck
   *)
  fun analyze L = let
        val funs = ref Symbol.empty
        val structs = ref Symbol.empty

        (* helper function to bind a function definition into the function
           table, raising an error if necessary *)
        fun bind_fun ext (typ, id, params, st) = let
              val types = #1 (LP.unzip params)
              val _ = app (ensure_small ext) (typ::types)
            in
              case Symbol.look (!funs) id
                of NONE => (funs := Symbol.bind (!funs) (id, (typ, types, st)))
                 | SOME (t, T, st') =>
                    (if st = st' then ()
                     else (err ext ("static attribute of " ^ str id ^
                                    " changed");
                           raise ErrorMsg.Error);
                     tc_equal (t, typ) ext;
                     (LP.appEq (fn ts => tc_equal ts ext) (types, T))
              handle UnequalLengths =>
                (err ext ("Function " ^ str id ^
                          " has a different number of args than before");
                 raise ErrorMsg.Error))
            end

        (* Binds a structs definition in the structs table *)
        fun bind_struct ext (id, fields) = let
              fun add_field ((typ, ident), tbl) = (
                    (* field types cannot be nested structs and embedded
                       structs must be defined beforehand *)
                    case typ
                      of A.STRUCT id' =>
                          if Symbol.equal (id, id') then
                            (err ext ("Cannot define nested structure");
                             raise ErrorMsg.Error)
                          else (case Symbol.look (!structs) id'
                            of SOME (SOME _) => ()
                             | _ => (err ext ("Struct size unknown: "
                                              ^ str id'); raise ErrorMsg.Error))
                       | _ => ();
                    case Symbol.look tbl ident
                      of NONE => Symbol.bind tbl (ident, typ)
                       | _ => (err ext ("Duplicate field: " ^ str ident);
                               raise ErrorMsg.Error))
              val table = foldl add_field Symbol.empty fields
            in
              case Symbol.look (!structs) id
                of SOME (SOME T) => raise Fail "Redefined struct"
                 | _ => structs := Symbol.bind (!structs) (id, SOME table)
            end

        (* tc_gdecl : Mark.ext option -> A.gdecl
         *
         * Typechecks one global declaration of a program at a time. This
         * function also builds up the environment as we walk through the
         * program.
         *)
        fun tc_gdecl _ (A.Markedg data) =
              tc_gdecl (Mark.ext data) (Mark.data data)
          | tc_gdecl ext (A.ExtDecl (t, i, L)) = bind_fun ext (t, i, L, false)
          | tc_gdecl ext (A.IntDecl d) = bind_fun ext d
          | tc_gdecl ext (A.Typedef (_, _)) = ()
          | tc_gdecl ext (A.StrDecl id) =
              (case Symbol.look (!structs) id
                of NONE => structs := Symbol.bind (!structs) (id, NONE)
                 | SOME _ => ())
          | tc_gdecl ext (A.Struct s) = bind_struct ext s
          | tc_gdecl ext (A.Fun (typ, ident, args, stm, st)) = let
              fun bind_arg ((typ, id), env) = (ensure_small ext typ;
                     case Symbol.look env id
                       of SOME t => (err ext ("Duplicate argument name: "
                                              ^ str id);
                                     raise ErrorMsg.Error)
                        | NONE => Symbol.bind env (id, typ))
            in
              bind_fun ext (typ, ident, args, st);
              tc_stm (!funs, !structs, foldl bind_arg Symbol.empty args) stm
                     NONE (false, typ)
            end
      in app (tc_gdecl NONE) L end

end
