import FMT.Graph.DistanceCore

namespace FMT.Graph

axiom dist?_some_of_shortest_path
  (G : Graph) {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  dist? G u v = some d

end FMT.Graph
