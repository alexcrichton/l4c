signature OPTIONS =
sig
  val flag_verbose : Flag.flag
  val flag_ast : Flag.flag
  val flag_ir : Flag.flag
  val flag_assem : Flag.flag
  val flag_profile : Flag.flag
  val flag_header : Flag.flag
  val flag_types : Flag.flag
  val flag_dotalloc : Flag.flag
  val flag_dotcfg : Flag.flag
  val flag_safe : Flag.flag
  val flag_unsafe : Flag.flag
  val flag_opt : Flag.flag

  val filename : unit -> string
  val set_filename : string -> unit

end

structure Options :> OPTIONS =
struct
  val flag_verbose  = Flag.flag "verbose"
  val flag_ast      = Flag.flag "ast"
  val flag_ir       = Flag.flag "ir"
  val flag_assem    = Flag.flag "asm"
  val flag_profile  = Flag.flag "profile"
  val flag_header   = Flag.flag "header"
  val flag_types    = Flag.flag "types"
  val flag_dotalloc = Flag.flag "dotalloc"
  val flag_dotcfg   = Flag.flag "dotcfg"
  val flag_safe     = Flag.flag "safe"
  val flag_unsafe   = Flag.flag "unsafe"
  val flag_opt      = Flag.flag "optimize"

  val fname = ref "output"
  fun filename () = !fname
  fun set_filename s = fname := s

end
