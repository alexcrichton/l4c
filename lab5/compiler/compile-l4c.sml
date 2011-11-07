(* L5 Compiler
 * Helper for compilation
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 *)

CM.make "sources.cm";
SMLofNJ.exportFn ("bin/l4c.heap", Top.main);
