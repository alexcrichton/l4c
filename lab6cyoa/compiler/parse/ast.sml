(* L5 Compiler
 * Abstract Syntax Trees
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature AST =
sig
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident | PTR of typ | ARRAY of typ
               | STRUCT of ident | NULL | CLASS of ident

  datatype unop =
     NEGATIVE
   | INVERT
   | BANG

  datatype binop =
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | LESS
   | LESSEQ
   | GREATER
   | GREATEREQ
   | EQUALS
   | NEQUALS
   | LAND
   | LOR
   | BAND
   | XOR
   | BOR
   | LSHIFT
   | RSHIFT

  type param = typ * ident

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp * typ ref
   | Call of ident * exp list
   | Deref of exp * typ ref
   | Field of exp * ident * typ ref
   | Invoke of exp * ident * exp list
   | ArrSub of exp * exp * typ ref
   | Alloc of typ
   | AllocArray of typ * exp
   | Allocate of ident * exp list
   | Null
   | This
   | Marked of exp Mark.marked
  and stm =
     Assign  of exp * binop option * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * stm
   | Markeds of stm Mark.marked

  datatype cdecl =
     CFunDecl of typ * ident * param list
   | CField   of typ * ident
   | Markedc  of cdecl Mark.marked

  datatype gdecl =
     Fun     of typ * ident * param list * stm
   | CFun    of ident * typ * ident * param list * stm
   | ExtDecl of typ * ident * param list
   | IntDecl of typ * ident * param list
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked
   | StrDecl of ident
   | Struct  of ident * param list
   | Class   of ident * cdecl list * ident option

  type program = gdecl list

  (* print as source, with redundant parentheses *)
  structure Print :
  sig
    val pp_typ : typ -> string
    val pp_program : program -> string
  end

  val elaborate  : program -> program
  val elaborate_external : program -> program
  val remove_for : stm -> stm -> stm

end

structure Ast :> AST =
struct
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident | PTR of typ | ARRAY of typ
               | STRUCT of ident | NULL | CLASS of ident

  datatype unop =
     NEGATIVE
   | INVERT
   | BANG

  datatype binop =
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | LESS
   | LESSEQ
   | GREATER
   | GREATEREQ
   | EQUALS
   | NEQUALS
   | LAND
   | LOR
   | BAND
   | XOR
   | BOR
   | LSHIFT
   | RSHIFT

  type param = typ * ident

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp * typ ref
   | Call of ident * exp list
   | Invoke of exp * ident * exp list
   | Deref of exp * typ ref
   | Field of exp * ident * typ ref
   | ArrSub of exp * exp * typ ref
   | Alloc of typ
   | AllocArray of typ * exp
   | Allocate of ident * exp list
   | Null
   | This
   | Marked of exp Mark.marked
  and stm =
     Assign  of exp * binop option * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * stm
   | Markeds of stm Mark.marked

  datatype cdecl =
     CFunDecl of typ * ident * param list
   | CField   of typ * ident
   | Markedc  of cdecl Mark.marked

  datatype gdecl =
     Fun     of typ * ident * param list * stm
   | CFun    of ident * typ * ident * param list * stm
   | ExtDecl of typ * ident * param list
   | IntDecl of typ * ident * param list
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked
   | StrDecl of ident
   | Struct  of ident * param list
   | Class   of ident * cdecl list * ident option

  type program = gdecl list

  fun resolve_typ types ext (TYPEDEF id) =
       (case Symbol.look (!types) id
          of SOME t => t
           | NONE   => (ErrorMsg.error ext ("Undefined type: " ^
                        Symbol.name id); raise ErrorMsg.Error))
    | resolve_typ types ext (PTR typ) = PTR (resolve_typ types ext typ)
    | resolve_typ types ext (ARRAY typ) = ARRAY (resolve_typ types ext typ)
    | resolve_typ _ _ typ = typ

  (* elaborate : program -> program
   *
   * @param program the raw AST of the parser, a program which has not yet
   *                been elaborated
   *
   * @return an elaborated version of the AST which fixes structure the parser
   *         would have trouble knowing about
   * @raise ErrorMsg.Error if the AST is invalid. Possible examples are
   *        that any function/variables is called the same as a typdef
   *        declaration, typedef declarations can't be resolved, etc.
   *)
  fun elaborate prog = let
        val efuns   = ref Symbol.null
        val funs    = ref Symbol.null
        val structs = ref Symbol.null
        val types   = ref Symbol.empty
        val classes = ref Symbol.empty

        val resolve = resolve_typ types

        fun check_id ext id = case Symbol.look (!types) id
              of SOME _ => (ErrorMsg.error ext ("'" ^ Symbol.name id ^
                            "' already a type"); raise ErrorMsg.Error)
               | NONE   => ()
        and check_set_id str set ext id =
            if Symbol.member set id then
              (ErrorMsg.error ext (str ^ " '" ^ Symbol.name id ^
               "' already defined"); raise ErrorMsg.Error)
            else ()
        and check_params ext L = let
              fun validate ((t, id), (L, s)) =
                if Symbol.member s id then
                  (ErrorMsg.error ext ("Duplicate argument parameter: '" ^
                                       Symbol.name id ^ "'");
                   raise ErrorMsg.Error)
                else (check_id ext id;
                      ((resolve ext t, id)::L, Symbol.add s id))
            in
              rev (#1 (foldl validate ([], Symbol.null) L))
            end

        fun elaborate_gdecl _ (Markedg mark) =
              Markedg (Mark.mark' (elaborate_gdecl (Mark.ext mark)
                                                   (Mark.data mark),
                                   Mark.ext mark))
          | elaborate_gdecl ext (Fun (typ, id, params, body)) =
              (check_set_id "Function" (!efuns) ext id; check_id ext id;
               check_set_id "Function" (!funs) ext id;
               funs := Symbol.add (!funs) id;
               Fun (resolve ext typ, id, check_params ext params,
                    elaborate_stm (!types, ext) body))
          | elaborate_gdecl ext (p as Typedef (id, typ)) =
              (check_id ext id; check_set_id "Function" (!efuns) ext id;
               check_set_id "Function" (!funs) ext id;
               types := Symbol.bind (!types) (id, resolve ext typ); p)
          | elaborate_gdecl ext (ExtDecl (typ, id, params)) =
              (check_id ext id; efuns := Symbol.add (!efuns) id;
               ExtDecl (resolve ext typ, id, check_params ext params))
          | elaborate_gdecl ext (IntDecl (typ, id, params)) =
              (check_id ext id;
               IntDecl (resolve ext typ, id, check_params ext params))
          | elaborate_gdecl ext (StrDecl id) = StrDecl id
          | elaborate_gdecl ext (Struct (id, fields)) = let
              val _ = (check_set_id "Struct" (!structs) ext id)
              val s = Struct (id, map (fn (t, f) =>
                                          (resolve_typ types ext t, f)) fields)
            in
              structs := Symbol.add (!structs) id; s
            end
          | elaborate_gdecl ext (Class (id, decls, extends)) =
              (classes := Symbol.bind (!classes) (id, Symbol.null);
               Class (id, map (elaborate_cdecl (!types) ext) decls, extends))
          | elaborate_gdecl ext (CFun (class, typ, id, params, body)) = let
              val set = Symbol.look' (!classes) class
            in
              check_set_id "Class function" set ext id;
              classes := Symbol.bind (!classes) (class, Symbol.add set id);
              CFun (class, resolve ext typ, id, check_params ext params,
                    elaborate_stm (!types, ext) body)
            end
      in map (elaborate_gdecl NONE) prog end

  and elaborate_stm env (Markeds mark) =
        Markeds (Mark.mark' (elaborate_stm env (Mark.data mark), Mark.ext mark))
    | elaborate_stm (env as (typs, ext)) (Declare (id, typ, stm)) =
        let val t = resolve_typ (ref typs) ext typ in
          Declare (id, t, elaborate_stm env stm)
        end
    | elaborate_stm env (For (Declare(id, typ, s1), e, s2, s3)) =
        elaborate_stm env (Declare (id, typ, For (s1, e, s2, s3)))
    | elaborate_stm env (For (Markeds mark, e, s2, s3)) =
        elaborate_stm env (For (Mark.data mark, e, s2, s3))
    | elaborate_stm env (For (s1, e, s2, s3)) =
        For (elaborate_stm env s1, elaborate_exp env e, elaborate_stm env s2,
             elaborate_stm env s3)
    | elaborate_stm env (If (e, s1, s2)) =
        If (elaborate_exp env e, elaborate_stm env s1, elaborate_stm env s2)
    | elaborate_stm env (While (e, s)) =
        While (elaborate_exp env e, elaborate_stm env s)
    | elaborate_stm env (Seq (Declare (id, typ, s1), s2)) =
        elaborate_stm env (Declare (id, typ, Seq (s1, s2)))
    | elaborate_stm env (Seq (Markeds mark, s2)) =
        Markeds (Mark.mark' (elaborate_stm env (Seq (Mark.data mark, s2)),
                             Mark.ext mark))
    | elaborate_stm env (Seq (s1, s2)) =
        Seq (elaborate_stm env s1, elaborate_stm env s2)
    | elaborate_stm env (Express e) = Express (elaborate_exp env e)
    | elaborate_stm env (Return e) = Return (elaborate_exp env e)
    | elaborate_stm env (Assign (Marked mark, s, e2)) =
        elaborate_stm env (Assign (Mark.data mark, s, e2))
    | elaborate_stm env (Assign (Var id, SOME oper, e2)) =
        elaborate_stm env (Assign (Var id, NONE, BinaryOp (oper, Var id, e2)))
    | elaborate_stm env (Assign (e1, s, e2)) =
        Assign (elaborate_exp env e1, s, elaborate_exp env e2)
    | elaborate_stm _ (s as (Continue | Break | Nop)) = s

  and elaborate_exp (typs, _) (Marked mark) =
        Marked (Mark.mark' (elaborate_exp (typs, Mark.ext mark)
                                          (Mark.data mark), Mark.ext mark))
    | elaborate_exp env (BinaryOp (b, e1, e2)) =
        BinaryOp (b, elaborate_exp env e1, elaborate_exp env e2)
    | elaborate_exp env (UnaryOp (b, e)) = UnaryOp (b, elaborate_exp env e)
    | elaborate_exp env (Ternary (e1, e2, e3, t)) =
        Ternary (elaborate_exp env e1, elaborate_exp env e2,
                 elaborate_exp env e3, t)
    | elaborate_exp env (Call (l, L)) = Call (l, map (elaborate_exp env) L)
    | elaborate_exp env (Deref (e, t)) = Deref (elaborate_exp env e, t)
    | elaborate_exp env (Field (e, i, t)) = Field (elaborate_exp env e, i, t)
    | elaborate_exp env (ArrSub (e1, e2, t)) =
        ArrSub (elaborate_exp env e1, elaborate_exp env e2, t)
    | elaborate_exp (typs, ext) (Alloc typ) =
        Alloc (resolve_typ (ref typs) ext typ)
    | elaborate_exp (env as (typs, ext)) (AllocArray (typ, e)) =
        AllocArray (resolve_typ (ref typs) ext typ, elaborate_exp env e)
    | elaborate_exp env (Allocate (id, E)) =
          Allocate (id, map (elaborate_exp env) E)
    | elaborate_exp env (Invoke (e, id, E)) =
        Invoke (elaborate_exp env e, id, map (elaborate_exp env) E)
    | elaborate_exp _ (e as (Null | Const _ | Var _ | Bool _ | This)) = e

  and elaborate_cdecl env _ (Markedc data) =
        Markedc (Mark.mark' (elaborate_cdecl env (Mark.ext data)
                                             (Mark.data data),
                             Mark.ext data))
    | elaborate_cdecl env ext (CField (typ, id)) =
        CField (resolve_typ (ref env) ext typ, id)
    | elaborate_cdecl env ext (CFunDecl (typ, id, L)) =
        CFunDecl (resolve_typ (ref env) ext typ, id,
                  map (fn (t, i) => (resolve_typ (ref env) ext t, i)) L)

  (* elaborate_external : program -> program
   *
   * Elaborates a parsed external file. This is meant to be called on parsed
   * header files. It's not allowed for headers to define functions.
   *
   * @param prog the program to elaborate. All instances of an IntDecl are
   *        converted to an ExtDecl
   * @raise ErrorMsg.Error if the header defines any functions
   *)
  fun elaborate_external prog = map (elaborate_ext_gdecl NONE) prog
  and elaborate_ext_gdecl _ (Markedg m) =
        Markedg (Mark.mark' (elaborate_ext_gdecl (Mark.ext m) (Mark.data m),
                             Mark.ext m))
    | elaborate_ext_gdecl ext (Fun (_, _, _, _)) =
        (ErrorMsg.error ext "Headers can't define functions!";
         raise ErrorMsg.Error)
    | elaborate_ext_gdecl _ (IntDecl (t, id, typs)) = ExtDecl (t, id, typs)
    | elaborate_ext_gdecl _ (ExtDecl (_, _, _)) =
        raise Fail "Invalid AST (elaborate_ext_gdecl)"
    | elaborate_ext_gdecl _ gdecl = gdecl

  (* remove_for : stm -> stm -> stm
   *
   * Transforms an AST to make it easier to perform analysis on.
   * This involves changing for loops to while loops.
   *
   * @param stm the statement to transform
   * @param stm what to replace Continues with (Nop if invoked the first time)
   * @param an AST without any for loops (they're converted to while loops)
   *)
  fun remove_for (For (s1, e, s2, s3)) _ =
        Seq (s1, While (e, Seq(remove_for s3 s2, s2)))
    | remove_for (If (e, s1, s2)) rep =
        If (e, remove_for s1 rep, remove_for s2 rep)
    | remove_for (While (e, s)) _ = While (e, remove_for s Nop)
    | remove_for Continue s = Seq (s, Continue)
    | remove_for (Markeds mark) s =
        Markeds (Mark.mark' (remove_for (Mark.data mark) s, Mark.ext mark))
    | remove_for (Seq (s1, s2)) r = Seq (remove_for s1 r, remove_for s2 r)
    | remove_for (Declare (id, typ, s)) r = Declare (id, typ, remove_for s r)
    | remove_for s _ = s

  (* print programs and expressions in source form
   * using redundant parentheses to clarify precedence
   *)
  structure Print =
  struct
    fun pp_ident id = Symbol.name id
    fun pp_typ BOOL = "bool"
      | pp_typ INT  = "int"
      | pp_typ NULL = "(null)"
      | pp_typ (PTR t)  = pp_typ t ^ "*"
      | pp_typ (STRUCT id)  = "struct " ^ pp_ident id
      | pp_typ (ARRAY t)  = pp_typ t ^ "[]"
      | pp_typ (TYPEDEF id)  = pp_ident id
      | pp_typ (CLASS id)  = pp_ident id

    fun pp_unop NEGATIVE = "-"
      | pp_unop INVERT   = "~"
      | pp_unop BANG     = "!"

    fun pp_oper PLUS      = "+"
      | pp_oper MINUS     = "-"
      | pp_oper TIMES     = "*"
      | pp_oper DIVIDEDBY = "/"
      | pp_oper MODULO    = "%"
      | pp_oper LESS      = "<"
      | pp_oper LESSEQ    = "<="
      | pp_oper GREATER   = ">"
      | pp_oper GREATEREQ = ">="
      | pp_oper EQUALS    = "=="
      | pp_oper NEQUALS   = "!="
      | pp_oper LAND      = "&&"
      | pp_oper LOR       = "||"
      | pp_oper BAND      = "&"
      | pp_oper XOR       = "^"
      | pp_oper BOR       = "|"
      | pp_oper LSHIFT    = "<<"
      | pp_oper RSHIFT    = ">>"

    fun pp_exp (Var id) = pp_ident id
      | pp_exp (Const c) = Word32Signed.toString c
      | pp_exp (Bool b) = if b then "true" else "false"
      | pp_exp This = "this"
      | pp_exp Null = "NULL"
      | pp_exp (Deref (e, _)) = "*(" ^ pp_exp e ^ ")"
      | pp_exp (ArrSub (e1, e2, _)) = "(" ^ pp_exp e1 ^ "[" ^ pp_exp e2 ^ "])"
      | pp_exp (Field (e, f, _)) = "(" ^ pp_exp e ^ "." ^ pp_ident f ^ ")"
      | pp_exp (Alloc t) = "alloc(" ^ pp_typ t ^ ")"
      | pp_exp (AllocArray (t, e)) =
          "alloc_array(" ^ pp_typ t ^ "," ^ pp_exp e ^ ")"
      | pp_exp (Call (id, E)) =
          pp_ident id ^ "(" ^ String.concatWith ", " (map pp_exp E) ^ ")"
      | pp_exp (BinaryOp (oper, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_oper oper ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (UnaryOp (oper, e)) = pp_unop oper ^ "(" ^ pp_exp e ^ ")"
      | pp_exp (Ternary (e1, e2, e3, _)) =
          "((" ^ pp_exp e1 ^ ") ? (" ^ pp_exp e2 ^ ") : (" ^ pp_exp e3 ^ "))"
      | pp_exp (Invoke (e, id, E)) = pp_exp e ^ "." ^ pp_exp (Call (id, E))
      | pp_exp (Allocate (id, E)) = "new " ^ pp_ident id ^ "(" ^
          String.concatWith ", " (map pp_exp E) ^ ")"
      | pp_exp (Marked marked_exp) = pp_exp (Mark.data marked_exp)

    fun tab str = "  " ^ (String.translate
      (fn c => if c = #"\n" then "\n  " else (String.str c)) str)

    fun pp_stm (Assign (e1, NONE, e2)) = pp_exp e1 ^ " = " ^ pp_exp e2 ^ ""
      | pp_stm (Assign (e1, SOME oper, e2)) =
          pp_exp e1 ^ " " ^ pp_oper oper ^ "= " ^ pp_exp e2 ^ ""
      | pp_stm (If (e, s1, s2)) =
          "if (" ^ pp_exp e ^ ") {\n" ^ tab(pp_stm s1) ^ "\n} else {\n" ^
          pp_stm s2 ^ "\n}"
      | pp_stm (While (e, s)) = "while (" ^ pp_exp e ^ ") {\n" ^
          tab (pp_stm s) ^ "\n}"
      | pp_stm (For (s1, e, s2, s3)) = "for (" ^ pp_stm s1 ^ "; " ^ pp_exp e ^
          "; " ^ pp_stm s2 ^ ") {\n" ^ tab(pp_stm s3) ^ "\n}"
      | pp_stm Continue = "continue"
      | pp_stm Break = "break"
      | pp_stm Nop = ""
      | pp_stm (Express e) = pp_exp e
      | pp_stm (Seq (Nop, Nop)) = ""
      | pp_stm (Seq (Nop, s)) = pp_stm s
      | pp_stm (Seq (s, Nop)) = pp_stm s
      | pp_stm (Seq (s1, s2)) = pp_stm s1 ^ "\n" ^ pp_stm s2
      | pp_stm (Return e) = "return " ^ pp_exp e ^ ";"
      | pp_stm (Declare (id, t, s)) = pp_typ t ^ " " ^ pp_ident id ^ "\n" ^
          tab(pp_stm s)
      | pp_stm (Markeds (marked_stm)) = pp_stm (Mark.data marked_stm)

    fun pp_def (typ, id) = pp_typ typ ^ " " ^ pp_ident id

    fun pp_extends NONE = ""
      | pp_extends (SOME id) = "extends " ^ pp_ident id

    fun pp_cdecl (Markedc data) = pp_cdecl (Mark.data data)
      | pp_cdecl (CField (typ, id)) = pp_typ typ ^ " " ^ pp_ident id ^ ";"
      | pp_cdecl (CFunDecl d) = pp_adecl (IntDecl d)

    and pp_adecl (Typedef (id, typ)) =
          "typedef " ^ Symbol.name id ^ " " ^ pp_typ typ
      | pp_adecl (Markedg d) = pp_adecl (Mark.data d)
      | pp_adecl (IntDecl (t, i, L)) =
          pp_typ t ^ " " ^ pp_ident i ^ "(" ^
          String.concatWith ", " (map pp_def L) ^ ")"
      | pp_adecl (ExtDecl t) = "extern " ^ pp_adecl (IntDecl t)
      | pp_adecl (Fun (t, i, L, s)) =
          pp_adecl (IntDecl (t, i, L)) ^ "{\n" ^ tab(pp_stm s) ^ "\n}"
      | pp_adecl (CFun (klass, t, i, L, s)) =
          pp_typ t ^ " " ^ pp_ident klass ^ "::" ^ pp_ident i ^ "(" ^
            String.concatWith ", " (map pp_def L) ^ ")" ^ "{\n" ^
            tab (pp_stm s) ^ "\n}"
      | pp_adecl (StrDecl s) = "struct " ^ pp_ident s ^ ";"
      | pp_adecl (Struct (s, F)) = "struct " ^ pp_ident s ^ " {\n" ^
          tab (String.concatWith "\n" (map pp_def F)) ^ "\n}"
      | pp_adecl (Class (id, L, ext)) = "class " ^ pp_ident id ^ " " ^
          pp_extends ext ^ " {\n" ^
          tab (String.concatWith "\n" (map pp_cdecl L)) ^ "\n}"

    fun pp_program prog = foldl (fn (d, s) => s ^ pp_adecl d ^ "\n") "" prog
  end
end
