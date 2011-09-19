signature GRAPH =
sig
  exception NotFound
  exception Exists

  type node_set = TempSet.set
  type node = Temp.temp
  type 'a graph

  val empty : 'a -> 'a graph
  val addNode : 'a graph -> node * 'a option -> unit
  val addClique : 'a graph -> node_set -> unit
  val getNeighbors : 'a graph -> node -> node_set
  val getNodes : 'a graph -> node_set
  val getValue : 'a graph -> node -> 'a
  val setValue : 'a graph -> node * 'a -> unit
end

structure Graph :> GRAPH =
struct
  exception NotFound
  exception Exists

  structure HT = HashTable

  type node_set = TempSet.set
  type node = Temp.temp
  type 'a graph = 'a * (node, ('a * node_set)) HT.hash_table

  fun empty default = (default, HT.mkTable (fn t => Word.fromInt (Temp.number t),
                                  fn (t1, t2) => Temp.compare (t1, t2) = EQUAL)
                                  (100, NotFound))
  
  fun addNode (default, graph) (node, NONE) = addNode (default, graph) (node, SOME default)
    | addNode (default, graph) (node, SOME v) =
        case HT.find graph node
          of SOME _ => raise Exists
           | NONE => HT.insert graph (node, (v, TempSet.empty))

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

  fun getNeighbors (_, graph) node = let val (_,s) = HT.lookup graph node in s end

  fun getNodes (_, graph) = HT.foldi (fn (node, _, set) => TempSet.add (set, node))
                                     TempSet.empty graph

  fun getValue (_, graph) node = let val (v,_) = HT.lookup graph node in v end

  fun setValue (_, graph) (node, value) = let
        val (_, set) = HT.lookup graph node
      in
        HT.insert graph (node, (value, set))
      end
end
