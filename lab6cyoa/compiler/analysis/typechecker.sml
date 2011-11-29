(* L5 Compiler
 * TypeChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

structure TypeChecker :> ANALYSIS =
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
    | typ_name (A.CLASS ident) = "class " ^ Symbol.name ident

  (* typs_equal : A.typ * A.typ -> bool
   *
   * @return true if the two types are the same
   *)
  fun typs_equal (A.BOOL, A.BOOL) = true
    | typs_equal (A.INT, A.INT)   = true
    | typs_equal (A.NULL, A.NULL) = true
    | typs_equal ((A.PTR _, A.NULL) | (A.NULL, A.PTR _)) = true
    | typs_equal (A.PTR t1, A.PTR t2) = typs_equal (t1, t2)
    | typs_equal (A.ARRAY t1, A.ARRAY t2) = typs_equal (t1, t2)
    | typs_equal (A.STRUCT s1, A.STRUCT s2) = Symbol.equal (s1, s2)
    | typs_equal (A.CLASS s1, A.CLASS s2) = Symbol.equal (s1, s2)
    | typs_equal _ = false

  (* type_small : A.typ -> bool
   *
   * @return true if the given type is a small type
   *)
  fun type_small (A.STRUCT _ | A.CLASS _) = false
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
                            (ErrorMsg.error ext ("Type must be small: " ^
                            typ_name t); raise ErrorMsg.Error)

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
  fun ensure_typ_defined ext (_, _, structs, _, _) (A.STRUCT id) =
        (case Symbol.look structs id
           of SOME(SOME _) => ()
            | _ => (ErrorMsg.error ext ("Struct not defined: " ^
                                        Symbol.name id);
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
        ErrorMsg.error ext ("type mismatch, " ^ typ_name t1 ^ " != " ^
                            typ_name t2);
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

  (* resolve_classes : Mark.ext option -> 'a -> Symbol.symbol -> Symbol.symbol
   *                                   -> typ
   *
   * @param ext the extents of the current expression
   * @param classes a table of known classes
   * @param id the name of the struct to look up
   * @param field the name of the field to look up
   *
   * @return the type of the field, if it exists
   * @raise ErrorMsg.Error if the struct does not exist, is not defined, or
   *        the field does not exist
   *)
  and resolve_class ext classes id field = let
        val (fields, _) = Symbol.look' classes id
      in
        case Symbol.look fields field
          of SOME typ => typ
           | NONE => (ErrorMsg.error ext ("Unknown field " ^ Symbol.name field);
                      raise ErrorMsg.Error)
      end

  (* find_ctor : classes -> Symbol.symbol
   *
   * Finds the constructor for a class in the classes table.
   * @return types - the types of the arguments for the constructor for this
   *         specified class
   *)
  fun find_ctor classes id = let
        fun sameclass (c1, (A.PTR (A.CLASS c2), _)) =
              Symbol.equal (c1, id) andalso Symbol.equal (c1, c2)
          | sameclass _ = false
        val (_, funs) = Symbol.look' classes id
        val (_, (_, types)) = valOf (List.find sameclass (Symbol.elemsi funs))
      in types end

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

  (* tc_args : 'a -> (A.exp list * A.typ list) -> unit
   *
   * Typechecks the arguments to a function, making sure that each argument
   * resolves to the correct type.
   *
   * @param (ext, id, env) the current extends, function name, and current
   *                       environment
   * @param (E, T) the expressions and types
   * @raise ErrorMsg.Error if there's a type error
   *)
  and tc_args _ ([], []) = ()
    | tc_args (ext, id, env) (e::E, t::T) =
        (tc_ensure env (e, t) ext; tc_args (ext, id, env) (E, T))
    | tc_args (ext, id, _) _ = (ErrorMsg.error ext ("Wrong number of" ^
                                " variables for: " ^ Symbol.name id);
                                raise ErrorMsg.Error)

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
  and tc_exp (env' as (_, _, _, env, _)) (A.Var id) ext =
      (case Symbol.look env id
         of NONE => (ErrorMsg.error ext ("undeclared variable `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error)
          | SOME t => t)
    | tc_exp (env' as (_, funs, _, env, _)) (A.Call (id, args)) ext =
      (case Symbol.look env id
         of SOME _ => (ErrorMsg.error ext ("'" ^ Symbol.name id ^ "' is not" ^
                                           " a function!");
                       raise ErrorMsg.Error)
          | NONE   => ();
      case Symbol.look funs id
         of NONE => (ErrorMsg.error ext ("undeclared function `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error)
          | SOME (t, types) => (tc_args (ext, id, env') (args, types); t))
    | tc_exp _ (A.Bool _) _ = A.BOOL
    | tc_exp _ (A.Const _) _ = A.INT
    | tc_exp _ A.Null _ = A.NULL
    | tc_exp (SOME class, _, _, _, _) A.Self _ = A.PTR (A.CLASS class)
    | tc_exp _ A.Self ext =
        (ErrorMsg.error ext "Cannot use 'self' outside of a class";
         raise ErrorMsg.Error)
    | tc_exp env (A.Alloc typ) ext =
        (case typ
           of A.CLASS _ => (ErrorMsg.error ext "Allocate a class with 'new'";
                            raise ErrorMsg.Error)
            | _ => (ensure_typ_defined ext env typ; A.PTR typ))
    | tc_exp env (A.AllocArray (typ, e)) ext =
        (case typ
           of A.CLASS _ => (ErrorMsg.error ext ("Cannot allocate arrays of " ^
                                                "classes, use pointers");
                            raise ErrorMsg.Error)
            | _ => (tc_ensure env (e, A.INT) ext;
                    ensure_typ_defined ext env typ; A.ARRAY typ))
    | tc_exp (env as (_, _, structs, _, classes)) (A.Field (e, field, tr)) ext =
        (case tc_exp env e ext
           of (t as A.STRUCT id) => (tr := t;
                                     resolve_struct ext structs id field)
            | (t as A.CLASS id) => (tr := t;
                                     resolve_class ext classes id field)
            | _ => (ErrorMsg.error ext "Should have a struct or class type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.ArrSub (e1, e2, r)) ext =
        (tc_ensure env (e2, A.INT) ext;
         case tc_exp env e1 ext
           of A.ARRAY typ => (r := typ; typ)
            | _ => (ErrorMsg.error ext "Should have an array type";
                    raise ErrorMsg.Error))
    | tc_exp env (A.Deref (e, tref)) ext =
        (case tc_exp env e ext
           of A.PTR typ => (tref := typ; typ)
            | _ => (ErrorMsg.error ext "Should have a pointer type";
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
    | tc_exp (env as (_, _, _, _, classes)) (A.Invoke (e, id, E)) ext =
       (case tc_exp env e ext
          of A.CLASS class => let
              val (_, funs) = Symbol.look' classes class
            in
              case Symbol.look funs id
                of SOME (ret, args) => (tc_args (ext, id, env) (E, args); ret)
                 | NONE => (ErrorMsg.error ext ("Unknown method '" ^
                                                Symbol.name id ^ "' for class: "
                                                ^ Symbol.name class);
                            raise ErrorMsg.Error)
            end
           | t => (ErrorMsg.error ext ("Cannot invoke method on " ^ typ_name t);
                   raise ErrorMsg.Error))
    | tc_exp (env as (_, _, _, _, classes)) (A.Allocate (id, E)) ext = let
          val ctor = find_ctor classes id
          val _ = tc_args (ext, id, env) (E, ctor)
        in A.PTR (A.CLASS id) end
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
        else (ErrorMsg.error ext "not an lvalue"; raise ErrorMsg.Error)
      end
    | tc_stm env (A.If (e, s1, s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s1 ext lp;
         tc_stm env s2 ext lp)
    | tc_stm env (A.While (e, s)) ext (_, typ) =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext (true, typ))
    | tc_stm env (A.For (s, e, s1, s2)) ext (lp, typ) =
        (tc_ensure env (e, A.BOOL) ext; tc_stm env s ext (lp, typ);
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
    | tc_stm env (A.Seq (s1, s2)) ext lp =
        (tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm (c, funs, structs, env, classes) (A.Declare (id, t, s)) ext lp =
        (ensure_small ext t;
        case Symbol.look env id
          of NONE   => tc_stm (c, funs, structs, Symbol.bind env (id, t),
                               classes) s ext lp
           | SOME _ => (ErrorMsg.error ext ("Redeclared variable: " ^
                                             Symbol.name id);
                         raise ErrorMsg.Error))
    | tc_stm env (A.Markeds marked_stm) _ lp =
        tc_stm env (Mark.data marked_stm) (Mark.ext marked_stm) lp

  (* munge_class : mark * A.cdecl list * Symbol.symbol
   *
   * Works with the list of declarations in a class to create the class metadata
   * for this class
   *
   * @param ext the extents we're looking at
   * @param decls the declarations for this class
   * @param class the name of the class we're creating
   * @return the class metadata
   * @raise ErrorMsg.Error if there's a problem with the declartions
   *)
  fun munge_class (ext, decls, class) = let
        fun add_decl _ (A.Markedc data, env) =
              add_decl (Mark.ext data) (Mark.data data, env)
          | add_decl ext (A.CField (t, id), (fields, funs)) =
             (case Symbol.look fields id
                of SOME _ => (ErrorMsg.error ext ("Duplicate field: " ^
                                                  Symbol.name id);
                              raise ErrorMsg.Error)
                 | NONE => (Symbol.bind fields (id, t), funs))
          | add_decl ext (A.CFunDecl (t, id, params), (fields, funs)) =
              case Symbol.look funs id
                of SOME _ => (ErrorMsg.error ext ("Duplicate method: " ^
                                                  Symbol.name id);
                              raise ErrorMsg.Error)
                 | NONE => (fields,
                            Symbol.bind funs (id, (t, #1 (LP.unzip params))))
      in
        foldl (add_decl ext) (Symbol.empty, Symbol.empty) decls
      end

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
        val classes = ref Symbol.empty

        (* helper function to bind a function definition into the function
           table, raising an error if necessary *)
        fun bind_fun funs ext (typ, id, params) =
              bind_fun_types funs ext (typ, id, #1 (LP.unzip params))
        and bind_fun_types funs ext (typ, id, types) = let
              val _ = app (ensure_small ext) (typ::types)
            in
              case Symbol.look funs id
                of NONE => Symbol.bind funs (id, (typ, types))
                 | SOME (t, T) =>
                    (tc_equal (t, typ) ext;
                     LP.appEq (fn ts => tc_equal ts ext) (types, T); funs)
              handle UnequalLengths =>
                (ErrorMsg.error ext ("Function '" ^ Symbol.name id ^ "' " ^
                                 "has a different number of args than before");
                 raise ErrorMsg.Error)
            end

        (* Binds a structs definition in the structs table *)
        fun bind_struct ext (id, fields) = let
              fun add_field ((typ, ident), tbl) = (
                    (* field types cannot be nested structs and embedded
                       structs must be defined beforehand *)
                    case typ
                      of A.STRUCT id' =>
                          if Symbol.equal (id, id') then
                            (ErrorMsg.error ext ("Cannot define nested " ^
                                                 "structure");
                             raise ErrorMsg.Error)
                          else (case Symbol.look (!structs) id'
                            of SOME (SOME _) => ()
                             | _ => (ErrorMsg.error ext ("Struct size unknown: "
                                     ^ Symbol.name id'); raise ErrorMsg.Error))
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

        fun merge_class _ class NONE = class
          | merge_class ext (fields, funs) (SOME parent) = let
              fun check_redefine _ NONE = ()
                | check_redefine id (SOME _) =
                    (ErrorMsg.error ext ("Redefined field: " ^ Symbol.name id);
                     raise ErrorMsg.Error)

              val (pfields, pfuns) = Symbol.look' (!classes) parent
              val _ = app (fn k => check_redefine k (Symbol.look pfields k))
                          (Symbol.keys fields)
              val funs' = foldl (fn ((f, (t, types)), funs) =>
                                    bind_fun_types funs ext (t, f, types))
                                funs (Symbol.elemsi pfuns)
            in
              (Symbol.merge (fields, pfields), funs')
            end

        fun bind_arg ext ((typ, id), env) = (ensure_small ext typ;
              case Symbol.look env id
                of SOME t => (ErrorMsg.error ext ("Duplicate argument" ^
                              " name: " ^ Symbol.name id);
                              raise ErrorMsg.Error)
                 | NONE => Symbol.bind env (id, typ))

        (* tc_gdecl : Mark.ext option -> A.gdecl
         *
         * Typechecks one global declaration of a program at a time. This
         * function also builds up the environment as we walk through the
         * program.
         *)
        fun tc_gdecl _ (A.Markedg data) =
              tc_gdecl (Mark.ext data) (Mark.data data)
          | tc_gdecl ext (A.ExtDecl d) = (funs := bind_fun (!funs) ext d)
          | tc_gdecl ext (A.IntDecl d) = (funs := bind_fun (!funs) ext d)
          | tc_gdecl ext (A.Typedef (_, _)) = ()
          | tc_gdecl ext (A.StrDecl id) =
              (case Symbol.look (!structs) id
                of NONE => structs := Symbol.bind (!structs) (id, NONE)
                 | SOME _ => ())
          | tc_gdecl ext (A.Struct s) = bind_struct ext s
          | tc_gdecl ext (A.Fun (typ, ident, args, stm)) =
             (funs := bind_fun (!funs) ext (typ, ident, args);
              tc_stm (NONE, !funs, !structs,
                      foldl (bind_arg ext) Symbol.empty args, !classes)
                     stm NONE (false, typ))
          | tc_gdecl ext (A.Class (id, decls, extends)) = let
              val class = munge_class (ext, decls, id)
            in
              classes := Symbol.bind (!classes)
                                     (id, merge_class ext class extends)
            end
          | tc_gdecl ext (A.CFun (class, typ, id, params, body)) = let
              val (cfields, cfuns) = Symbol.look' (!classes) class
              val (ret, args) =
                  case Symbol.look cfuns id
                    of NONE => (ErrorMsg.error ext (Symbol.name id ^
                                                    " not defined for class");
                                raise ErrorMsg.Error)
                     | SOME a => a
              val _ = bind_fun cfuns ext (typ, id, params)
            in
              tc_stm (SOME class, !funs, !structs,
                      foldl (bind_arg ext) cfields params, !classes)
                     body ext (false, typ)
            end
      in app (tc_gdecl NONE) L end

end
