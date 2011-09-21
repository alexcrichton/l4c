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

    fun startTimer (name:string) = if not (!enabled) then () else let
          val result = (name, ref "", length (!active))
        in
          active := (T.startRealTimer (), ref result)::(!active);
          results := result::(!results)
        end

    fun stopTimer () = if not (!enabled) then () else
          case !active
            of [] => raise Fail "Unmatched call to stopTimer"
             | ((timer, (ref (_, t, _)))::L) => let
                  val () = active := L
                  val t' = Time.toMilliseconds (T.checkRealTimer timer)
                  val s  = IntInf.toString t'
                in
                  t := s
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
            | pr ((n, ref t, l)::L) = pr L ^ tab l ^ n ^ "\t" ^ t ^ "ms\n"
        in
          TextIO.print (pr (!results))
        end
  end
end
