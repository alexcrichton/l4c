structure X = struct

  exception pwned
  val _ =
      if OS.Process.isSuccess (Top.main (CommandLine.name (), CommandLine.arguments ()))
      then ()
      else raise pwned

end
