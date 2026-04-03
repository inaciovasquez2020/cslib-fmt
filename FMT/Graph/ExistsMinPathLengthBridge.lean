import FMT.Graph.ExistsMinPathLength
import FMT.Graph.PathLengthLemmas

namespace FMT.Graph

theorem exists_min_pathLength_of_reachable
  (G : Graph) (u v : G.V)
  (h : Reachable G u v) :
  ∃ k : Nat, Nonempty (PathLength G u v k) ∧
    (∀ m : Nat, m < k → ¬ Nonempty (PathLength G u v m)) := by
  rcases h with ⟨n, hn⟩
  exact exists_min_pathLength G u v ⟨n, hn⟩

end FMT.Graph
