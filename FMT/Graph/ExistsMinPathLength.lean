import FMT.Graph.PathLength

namespace FMT.Graph

axiom exists_min_pathLength
  (G : Graph) (u v : G.V)
  (h : ∃ n : Nat, Nonempty (PathLength G u v n)) :
  ∃ k : Nat, Nonempty (PathLength G u v k) ∧
    (∀ m : Nat, m < k → ¬ Nonempty (PathLength G u v m))

end FMT.Graph
