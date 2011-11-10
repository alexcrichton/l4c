(* L5 Compiler
 * Control flow graph utility functions
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CFG =
sig
  val map_stms : (Tree.stm -> Tree.stm) -> Tree.cfg -> unit
end

structure CFG :> CFG =
struct

  structure G = Graph

  fun map_stms f cfg = let
        fun mapg (_, _, _, G.GRAPH g) =
          #forall_nodes g (fn (nid, stms) =>
                            #add_node g (nid, map f stms))
      in
        List.app mapg cfg
      end

end
