import FMT.Graph.PathLength

namespace FMT.Graph

axiom exists_min_pathLength
  (G : Graph) (u v : G.V) :
  (∃ n : Nat, Nonempty (PathLength G u v n)) →
  ∃ n : Nat,
    Nonempty (PathLength G u v n) ∧
    ∀ m : Nat, m < n → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
