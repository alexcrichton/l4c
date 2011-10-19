(* L4 Compiler
 * Undirected graph that implements the GRAPH_IMPLEMENTATION structure.
 * The graph is represented as an array of hashtables that represent the
 * edges between the nodes. This gives better performance than the
 * original undirected graph implementation.
 *
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

functor UndirectedHashGraph (A : ARRAY) : GRAPH_IMPLEMENTATION =
struct

  structure G = Graph
  structure A = A
  structure H = IntHashTable

  fun graph (name, graph_info, n) =
  let val adj           = A.array (n, NONE)
      val nodes         = A.array (n, NONE)
      val node_count    = ref 0
      val edge_count    = ref 0
      val entries       = ref []
      val exits         = ref []
      val new_nodes     = ref []
      val garbage_nodes = ref []

      fun adj_ht i =  case A.sub (adj, i) of SOME ht => ht | NONE => let
                          val ht = H.mkTable (10, G.NotFound)
                        in A.update (adj, i, SOME ht); ht end

      fun new_id () = case ! new_nodes of []   => A.length nodes
                                        | h::t => (new_nodes := t; h)

      fun garbage_collect () = raise Fail "GC unimplemnted"
      (*fun garbage_collect () =
        (new_nodes := (!new_nodes) @ (!garbage_nodes); garbage_nodes := [])*)

      fun get_nodes () =
        A.foldri (fn (i, SOME n, l) => (i, n)::l|(_,_,l) => l) [] nodes

      fun get_edges () = raise Fail "Edges unimplemnted"
      (*fun get_edges () =
        A.foldri (fn (i,es,L) => H.foldi (fn (j,e,L) =>
                  if i <= j then (i,j,e)::L else L) L es)
                [] adj*)

      fun order () = raise Fail "Order unimplemnted"
      (*fun order () = !node_count*)

      fun size ()  = !edge_count

      fun capacity () = raise Fail "Capacity unimplemnted"
      (*fun capacity () = A.length nodes*)

      fun add_node(i,n) =
        (case A.sub(nodes,i)
            of NONE => node_count := 1 + !node_count
             | _    => ();
         A.update(nodes,i,SOME n))

      fun add_edge (i,j,e) =
        (H.insert (adj_ht i) (j, e);
         if i <> j then H.insert (adj_ht j) (i, e) else ();
         edge_count := 1 + !edge_count)

      fun set_edges (i, edges) = raise Fail "Set edges unimplemnted"
      (*fun set_edges (i, edges) = let
        val table = A.sub (adj, i)
      in
        H.appi (fn (j,_) => (H.remove (A.sub(adj, j)) i; ())) table;
        H.clear table;
        app (fn (_,j,e) => add_edge (i,j,e)) edges
        (* FIXME: update edge_count *)
      end*)

      fun remove_node i = raise Fail "Remove node unimplemnted"
      (*fun remove_node i =
         case A.sub(nodes,i) of
            NONE => ()
         |  SOME _ => (set_edges(i,[]);
                       A.update(nodes,i,NONE);
                       node_count := !node_count - 1;
                       garbage_nodes := i :: !garbage_nodes)*)

      fun remove_nodes ns = app remove_node ns

      fun set_entries ns = raise Fail "Set entries unimplemnted"
      (*fun set_entries ns = entries := ns*)

      fun set_exits ns = raise Fail "Set exits unimplemnted"
      (*fun set_exits ns = exits := ns*)

      fun get_entries() = raise Fail "Get entries unimplemnted"
      (*fun get_entries()  = !entries*)

      fun get_exits() = raise Fail "Get exits unimplemnted"
      (*fun get_exits()  = !exits*)

      fun adj_edges i = raise Fail "Adj edges unimplemnted"
      (*fun adj_edges i = H.foldi (fn (j,e,L) => (i,j,e)::L) [] (A.sub (adj, i))*)

      fun neighbors i = H.foldi (fn (j,_,L) => j::L) [] (adj_ht i)

      fun has_edge (i, j) = case H.find (adj_ht i) j
                              of SOME _ => true | NONE => false

      fun has_node n = raise Fail "Has node unimplemnted"
      (*fun has_node n = case A.sub(nodes,n) of
                          SOME _ => true | NONE => false*)

      fun node_info n = case A.sub(nodes,n) of
                           SOME x => x
                         | NONE => raise G.NotFound

      fun forall_nodes f =
          A.appi (fn (i,SOME x) => f(i,x) | _ => ()) nodes

      fun forall_edges f = raise Fail "Forall edges unimplemnted"
      (*fun forall_edges f = A.appi (fn (i,es) =>
            H.appi (fn (j,e) => if i <= j then f(i,j,e) else ()) es) adj*)

      fun none _ = []

  in  G.GRAPH {
         name            = name : string,
         graph_info      = graph_info : 'g,
         new_id          = new_id : unit -> G.node_id,
         add_node        = add_node : 'n G.node -> unit,
         add_edge        = add_edge : 'e G.edge -> unit,
         remove_node     = remove_node : G.node_id -> unit,
         set_in_edges    = set_edges : G.node_id * 'e G.edge list -> unit,
         set_out_edges   = set_edges : G.node_id * 'e G.edge list -> unit,
         set_entries     = set_entries : G.node_id list -> unit,
         set_exits       = set_exits : G.node_id list -> unit,
         garbage_collect = garbage_collect : unit -> unit,
         nodes           = get_nodes : unit -> 'n G.node list,
         edges           = get_edges : unit -> 'e G.edge list,
         order           = order : unit -> int,
         size            = size : unit -> int,
         capacity        = capacity : unit -> int,
         out_edges       = adj_edges : G.node_id -> 'e G.edge list,
         in_edges        = adj_edges : G.node_id -> 'e G.edge list,
         succ            = neighbors : G.node_id -> G.node_id list,
         pred            = neighbors : G.node_id -> G.node_id list,
         has_edge        = has_edge : G.node_id * G.node_id -> bool,
         has_node        = has_node : G.node_id -> bool,
         node_info       = node_info : G.node_id -> 'n,
         entries         = get_entries : unit -> G.node_id list,
         exits           = get_exits : unit -> G.node_id list,
         entry_edges     = none : G.node_id -> 'e G.edge list,
         exit_edges      = none : G.node_id -> 'e G.edge list,
         forall_nodes    = forall_nodes : ('n G.node -> unit) -> unit,
         forall_edges    = forall_edges : ('e G.edge -> unit) -> unit
      } : ('n,'e,'g) G.graph
  end

end
