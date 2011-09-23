(*
 * This file contains a graph representation used in register allocation to
 * store the interferences
 *)
signature GRAPH =
sig
  exception NotFound

  type node_set = TempSet.set
  type node = Temp.temp
  type 'a graph

  val empty : 'a -> 'a graph
  val addClique : 'a graph -> node_set -> unit
  val getNeighbors : 'a graph -> node -> node_set
  val getNodes : 'a graph -> node_set
  val getValue : 'a graph -> node -> 'a
  val setValue : 'a graph -> node * 'a -> unit
end

structure Graph :> GRAPH =
struct
  exception NotFound

  structure HT = HashTable

  type node_set = TempSet.set
  type node = Temp.temp
  (*
   * The first 'a is the default value, and in the ('a * node_set) tuple, the
   * 'a is the data for the node, and the node_set is the set of neighbors
   *)
  type 'a graph = 'a * (node, ('a * node_set)) HT.hash_table

  (*
   * This function returns an empty graph that uses the given default value
   * as the value for all new nodes inserted into the graph.
   *
   * @param default The default value to use
   * @return        An empty graph
   *)
  fun empty default = (default, HT.mkTable (fn t => Word.fromInt (Temp.number t),
                                  fn (t1, t2) => Temp.compare (t1, t2) = EQUAL)
                                  (100, NotFound))
  
  (*
   * Adds all of the given nodes to the graph and inserts edges between them
   * such that the subgraph containing just the given nodes is fully connected.
   *
   * @param graph     The graph to insert nodes into
   * @param node_set  The set of nodes to add into the graph
   * @return          Unit - the graph is updated imperatively
   *)
  fun addClique (default, graph) node_set = let
        fun addHelper node = let
              val set' = TempSet.delete (node_set, node)
            in
              case HT.find graph node
                of SOME (v, set) => HT.insert graph (node, (v, TempSet.union (set, set')))
                 | NONE => HT.insert graph (node, (default, set'))
            end
      in
        TempSet.app addHelper node_set
      end

  (*
   * Returns the set of neighbors of the given node in the graph. If the node is
   * not present, a NotFound exception will be raised.
   *
   * @param graph The graph
   * @param node  The node to look up neighbors for
   * @return      The set of neighbors of the node
   *)
  fun getNeighbors (_, graph) node = let val (_,s) = HT.lookup graph node in s end

  (*
   * Returns a set of all the nodes currently in the given graph.
   *
   * @param graph The graph to return the nodes of
   * @return      A node_set containing all the nodes in the graph
   *)
  fun getNodes (_, graph) = HT.foldi (fn (node, _, set) => TempSet.add (set, node))
                                     TempSet.empty graph

  (*
   * Gets the value associated with the given node in the graph. If the node is
   * not present in the graph, the default value will be returned.
   *
   * @param graph The graph
   * @param node  The node to lookup the value of
   * @return      The current value of the node, or the default value if the
   *              node is not found.
   *)
  fun getValue (default, graph) node =
        case HT.find graph node
          of SOME (v, _) => v
           | NONE => default

  (*
   * Sets the value of the given node in the graph. If the node is not present
   * in the graph, then it will be inserted with an empty set of neighbors.
   *
   * @param graph The graph
   * @param node  The node to set the value of
   * @param value The value to set the node to
   * @return      Unit - the graph is updated imperatively
   *)
  fun setValue (_, graph) (node, value) =
        case HT.find graph node
          of SOME (_, set) => HT.insert graph (node, (value, set))
           | NONE          => HT.insert graph (node, (value, TempSet.empty))
end
