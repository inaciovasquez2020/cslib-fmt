import FMT.Graph.DistanceCore

namespace FMT.Graph

axiom dist?_le_of_path
  (G : Graph) {u v : G.V} {n : Nat} :
  Nonempty (PathLength G u v n) →
  ∃ d, dist? G u v = some d ∧ d ≤ n

axiom dist?_bound_of_path
  (G : Graph) {u v : G.V} {n : Nat} :
  Nonempty (PathLength G u v n) → Nat

end FMT.Graph
