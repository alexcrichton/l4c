(* L1 Compiler
 * TypeChecker
 * Author: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Simple typechecker that is based on a unit Symbol.table
 * This is all that is needed since there is only an integer type present
 * Also, since only straightline code is accepted, we hack our way
 * around initialization checks here.
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Now distinguishes between declarations and initialization
 *)

signature TYPE_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val typecheck : Ast.program -> unit
end;

structure TypeChecker :> TYPE_CHECK = 
struct
  structure A = Ast

  (* tc_exp : unit Symbol.table -> Ast.exp -> Mark.ext option -> unit *)
  fun tc_exp env (A.Var(id)) ext =
      (case Symbol.look env id
	of NONE => ( ErrorMsg.error ext ("undeclared variable `" ^ Symbol.name id ^ "'") ;
		     raise ErrorMsg.Error )
	 | SOME (false) => ( ErrorMsg.error ext ("uninitialized variable `" ^ Symbol.name id ^ "'") ;
		           raise ErrorMsg.Error )
         | SOME (true) => ())
    | tc_exp env (A.ConstExp(c)) ext = ()
    | tc_exp env (A.OpExp(oper,es)) ext =
      (* Note: it is syntactically impossible in this language to
       * apply an operator to an incorrect number of arguments
       * so we only check each of the arguments
       *)
	List.app (fn e => tc_exp env e ext) es
    | tc_exp env (A.Marked(marked_exp)) ext =
        tc_exp env (Mark.data marked_exp) (Mark.ext marked_exp)

  (* tc_stms : unit Symbol.table -> Ast.program -> Mark.ext option -> bool -> unit *)
  fun tc_stms env [] ext ret = ret
    | tc_stms env (A.Init (id,e)::stms) ext ret =
        tc_stms env ((A.Declare id)::(A.Assign (id, e))::stms) ext ret
    | tc_stms env ((A.Declare id)::stms) ext ret = 
         (case Symbol.look env id
            of SOME _ => ( ErrorMsg.error NONE ("redeclared variable `" ^ Symbol.name id ^ "'") ;
		                       raise ErrorMsg.Error )
	           | NONE => tc_stms (Symbol.bind env (id, false)) stms ext ret)
    | tc_stms env (A.Assign(id,e)::stms) ext ret =
       (tc_exp env e ext;
        (case Symbol.look env id
	         of NONE => ( ErrorMsg.error ext ("undeclared variable `" ^ Symbol.name id ^ "'") ;
		                    raise ErrorMsg.Error )
            (* just got initialized *)
	          | SOME (false) => tc_stms (Symbol.bind env (id, true)) stms ext ret
            (* already initialized *)
	          | SOME (true) => tc_stms env stms ext ret))
    | tc_stms env (A.Return(e)::stms) ext _ =
        (tc_exp env e ext; tc_stms env stms ext true)
    | tc_stms env ((A.Markeds(marked_stm))::stms) _ ret =
        tc_stms env ((Mark.data marked_stm)::stms) (Mark.ext marked_stm) ret

  fun typecheck prog =
        if tc_stms Symbol.empty prog NONE false then ()
        else (ErrorMsg.error NONE "main does not return\n"; raise ErrorMsg.Error)

end
