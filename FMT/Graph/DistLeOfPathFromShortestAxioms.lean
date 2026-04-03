import FMT.Graph.DistancePath
import FMT.Graph.ExistsShortestPathLength
import FMT.Graph.DistIsShortest

namespace FMT.Graph

axiom dist?_le_of_path_from_shortest_axioms
  (G : Graph) {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n))
  (hex : ∃ m, Nonempty (PathLength G u v m)) :
  ∃ d, dist? G u v = some d ∧ d ≤ n

end FMT.Graph
