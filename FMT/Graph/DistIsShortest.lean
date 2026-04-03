import FMT.Graph.DistancePath

namespace FMT.Graph

axiom dist?_is_shortest
  (G : Graph) {u v : G.V} {n : Nat} :
  dist? G u v = some n →
  ∀ m, m < n → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
