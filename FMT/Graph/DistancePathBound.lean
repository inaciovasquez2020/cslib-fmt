import FMT.Graph.DistancePath

namespace FMT.Graph

theorem distancePathBound_exists_only_baseline
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v : G.V) {n : Nat}
  (hpath : Nonempty (PathLength G u v n)) :
  ∃ d, dist? (G:=G) u v = some d ∧ d ≤ n := by
  exact dist?_le_of_path G u v hpath

end FMT.Graph
