(* L5 Compiler
 * Top Level Environment
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature TOP =
sig
  (* main function for standalone executable
   * use with SMLofNJ.exportFn("heapfilename", Top.main)
   *)
  val main : string * string list -> OS.Process.status

  (* test "arguments"; is the same as executing a saved
   * heap with arguments on the command line
   *)
  val test : string -> OS.Process.status
end

signature TOP_CODEGEN =
sig
  val codegen : Tree.program -> string
end

functor TopCodegen(C : CODEGEN) :> TOP_CODEGEN =
struct
  structure A = C.Assem
  structure O = Options
  structure P = Profile

  fun codegen ir = let
        val _ = Flag.guard O.flag_verbose Debug.info "Codegen..."
        val assem = P.time ("Codegen   ", fn () => C.codegen ir)
        val _ = Flag.guard O.flag_assem
            (fn () => (TextIO.print o A.format) assem) ()

        val assem = C.Runtime.instrs assem
        val code = P.time ("Formatting", fn () => A.format assem)
        val _ = P.stopTimer ()
      in code end

end

structure X86TopCodegen = TopCodegen(X86Codegen)
structure X64TopCodegen = TopCodegen(X64Codegen)

structure Top :> TOP =
struct
  structure G = GetOpt  (* from $/smlnj-lib/Util/getopt-sig.sml *)
  structure P = Profile
  structure O = Options

  fun say s = TextIO.output (TextIO.stdErr, s ^ "\n")

  fun newline () = TextIO.output (TextIO.stdErr, "\n")

  exception EXIT

  fun reset_flags () =
    List.app Flag.unset [O.flag_verbose, O.flag_ast,
       O.flag_ir, O.flag_assem];

    val options = [{short = "v", long=["verbose"],
        desc=G.NoArg (fn () => Flag.set O.flag_verbose),
        help="verbose messages"},
       {short = "", long=["dump-ast"],
        desc=G.NoArg (fn () => Flag.set O.flag_ast),
        help="pretty print the AST"},
       {short = "", long=["dump-ir"],
        desc=G.NoArg (fn () => Flag.set O.flag_ir),
        help="pretty print the IR"},
       {short = "", long=["dump-asm"],
        desc=G.NoArg (fn () => Flag.set O.flag_assem),
        help="pretty print the assembly before register allocaction"},
       {short = "p", long=["profile"],
        desc=G.NoArg (fn () => Flag.set O.flag_profile),
        help="profile the compiler"},
       {short = "c", long=["object"],
        desc=G.NoArg (fn () => Flag.set O.flag_object),
        help="emit assembly for an object file instead of an executable"},
       {short = "l", long=["header"],
        desc=G.ReqArg (fn s => Flag.sets (O.flag_header, s), "l4.h0"),
        help="header file for the program"},
       {short = "", long=["types"],
        desc=G.NoArg (fn () => Flag.set O.flag_types),
        help="print type sizes in ASM and IR"},
       {short = "", long=["dotalloc"],
        desc=G.NoArg (fn () => Flag.set O.flag_dotalloc),
        help="output DOT file for allocation graph"},
       {short = "", long=["dotcfg"],
        desc=G.NoArg (fn () => Flag.set O.flag_dotcfg),
        help="output DOT file for control flow graph"},
       {short = "", long=["safe"],
        desc=G.NoArg (fn () => Flag.set O.flag_safe),
        help="safe compilation with memory checks"},
       {short = "", long=["unsafe"],
        desc=G.NoArg (fn () => Flag.set O.flag_unsafe),
        help="unsafe compilation with no memory checks"},
       {short = "O", long=["optimize"],
        desc=G.ReqArg (fn s => Flag.sets (O.flag_opt, s), "0"),
        help="level of optimizations to perform"},
       {short = "m", long=["arch"],
        desc=G.ReqArg (fn s => Flag.sets (O.flag_arch, s), "x64"),
        help="architecture to emit ([x64] | x86)"}
      ]

  fun stem s = let
    val (prefix, suffix) =
        Substring.splitr (fn c => c <> #".") (Substring.full s)
  in
    if Substring.isEmpty prefix (* no "." in string s *)
       then s (* return whole string *)
    else Substring.string (Substring.trimr 1 prefix)
  end

  fun main (name, args) =
  let
    val header = "Usage: compile [OPTION...] SOURCEFILE\nwhere OPTION is"
    val usageinfo = G.usageInfo {header = header, options = options}
    fun errfn msg = (say (msg ^ "\n" ^ usageinfo) ; raise EXIT)

    val _ = Temp.reset (); (* reset temp variable counter *)
    val _ = reset_flags (); (* return all flags to default value *)

    val _ = if List.length args = 0 then
              (say usageinfo; raise EXIT)
            else ()

    val (opts, files) =
        G.getOpt {argOrder = G.Permute,
                  options = options,
                  errFn = errfn} args

    val source =
        case files
          of [] => errfn "Error: no input file"
           | [filename] => filename
           | _ => errfn "Error: more than one input file"
    val _ = O.set_filename source

    val arch = Flag.svalue O.flag_arch
    val arch = if arch = "" then "x64" else arch
    val translate = if arch = "x64" then Trans64.translate
                    else Trans32.translate

    val _ = Flag.guard O.flag_profile P.enable ()
    val _ = P.startTimer "Compiling"

    fun parse_header () = let
          val file = Flag.svalue O.flag_header
          val ast = Parse.parse file
        in Ast.elaborate_external ast end

    val header = P.time ("Header parsing",fn () =>
                         Flag.branch O.flag_header (parse_header, fn () => [])
                                     ())

    (* Parsing / elaboration *)
    val _ = Flag.guard O.flag_verbose say ("Parsing... " ^ source)
    val ast = header @ P.time ("Parsing   ", fn () => Parse.parse source)
    val _ = Flag.guard O.flag_verbose say ("Elaborating... " ^ source)
    val ast = P.time ("Elaborating", fn () => Ast.elaborate ast)
    val _ = Flag.guard O.flag_ast
        (fn () => say (Ast.Print.pp_program ast)) ()

    (* Static Analysis *)
    val _ = P.startTimer "Analyzing..."
    val _ = Flag.guard O.flag_verbose say ("Typechecking... " ^ source)
    val _ = P.time ("Typechecking", fn () => TypeChecker.analyze ast)
    val _ = Flag.guard O.flag_verbose say ("Returns... " ^ source)
    val _ = P.time ("Returns", fn () => ReturnChecker.analyze ast)
    val _ = if Flag.isset O.flag_object then ()
            else (Flag.guard O.flag_verbose say ("Main... " ^ source);
                  MainChecker.analyze ast)
    val _ = Flag.guard O.flag_verbose say ("Initialization... " ^ source)
    val _ = P.time ("Initialization",
                    fn () => InitializationChecker.analyze ast)
    val _ = P.stopTimer ()

    (* Pretty prints a control flow graph into a dot file *)
    fun pretty key ((id, _), _, _, cfg) = let
          fun pp_node (nid, data) = "label=\"" ^ String.concatWith "\\n"
                                                  (map Tree.Print.pp_stm data) ^
                                    "\\n" ^ Int.toString nid^ "\" " ^
                                    "shape=box"
          fun pp_edge (_, _, Tree.TRUE) = "label=true"
            | pp_edge (_, _, Tree.FALSE) = "label=false"
            | pp_edge (_, _, Tree.BRANCH) = "label=branch"
            | pp_edge (_, _, Tree.TBRANCH) = "label=tbranch"
            | pp_edge (_, _, Tree.FBRANCH) = "label=fbranch"
            | pp_edge (_, _, Tree.ALWAYS) = ""
        in
          Dotfile.mkdot (Options.filename () ^ ".cfg." ^ key ^ "." ^
                         Label.name id, pp_node, pp_edge, cfg)
        end

    (* Performs a list of transforations on the IR *)
    fun optimize cfg [] = cfg
      | optimize cfg ({active=a, desc=d, ppfile=ppf, level=l, func=f}::L) =
        if a andalso O.opt_on l then let
          val _ = Flag.guard O.flag_verbose say (d ^ "...")
          val cfg' = P.time (d, fn () => f cfg)
          val _ = Flag.guard O.flag_dotcfg (fn () => app (pretty ppf) cfg') ()
        in
          optimize cfg' L
        end
        else optimize cfg L

    (* IR translation/Optimizations *)
    val _ = Flag.guard O.flag_verbose say "Translating..."
    val cfg = P.time ("Translating", fn () => translate ast)
    val _ = Flag.guard O.flag_dotcfg (fn () => app (pretty "non-ssa") cfg) ()

    val _ = P.time ("SSA", fn () => SSA.ssa cfg)
    val _ = Flag.guard O.flag_dotcfg (fn () => app (pretty "ssa") cfg) ()

    val cfg' = optimize cfg [{
                  active = true,
                  desc   = "Prune Phis",
                  ppfile = "phis",
                  level  = 1,
                  func   = SimpPhis.optimize
                }, {
                  active = true,
                  desc   = "Constant Folding",
                  ppfile = "cfold",
                  level  = 1,
                  func   = CFold.optimize
                }, {
                  active = true,
                  desc   = "CSE",
                  ppfile = "cse",
                  level  = 1,
                  func   = CSE.optimize
                }, {
                  active = true,
                  desc   = "Prune CFG",
                  ppfile = "prune",
                  level  = 1,
                  func   = CFGPrune.optimize
                }, {
                  active = false,
                  desc   = "Coalesce temps",
                  ppfile = "tmp_coalesce",
                  level  = 1,
                  func   = TMPCoalesce.optimize
                }, {
                  active = false,
                  desc   = "Coalesce CFG",
                  ppfile = "cfg_coalesce",
                  level  = 1,
                  func   = CFGCoalesce.optimize
                }]

    val ir = P.time ("Flatten", fn () => SSA.dessa cfg')

    val ir' = if not (O.opt_on 0) then ir
              else P.time ("Neededness", fn () => Neededness.eliminate ir)
    val _ = Flag.guard O.flag_ir (fn () => say (Tree.Print.pp_program ir')) ()

    (* Codegen/Assembly generation*)
    val code = if arch = "x86" then X86TopCodegen.codegen ir'
               else if arch = "x64" then X64TopCodegen.codegen ir'
               else raise Fail ("Unknown architecture: " ^ arch)

    val afname = stem source ^ ".s"
    val _ = Flag.guard O.flag_verbose say ("Writing assembly to " ^ afname ^
                                           " ...")
    val _ = SafeIO.withOpenOut afname (fn afstream =>
         TextIO.output (afstream, code))
    val _ = P.print ()
  in
    OS.Process.success
  end
    handle ErrorMsg.Error => ( say "Compilation failed" ; OS.Process.failure )
           | EXIT => OS.Process.failure
           | Fail s => (say("Fail: " ^ s); OS.Process.failure)
           | e => (say ("Unrecognized exception " ^ exnName e);
                   OS.Process.failure)

  fun test s = main ("", String.tokens Char.isSpace s)
end
