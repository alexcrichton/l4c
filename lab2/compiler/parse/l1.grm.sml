functor L1LrValsFn (structure Token : TOKEN) = 
struct
structure ParserData=
struct
structure Header = 
struct
(* L1 Compiler
 * L1 grammar
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Now conforms to the L1 fragment of C0
 *)

structure A = Ast

(* for simplicity, we only mark expressions, not statements *)

(* mark e with region (left, right) in source file *)
fun mark (e, (left, right)) = A.Marked (Mark.mark' (e, ParseState.ext (left, right)))
fun marks (s, (left, right)) = A.Markeds (Mark.mark' (s, ParseState.ext (left, right)))

(* expand_asnop (id, "op=", exp) region = "id = id op exps"
 * or = "id = exp" if asnop is "="
 * syntactically expands a compound assignment operator
 *)
fun expand_asnop (id, NONE, exp) (left, right) =
      A.Assign(id, exp)
  | expand_asnop (id, SOME(oper), exp) (left, right) =
      A.Assign(id, mark(A.OpExp(oper, [A.Var(id), exp]), (left, right)))

fun check_main (sym, lpos, rpos) prog =
      if (Symbol.name sym) = "main" then
        prog
      else
        (ErrorMsg.error (ParseState.ext (lpos, rpos))
                        "Function must be called main"; prog)


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\000\000\000\000\
\\001\000\002\000\017\000\000\000\
\\001\000\002\000\026\000\000\000\
\\001\000\002\000\043\000\007\000\042\000\008\000\041\000\009\000\040\000\
\\010\000\039\000\011\000\038\000\000\000\
\\001\000\003\000\034\000\004\000\033\000\008\000\032\000\020\000\031\000\000\000\
\\001\000\004\000\004\000\000\000\
\\001\000\004\000\016\000\020\000\013\000\000\000\
\\001\000\004\000\029\000\000\000\
\\001\000\006\000\003\000\000\000\
\\001\000\007\000\042\000\008\000\041\000\009\000\040\000\010\000\039\000\
\\011\000\038\000\021\000\052\000\000\000\
\\001\000\012\000\024\000\013\000\023\000\014\000\022\000\015\000\021\000\
\\016\000\020\000\017\000\019\000\000\000\
\\001\000\018\000\007\000\000\000\
\\001\000\019\000\027\000\000\000\
\\001\000\020\000\005\000\000\000\
\\001\000\021\000\006\000\000\000\
\\001\000\021\000\036\000\000\000\
\\054\000\000\000\
\\055\000\012\000\037\000\000\000\
\\056\000\007\000\042\000\008\000\041\000\009\000\040\000\010\000\039\000\
\\011\000\038\000\000\000\
\\057\000\004\000\016\000\005\000\015\000\006\000\014\000\020\000\013\000\000\000\
\\058\000\000\000\
\\059\000\000\000\
\\060\000\000\000\
\\061\000\000\000\
\\062\000\000\000\
\\063\000\000\000\
\\064\000\007\000\042\000\008\000\041\000\009\000\040\000\010\000\039\000\
\\011\000\038\000\000\000\
\\065\000\000\000\
\\066\000\000\000\
\\067\000\000\000\
\\068\000\009\000\040\000\010\000\039\000\011\000\038\000\000\000\
\\069\000\009\000\040\000\010\000\039\000\011\000\038\000\000\000\
\\070\000\000\000\
\\071\000\000\000\
\\072\000\000\000\
\\073\000\000\000\
\\074\000\000\000\
\\075\000\000\000\
\\076\000\000\000\
\\077\000\000\000\
\\078\000\000\000\
\\079\000\000\000\
\"
val actionRowNumbers =
"\008\000\005\000\013\000\014\000\
\\011\000\019\000\001\000\010\000\
\\019\000\002\000\012\000\006\000\
\\007\000\004\000\024\000\021\000\
\\004\000\041\000\040\000\039\000\
\\038\000\037\000\036\000\020\000\
\\023\000\016\000\015\000\017\000\
\\003\000\004\000\004\000\029\000\
\\028\000\026\000\025\000\004\000\
\\004\000\004\000\004\000\004\000\
\\004\000\022\000\009\000\035\000\
\\018\000\034\000\033\000\032\000\
\\031\000\030\000\027\000\000\000"
val gotoT =
"\
\\001\000\051\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\010\000\003\000\009\000\004\000\008\000\005\000\007\000\
\\006\000\006\000\000\000\
\\000\000\
\\008\000\016\000\000\000\
\\002\000\023\000\003\000\009\000\004\000\008\000\005\000\007\000\
\\006\000\006\000\000\000\
\\000\000\
\\000\000\
\\005\000\026\000\000\000\
\\000\000\
\\007\000\028\000\000\000\
\\000\000\
\\000\000\
\\007\000\033\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\042\000\000\000\
\\007\000\043\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\044\000\000\000\
\\007\000\045\000\000\000\
\\007\000\046\000\000\000\
\\007\000\047\000\000\000\
\\007\000\048\000\000\000\
\\007\000\049\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 52
val numrules = 26
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | IDENT of unit ->  (Symbol.symbol)
 | INTCONST of unit ->  (Word32.word)
 | asnop of unit ->  (A.oper option) | exp of unit ->  (A.exp)
 | simp of unit ->  (A.stm) | lvalue of unit ->  (A.ident)
 | stmt of unit ->  (A.stm) | decl of unit ->  (A.stm)
 | stmts of unit ->  (A.stm list) | program of unit ->  (A.program)
end
type svalue = MlyValue.svalue
type result = A.program
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 0) => true | _ => false
val showTerminal =
fn (T 0) => "EOF"
  | (T 1) => "SEMI"
  | (T 2) => "INTCONST"
  | (T 3) => "IDENT"
  | (T 4) => "RETURN"
  | (T 5) => "INT"
  | (T 6) => "PLUS"
  | (T 7) => "MINUS"
  | (T 8) => "STAR"
  | (T 9) => "SLASH"
  | (T 10) => "PERCENT"
  | (T 11) => "ASSIGN"
  | (T 12) => "PLUSEQ"
  | (T 13) => "MINUSEQ"
  | (T 14) => "STAREQ"
  | (T 15) => "SLASHEQ"
  | (T 16) => "PERCENTEQ"
  | (T 17) => "LBRACE"
  | (T 18) => "RBRACE"
  | (T 19) => "LPAREN"
  | (T 20) => "RPAREN"
  | (T 21) => "UNARY"
  | (T 22) => "ASNOP"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16)
 $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9)
 $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.stmts stmts1
, _, _)) :: _ :: _ :: _ :: ( _, ( MlyValue.IDENT IDENT1, IDENTleft, 
IDENTright)) :: ( _, ( _, INT1left, _)) :: rest671)) => let val  
result = MlyValue.program (fn _ => let val  (IDENT as IDENT1) = IDENT1
 ()
 val  (stmts as stmts1) = stmts1 ()
 in (
check_main (IDENT, IDENTleft, IDENTright)
                                                  stmts
)
end)
 in ( LrTable.NT 0, ( result, INT1left, RBRACE1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.IDENT IDENT1, _, IDENT1right)) :: ( _, ( _, 
INT1left, _)) :: rest671)) => let val  result = MlyValue.decl (fn _ =>
 let val  (IDENT as IDENT1) = IDENT1 ()
 in (A.Declare IDENT)
end)
 in ( LrTable.NT 2, ( result, INT1left, IDENT1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _, INT1left, _)) :: rest671))
 => let val  result = MlyValue.decl (fn _ => let val  (IDENT as IDENT1
) = IDENT1 ()
 val  (exp as exp1) = exp1 ()
 in (A.Init (IDENT, exp))
end)
 in ( LrTable.NT 2, ( result, INT1left, exp1right), rest671)
end
|  ( 3, ( rest671)) => let val  result = MlyValue.stmts (fn _ => ([]))
 in ( LrTable.NT 1, ( result, defaultPos, defaultPos), rest671)
end
|  ( 4, ( ( _, ( MlyValue.stmts stmts1, _, stmts1right)) :: ( _, ( 
MlyValue.stmt stmt1, stmt1left, _)) :: rest671)) => let val  result = 
MlyValue.stmts (fn _ => let val  (stmt as stmt1) = stmt1 ()
 val  (stmts as stmts1) = stmts1 ()
 in (stmt :: stmts)
end)
 in ( LrTable.NT 1, ( result, stmt1left, stmts1right), rest671)
end
|  ( 5, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.simp simp1, (
simpleft as simp1left), simpright)) :: rest671)) => let val  result = 
MlyValue.stmt (fn _ => let val  (simp as simp1) = simp1 ()
 in (marks (simp, (simpleft, simpright)))
end)
 in ( LrTable.NT 3, ( result, simp1left, SEMI1right), rest671)
end
|  ( 6, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.exp exp1, _, 
expright)) :: ( _, ( _, (RETURNleft as RETURN1left), _)) :: rest671))
 => let val  result = MlyValue.stmt (fn _ => let val  (exp as exp1) = 
exp1 ()
 in (marks ((A.Return exp), (RETURNleft, expright)))
end)
 in ( LrTable.NT 3, ( result, RETURN1left, SEMI1right), rest671)
end
|  ( 7, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.decl decl1, (
declleft as decl1left), declright)) :: rest671)) => let val  result = 
MlyValue.stmt (fn _ => let val  (decl as decl1) = decl1 ()
 in (marks (decl, (declleft, declright)))
end)
 in ( LrTable.NT 3, ( result, decl1left, SEMI1right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.IDENT IDENT1, IDENT1left, IDENT1right)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (
IDENT as IDENT1) = IDENT1 ()
 in (IDENT)
end)
 in ( LrTable.NT 4, ( result, IDENT1left, IDENT1right), rest671)
end
|  ( 9, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.lvalue 
lvalue1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val 
 result = MlyValue.lvalue (fn _ => let val  (lvalue as lvalue1) = 
lvalue1 ()
 in (lvalue)
end)
 in ( LrTable.NT 4, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 10, ( ( _, ( MlyValue.exp exp1, _, (expright as exp1right))) :: (
 _, ( MlyValue.asnop asnop1, _, _)) :: ( _, ( MlyValue.lvalue lvalue1,
 (lvalueleft as lvalue1left), _)) :: rest671)) => let val  result = 
MlyValue.simp (fn _ => let val  (lvalue as lvalue1) = lvalue1 ()
 val  (asnop as asnop1) = asnop1 ()
 val  (exp as exp1) = exp1 ()
 in (expand_asnop (lvalue, asnop, exp) (lvalueleft, expright))
end)
 in ( LrTable.NT 5, ( result, lvalue1left, exp1right), rest671)
end
|  ( 11, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  (exp as exp1) = exp1 ()
 in (exp)
end)
 in ( LrTable.NT 6, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.INTCONST INTCONST1, (INTCONSTleft as 
INTCONST1left), (INTCONSTright as INTCONST1right))) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  (INTCONST as 
INTCONST1) = INTCONST1 ()
 in (mark (A.ConstExp(INTCONST),(INTCONSTleft,INTCONSTright)))
end)
 in ( LrTable.NT 6, ( result, INTCONST1left, INTCONST1right), rest671)

end
|  ( 13, ( ( _, ( MlyValue.IDENT IDENT1, (IDENTleft as IDENT1left), (
IDENTright as IDENT1right))) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 in (mark (A.Var(IDENT), (IDENTleft,IDENTright)))
end)
 in ( LrTable.NT 6, ( result, IDENT1left, IDENT1right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (mark (A.OpExp (A.PLUS, [exp1,exp2]), (exp1left,exp2right)))
end)
 in ( LrTable.NT 6, ( result, exp1left, exp2right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (mark (A.OpExp (A.MINUS, [exp1,exp2]), (exp1left,exp2right)))
end)
 in ( LrTable.NT 6, ( result, exp1left, exp2right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (mark (A.OpExp (A.TIMES, [exp1,exp2]), (exp1left,exp2right)))
end)
 in ( LrTable.NT 6, ( result, exp1left, exp2right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (mark (A.OpExp (A.DIVIDEDBY, [exp1,exp2]), (exp1left,exp2right)))

end)
 in ( LrTable.NT 6, ( result, exp1left, exp2right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (mark (A.OpExp (A.MODULO, [exp1,exp2]), (exp1left,exp2right)))
end
)
 in ( LrTable.NT 6, ( result, exp1left, exp2right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.exp exp1, _, (expright as exp1right))) :: (
 _, ( _, (MINUSleft as MINUS1left), _)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => let val  (exp as exp1) = exp1 ()
 in (mark (A.OpExp (A.NEGATIVE, [exp]), (MINUSleft,expright)))
end)
 in ( LrTable.NT 6, ( result, MINUS1left, exp1right), rest671)
end
|  ( 20, ( ( _, ( _, ASSIGN1left, ASSIGN1right)) :: rest671)) => let
 val  result = MlyValue.asnop (fn _ => (NONE))
 in ( LrTable.NT 7, ( result, ASSIGN1left, ASSIGN1right), rest671)
end
|  ( 21, ( ( _, ( _, PLUSEQ1left, PLUSEQ1right)) :: rest671)) => let
 val  result = MlyValue.asnop (fn _ => (SOME(A.PLUS)))
 in ( LrTable.NT 7, ( result, PLUSEQ1left, PLUSEQ1right), rest671)
end
|  ( 22, ( ( _, ( _, MINUSEQ1left, MINUSEQ1right)) :: rest671)) => let
 val  result = MlyValue.asnop (fn _ => (SOME(A.MINUS)))
 in ( LrTable.NT 7, ( result, MINUSEQ1left, MINUSEQ1right), rest671)

end
|  ( 23, ( ( _, ( _, STAREQ1left, STAREQ1right)) :: rest671)) => let
 val  result = MlyValue.asnop (fn _ => (SOME(A.TIMES)))
 in ( LrTable.NT 7, ( result, STAREQ1left, STAREQ1right), rest671)
end
|  ( 24, ( ( _, ( _, SLASHEQ1left, SLASHEQ1right)) :: rest671)) => let
 val  result = MlyValue.asnop (fn _ => (SOME(A.DIVIDEDBY)))
 in ( LrTable.NT 7, ( result, SLASHEQ1left, SLASHEQ1right), rest671)

end
|  ( 25, ( ( _, ( _, PERCENTEQ1left, PERCENTEQ1right)) :: rest671)) =>
 let val  result = MlyValue.asnop (fn _ => (SOME(A.MODULO)))
 in ( LrTable.NT 7, ( result, PERCENTEQ1left, PERCENTEQ1right), 
rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.program x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : L1_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMI (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.VOID,p1,p2))
fun INTCONST (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.INTCONST (fn () => i),p1,p2))
fun IDENT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.IDENT (fn () => i),p1,p2))
fun RETURN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun INT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun STAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun SLASH (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun PERCENT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUSEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUSEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun STAREQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun SLASHEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun PERCENTEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun UNARY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun ASNOP (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
end
end
