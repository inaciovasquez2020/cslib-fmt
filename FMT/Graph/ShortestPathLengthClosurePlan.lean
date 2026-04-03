import FMT.Graph.PathLength
import FMT.Graph.DistanceCore

namespace FMT.Graph

/-
Final closure target for the distance layer.

Current live frontier:
  shortest_path_length

To remove it constructively, it is enough to prove a shortest-path existence
principle from an explicit path-existence hypothesis.
-/

theorem shortest_path_length_of_exists
  (G : Graph) (u v : G.V)
  (hex : ∃ n, Nonempty (PathLength G u v n)) :
  ∃ d : Nat,
    Nonempty (PathLength G u v d) ∧
    (∀ m, m < d → ¬ Nonempty (PathLength G u v m)) := by
  sorry

end FMT.Graph
