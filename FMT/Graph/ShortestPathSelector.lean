import FMT.Graph.PathLength

namespace FMT.Graph

axiom shortest_path_selector
  (G : Graph) (u v : G.V) :
  Option { n : Nat // Nonempty (PathLength G u v n) ∧
    ∀ m : Nat, m < n → ¬ Nonempty (PathLength G u v m) }

axiom shortest_path_selector_complete
  (G : Graph) (u v : G.V) {n : Nat} :
  Nonempty (PathLength G u v n) -> ∃ s, shortest_path_selector G u v = some s

end FMT.Graph
