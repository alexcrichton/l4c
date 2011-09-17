signature GRAPH =
sig
  type 'a node
  type graph

  val empty : unit -> graph
  val addNeighbor : graph * 'a node * 'a node -> graph
  val getNeighbors : graph * 'a node -> 'a node list
  val getValue : graph * 'a node -> 'a
  val setValue : graph * 'a node * 'a -> unit
  val clone : graph * 'a -> 'a graph
end
