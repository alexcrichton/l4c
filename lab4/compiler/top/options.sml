signature OPTIONS =
sig
  val flag_verbose : Flag.flag
  val flag_ast : Flag.flag
  val flag_ir : Flag.flag
  val flag_assem : Flag.flag
  val flag_profile : Flag.flag
  val flag_header : Flag.flag
  val flag_types : Flag.flag
end

structure Options :> OPTIONS =
struct
  val flag_verbose = Flag.flag "verbose"
  val flag_ast     = Flag.flag "ast"
  val flag_ir      = Flag.flag "ir"
  val flag_assem   = Flag.flag "asm"
  val flag_profile = Flag.flag "profile"
  val flag_header  = Flag.flag "header"
  val flag_types   = Flag.flag "types"
end
