signature DOTFILE =
sig

  val mkdot : string *
                ('n Graph.node -> string) *
                ('e Graph.edge -> string) *
                ('n, 'e, 'g) Graph.graph
              -> unit

end

structure Dotfile :> DOTFILE =
struct

  structure G = Graph

  fun mkdot (fname, nodes, edges, G.GRAPH graph) =
        SafeIO.withOpenOut (fname ^ ".dot") (fn stream => let
          val out = TextIO.output
          fun nid id = "n" ^ Int.toString id
          val _ = out (stream, "digraph \"")
          val _ = out (stream , #name graph)
          val _ = out (stream, " - ")
          val _ = out (stream, fname)
          val _ = out (stream , "\" {\n")
          val _ = #forall_nodes graph (fn (id, data) => let
                    val _ = out (stream, nid id)
                    val _ = out (stream, " [")
                    val _ = out (stream, nodes (id, data))
                  in
                    out (stream, "];\n")
                  end)
          val _ = #forall_edges graph (fn (n1, n2, data) => let
                    val _ = out (stream, nid n1)
                    val _ = out (stream, " -> ")
                    val _ = out (stream, nid n2)
                    val _ = out (stream, " [")
                    val _ = out (stream, edges (n1, n2, data))
                  in
                    out (stream, "];\n")
                  end)
        in
          out (stream , "}\n")
        end)

end
