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
       {short = "", long=["profile"],
        desc=G.NoArg (fn () => Flag.set O.flag_profile),
        help="profile the compiler"},
       {short = "l", long=["header"],
        desc=G.ReqArg (fn s => Flag.sets (O.flag_header, s), "foo"),
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
        help="safe compilation with memory checks"}
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
    val _ = Debug.set_level Debug.WARN
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
    val _ = Flag.guard O.flag_verbose say ("Main... " ^ source)
    val _ = P.time ("Main", fn () => MainChecker.analyze ast)
    val _ = Flag.guard O.flag_verbose say ("Initialization... " ^ source)
    val _ = P.time ("Initialization",
                    fn () => InitializationChecker.analyze ast)
    val _ = P.stopTimer ()

    fun pretty key (id, _, _, cfg) = let
          fun pp_node (nid, data) = "label=\"" ^ String.concatWith "\\n"
                                                  (map Tree.Print.pp_stm data) ^
                                    "\\n" ^ Int.toString nid^ "\" " ^
                                    "shape=box"
          fun pp_edge (_, _, Tree.TRUE) = "label=true"
            | pp_edge (_, _, Tree.FALSE) = "label=false"
            | pp_edge (_, _, Tree.BRANCH) = "label=branch"
            | pp_edge (_, _, Tree.ALWAYS) = ""
        in
          Dotfile.mkdot (Options.filename () ^ ".cfg." ^ key ^ "." ^
                         Label.name id, pp_node, pp_edge, cfg)
        end

    (* IR translation/Optimizations *)
    val _ = Flag.guard O.flag_verbose say "Translating..."
    val cfg' = P.time ("Translating", fn () => Trans.translate ast)
    val _ = P.time ("SSA", fn () => SSA.ssa cfg')
    val _ = Flag.guard O.flag_dotcfg (fn () => app (pretty "ssa") cfg') ()
    val cfg = SimpPhis.optimize cfg'
    val _ = Flag.guard O.flag_dotcfg (fn () => app (pretty "phis") cfg) ()
    val ir = P.time ("Flatten", fn () => SSA.dessa cfg)
    val _ = Flag.guard O.flag_ir (fn () => say (Tree.Print.pp_program ir)) ()
(*    val _ = Flag.guard O.flag_verbose say ("Neededness Analysis... " ^ source)
    val ir' = P.time ("Neededness", fn () => Neededness.eliminate ir'')
    val _ = Flag.guard O.flag_ir (fn () => say (Tree.Print.pp_program ir')) ()
    val _ = Flag.guard O.flag_verbose say ("Constant Folding... " ^ source)
    val ir = P.time ("Const Folding", fn () => CFold.fold ir')
    val _ = Flag.guard O.flag_ir (fn () => say (Tree.Print.pp_program ir)) ()*)

    (* Codegen/Assembly generation*)
    val _ = Flag.guard O.flag_verbose say "Codegen..."
    val assem = P.time ("Codegen   ", fn () => Codegen.codegen ir)
    val _ = Flag.guard O.flag_assem
        (fn () => List.app (TextIO.print o Assem.format) assem) ()

    val assem = [Assem.DIRECTIVE(".file\t\"" ^ source ^ "\""),
                 Assem.DIRECTIVE(".globl " ^
                                 Label.name (Label.extfunc "_c0_main"))]
          @ assem
          @ [Assem.DIRECTIVE ".ident\t\"15-411 L5 reference compiler\""]
    val code = P.time ("Formatting",
                       fn () => String.concat (List.map (Assem.format) assem))

    val afname = stem source ^ ".s"
    val _ = Flag.guard O.flag_verbose say ("Writing assembly to " ^ afname ^
                                           " ...")
    val _ = SafeIO.withOpenOut afname (fn afstream =>
         TextIO.output (afstream, code))
    val _ = P.stopTimer ()
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
