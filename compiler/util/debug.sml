signature DebugLogger =
sig
  datatype level = VERBOSE | DEBUG | INFO | WARN | ERROR
  val log : level -> string -> unit
  val verbose : string -> unit
  val debug : string -> unit
  val info : string -> unit
  val warn : string -> unit
  val error : string -> unit
  val gverbose : (unit -> string) -> unit
  val gdebug : (unit -> string) -> unit
  val ginfo : (unit -> string) -> unit
  val gwarn : (unit -> string) -> unit
  val gerror : (unit -> string) -> unit
  val log_guard : level -> (unit -> string) -> unit

  val set_level : level -> unit

  val dump_list : ('a -> string) -> 'a list -> string
  val dump_arr : ('a -> string) -> 'a array -> string
  val dump_arri : ('a -> string) -> 'a array -> string
  val dump_is : IntBinarySet.set -> string
  val dump_ts : TempSet.set -> string
end

structure Debug :> DebugLogger =
struct
  datatype level = VERBOSE | DEBUG | INFO | WARN | ERROR

  val cur_level = ref WARN
  fun set_level level = cur_level := level

  fun level_ord VERBOSE = 0
    | level_ord DEBUG   = 1
    | level_ord INFO    = 2
    | level_ord WARN    = 3
    | level_ord ERROR   = 4

  fun dolog level = level_ord level >= level_ord (!cur_level)

  fun log level string = if not(dolog level) then ()
                         else (print string; print "\n")
  fun log_guard level f = if not(dolog level) then ()
                          else log level (f ())

  val verbose = log VERBOSE
  val debug   = log DEBUG
  val info    = log INFO
  val warn    = log WARN
  val error   = log ERROR
  val gverbose = log_guard VERBOSE
  val gdebug   = log_guard DEBUG
  val ginfo    = log_guard INFO
  val gwarn    = log_guard WARN
  val gerror   = log_guard ERROR

  fun dump_list f L = String.concatWith ", " (map f L)
  fun dump_arr f L  = Array.foldr (fn (a, s) => (f a) ^ ", " ^ s) "\b\b" L
  fun dump_arri f L = Array.foldri (fn (i, a, s) => Int.toString i ^ "[" ^ (f a)
                                                    ^ "], " ^ s) "\b\b" L
  fun dump_is s = "{" ^ dump_list Int.toString (IntBinarySet.listItems s) ^ "}"
  fun dump_ts s = "{" ^ dump_list Temp.name (TempSet.listItems s) ^ "}"
end
