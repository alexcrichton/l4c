signature PROFILE =
sig
  val enable : unit -> unit
  val disable : unit -> unit
  val startTimer : string -> unit
  val stopTimer : unit -> unit
  val time : string * (unit -> 'a) -> 'a
  val print : unit -> unit
end

structure Profile :> PROFILE =
struct
  structure T = Timer

  local
    val enabled = ref false
    val active = ref []
    val results = ref []
  in
    fun enable () = enabled := true
    fun disable () = enabled := false

    fun startTimer (name:string) =
          if (!enabled) then active := (T.startRealTimer (), name)::(!active) else ()

    fun stopTimer () = if not (!enabled) then () else
          case !active
            of [] => raise Fail "Unmatched call to stopTimer"
             | ((timer, name)::L) => let
                  val () = active := L
                  val t = Time.toMilliseconds (T.checkRealTimer timer)
                  val s = IntInf.toString t
                in
                  results := (name, s, List.length (!active))::(!results)
                end

    fun time (name, f) = let
          val () = startTimer name
          val v  = f ()
          val () = stopTimer ()
        in
          v
        end

    fun print () = let
          fun tab 0 = ""
            | tab n = "\t" ^ tab (n-1)
          fun pr [] = ""
            | pr ((n, t, l)::L) = pr L ^ tab l ^ n ^ "\t" ^ t ^ "ms\n"
        in
          TextIO.print (pr (!results))
        end
  end
end
