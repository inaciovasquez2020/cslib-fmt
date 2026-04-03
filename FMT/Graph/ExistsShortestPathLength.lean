import FMT.Graph.PathLength

namespace FMT.Graph

axiom exists_shortest_path_length
  (G : Graph) (u v : G.V) :
  (∃ n, Nonempty (PathLength G u v n)) →
  ∃ n, Nonempty (PathLength G u v n) ∧
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
