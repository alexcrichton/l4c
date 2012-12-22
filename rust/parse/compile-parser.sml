(* L5 Compiler
 * Helper for compilation
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 *)

CM.make "parse/sources.cm";
SMLofNJ.exportFn ("parse/parser.heap", Top.main);
