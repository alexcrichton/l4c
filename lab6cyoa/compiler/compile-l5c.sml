(* L5 Compiler
 * Helper for compilation
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 *)

CM.make "sources.cm";
SMLofNJ.exportFn ("bin/l5c.heap", Top.main);
