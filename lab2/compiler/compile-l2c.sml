(* L2 Compiler
 * Helper for compilation
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 *)

CM.make "sources.cm";
SMLofNJ.exportFn ("bin/l2c.heap", Top.main);
