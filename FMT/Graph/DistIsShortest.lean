import FMT.Graph.DistanceMinimality

namespace FMT.Graph

theorem dist_is_shortest
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
  dist? (G:=G) u v = some n ↔
    Nonempty (PathLength G u v n) ∧
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  exact dist?_some_iff_shortest G

end FMT.Graph
