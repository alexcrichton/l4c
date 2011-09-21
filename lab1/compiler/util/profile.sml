signature PROFILE =
sig
  val startTimer : string -> unit
  val stopTimer : unit -> unit
  val time : string * (unit -> 'a) -> 'a
  val print : unit -> unit
end

structure Profile :> PROFILE =
struct
  structure T = Timer

  local
    val active = ref []
    val results = ref []
  in
    fun startTimer (name:string) = active := (T.startRealTimer (), name)::(!active)

    fun stopTimer () =
          case !active
            of [] => raise Fail "Unmatched call to stopTimer"
             | ((timer, name)::L) => let
                  val () = active := L
                  val t = Time.toMicroseconds (T.checkRealTimer timer)
                  val s = IntInf.toString t
                in
                  results := (name, s, List.length !active)::(!results)
                end

    fun time (name, f) = let
          val () = startTimer name
          val v  = f ()
          val () = stopTimer ()
        in
          v
        end

    fun print () = let
          fun pr [] _ s = s
            | pr ((n, t, l)::L) pre s =
        in
          pr (!results) ""
        end
  end
end
