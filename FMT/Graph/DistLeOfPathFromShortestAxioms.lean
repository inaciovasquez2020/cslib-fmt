import FMT.Graph.DistancePath
import FMT.Graph.ExistsShortestPathLength
import FMT.Graph.DistSomeOfShortestPath

namespace FMT.Graph

theorem dist?_le_of_path_from_shortest_axioms
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n))
  (hex : ∃ m, Nonempty (PathLength G u v m)) :
  ∃ d, dist? (G:=G) u v = some d ∧ d ≤ n := by
  rcases exists_shortest_path_length G u v hex with ⟨d, hd⟩
  rcases hd with ⟨hdpath, hdmin⟩
  have hdsome : dist? (G:=G) u v = some d :=
    dist?_some_of_shortest_path G hdpath hdmin
  refine ⟨d, hdsome, ?_⟩
  by_cases hle : d ≤ n
  · exact hle
  · exfalso
    exact hdmin n (Nat.lt_of_not_ge hle) hpath

end FMT.Graph
