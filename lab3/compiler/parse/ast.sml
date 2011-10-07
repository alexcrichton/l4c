(* L3 Compiler
 * Abstract Syntax Trees
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature AST =
sig
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident

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

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp
   | Call of ident * exp list
   | Marked of exp Mark.marked
  and stm =
     Assign  of ident * exp
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

  datatype gdecl =
     Fun of typ * ident * stm list * stm
   | ExtDecl of typ * ident * typ list
   | IntDecl of typ * ident * typ list
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked

  type program = gdecl list

  (* print as source, with redundant parentheses *)
  structure Print :
  sig
    val pp_program : program -> string
  end

  val elaborate  : program -> program
  val elaborate_external : program -> program
  val remove_for : stm -> stm -> stm

end

structure Ast :> AST =
struct
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident

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

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp
   | Call of ident * exp list
   | Marked of exp Mark.marked
  and stm =
     Assign  of ident * exp
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

  datatype gdecl =
     Fun of typ * ident * stm list * stm
   | ExtDecl of typ * ident * typ list
   | IntDecl of typ * ident * typ list
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked

  type program = gdecl list

  fun resolve_typ types ext (TYPEDEF id) =
       (case Symbol.look (!types) id
          of SOME t => t
           | NONE   => (ErrorMsg.error ext ("Undefined type: " ^
                        Symbol.name id); raise ErrorMsg.Error))
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
        val (efuns, types, funs) = (ref Symbol.null, ref Symbol.empty,
                                    ref Symbol.null)

        val resolve = resolve_typ types

        fun check_id ext id = case Symbol.look (!types) id
              of SOME _ => (ErrorMsg.error ext ("'" ^ Symbol.name id ^
                            "' already a type"); raise ErrorMsg.Error)
               | NONE   => ()
        and check_fun_id set ext id =
            if Symbol.member set id then
              (ErrorMsg.error ext ("Function '" ^ Symbol.name id ^
               "' already defined"); raise ErrorMsg.Error)
            else ()

        fun elaborate_gdecl _ (Markedg mark) =
              elaborate_gdecl (Mark.ext mark) (Mark.data mark)
          | elaborate_gdecl ext (Fun (typ, id, params, body)) = let
              fun elaborate_param (Declare (id, typ, s)) =
                    (check_id ext id; Declare (id, resolve ext typ, s))
                | elaborate_param (Markeds d) = elaborate_param (Mark.data d)
                | elaborate_param _ = raise Fail "Invalid AST (elaborate_param)"

            in
              (check_fun_id (!efuns) ext id; check_id ext id;
               check_fun_id (!funs) ext id; funs := Symbol.add (!funs) id;
               Fun (resolve ext typ, id, map elaborate_param params, body))
            end
          | elaborate_gdecl ext (p as Typedef (id, typ)) =
              (check_id ext id; check_fun_id (!efuns) ext id;
               check_fun_id (!funs) ext id;
               types := Symbol.bind (!types) (id, resolve ext typ); p)
          | elaborate_gdecl ext (p as ExtDecl (typ, id, typs)) =
              (check_id ext id; resolve ext typ; map (resolve ext) typs;
               efuns := Symbol.add (!efuns) id; p)
          | elaborate_gdecl ext (p as IntDecl (typ, id, typs)) =
              (check_id ext id; resolve ext typ; map (resolve ext) typs; p)
      in map (elaborate_gdecl NONE) prog end
  and elaborate_stm env (Markeds mark) =
        Markeds (Mark.mark' (elaborate_stm env (Mark.data mark), Mark.ext mark))
    | elaborate_stm env (Declare (id, typ, stm)) =
        (* TODO: extent information *)
        (case Symbol.look env id
           of SOME t => (ErrorMsg.error NONE ("Variable name is a type: " ^
                         Symbol.name id); raise ErrorMsg.Error)
            | NONE => let val t = resolve_typ (ref env) NONE typ in
                        Declare (id, t, elaborate_stm env stm)
                      end)
    | elaborate_stm env (For (Declare(id, typ, s1), e, s2, s3)) =
        elaborate_stm env (Declare (id, typ, For (s1, e, s2, s3)))
    | elaborate_stm env (For (Markeds mark, e, s2, s3)) =
        elaborate_stm env (For (Mark.data mark, e, s2, s3))
    | elaborate_stm env (For (s1, e, s2, s3)) =
        For (elaborate_stm env s1, e, elaborate_stm env s2,
             elaborate_stm env s3)
    | elaborate_stm env (If (e, s1, s2)) =
        If (e, elaborate_stm env s1, elaborate_stm env s2)
    | elaborate_stm env (While (e, s)) = While (e, elaborate_stm env s)
    | elaborate_stm env (Seq (Declare (id, typ, s1), s2)) =
        elaborate_stm env (Declare (id, typ, Seq (s1, s2)))
    | elaborate_stm env (Seq (Markeds mark, s2)) =
        Markeds (Mark.mark' (elaborate_stm env (Seq (Mark.data mark, s2)),
                             Mark.ext mark))
    | elaborate_stm env (Seq (s1, s2)) =
        Seq (elaborate_stm env s1, elaborate_stm env s2)
    | elaborate_stm _ stm = stm

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
    | elaborate_ext_gdecl _ (t as Typedef (_, _)) = t

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
      | pp_typ (TYPEDEF id)  = pp_ident id

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
      | pp_exp (Call (id, E)) =
          pp_ident id ^ "(" ^ foldr (fn (e, s) => s ^ ", " ^ pp_exp e) "" E ^ ")"
      | pp_exp (BinaryOp (oper, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_oper oper ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (UnaryOp (oper, e)) = pp_unop oper ^ "(" ^ pp_exp e ^ ")"
      | pp_exp (Ternary (e1, e2, e3)) =
          "((" ^ pp_exp e1 ^ ") ? (" ^ pp_exp e2 ^ ") : (" ^ pp_exp e3 ^ "))"
      | pp_exp (Marked(marked_exp)) = pp_exp (Mark.data marked_exp)

    fun tab str = "  " ^ (String.translate
      (fn c => if c = #"\n" then "\n  " else (String.str c)) str)

    fun pp_stm (Assign (id, e)) = pp_ident id ^ " = " ^ pp_exp e ^ ""
      | pp_stm (If (e, s1, s2)) =
          "if (" ^ pp_exp e ^ ") {\n" ^ tab(pp_stm s1) ^ "\n} else {\n" ^
          pp_stm s2 ^ "\n}"
      | pp_stm (While (e, s)) = "while (" ^ tab(pp_exp e) ^ ") {\n" ^
          pp_stm s ^ " }"
      | pp_stm (For (s1, e, s2, s3)) = "for (" ^ pp_stm s1 ^ "; " ^ pp_exp e ^
          "; " ^ pp_stm s2 ^ ") {\n" ^ tab(pp_stm s3) ^ "\n}"
      | pp_stm Continue = "continue"
      | pp_stm Break = "break"
      | pp_stm Nop = ""
      | pp_stm (Express e) = pp_exp e
      | pp_stm (Seq (s1, s2)) = pp_stm s1 ^ "\n" ^ pp_stm s2
      | pp_stm (Return e) = "return " ^ pp_exp e ^ ";"
      | pp_stm (Declare (id, t, s)) = pp_typ t ^ " " ^ pp_ident id ^ "\n" ^
          tab(pp_stm s)
      | pp_stm (Markeds (marked_stm)) = pp_stm (Mark.data marked_stm)

    fun pp_adecl (Typedef (id, typ)) =
          "typedef " ^ Symbol.name id ^ " " ^ pp_typ typ
      | pp_adecl (Markedg d) = pp_adecl (Mark.data d)
      | pp_adecl (IntDecl (t, i, L)) =
          pp_typ t ^ " " ^ pp_ident i ^ "(" ^
          (foldl (fn (a, s) => s ^ ", " ^ pp_typ a) "" L) ^ ")"
      | pp_adecl (ExtDecl (t, i, L)) =
          "extern " ^ pp_typ t ^ " " ^ pp_ident i ^ "(" ^
          (foldl (fn (a, s) => s ^ ", " ^ pp_typ a) "" L) ^ ")"
      | pp_adecl (Fun (t, i, L, s)) =
          pp_typ t ^ " " ^ pp_ident i ^ "(" ^
          (foldl (fn (a, s) => s ^ ", " ^ pp_stm a) "" L) ^ ") {\n" ^
          tab(pp_stm s) ^ "\n}"

    fun pp_program prog = foldl (fn (d, s) => s ^ pp_adecl d ^ "\n") "" prog
  end
end
