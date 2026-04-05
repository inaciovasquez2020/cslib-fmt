import FMT.Graph.PathLength

namespace FMT.Graph

axiom shortest_length_spec
  {G : Graph} {u v : G.V} :
  ∀ n, Nonempty (PathLength G u v n) →
  ∀ m, m < n → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
