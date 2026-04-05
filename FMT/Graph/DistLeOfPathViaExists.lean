import FMT.Graph.DistancePath
import FMT.Graph.DistExistsOfPath
import FMT.Graph.DistLeOfPathFromShortestAxioms

namespace FMT.Graph

theorem dist?_le_of_path_via_exists
  (G : Graph) {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n)) :
  ∃ d, dist? (G:=G) u v = some d ∧ d ≤ n := by
  rcases dist?_exists_of_path G hpath with ⟨m, hm⟩
  exact dist?_le_of_path_from_shortest_axioms G hpath ⟨m, path_of_dist?_some G hm⟩

end FMT.Graph
