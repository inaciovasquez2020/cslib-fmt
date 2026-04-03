import FMT.Graph.DistanceMinimality

namespace FMT.Graph

theorem dist?_is_shortest
  (G : Graph) {u v : G.V} {n : Nat} :
  dist? G u v = some n →
  ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  intro h
  exact (dist?_some_iff_shortest G).mp h |>.2

end FMT.Graph
