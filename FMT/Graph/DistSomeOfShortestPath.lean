import FMT.Graph.DistanceCore

namespace FMT.Graph

theorem dist?_some_of_shortest_path
  (G : Graph) {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  dist? G u v = some d := by
  obtain ⟨hpath0, hmin0⟩ := Classical.choose_spec (shortest_path_length G u v)
  have hle1 : Classical.choose (shortest_path_length G u v) ≤ d := by
    by_cases h : d < Classical.choose (shortest_path_length G u v)
    · exact absurd hdpath (hmin0 d h)
    · exact Nat.le_of_not_gt h
  have hle2 : d ≤ Classical.choose (shortest_path_length G u v) := by
    by_cases h : Classical.choose (shortest_path_length G u v) < d
    · exact absurd hpath0 (hdmin _ h)
    · exact Nat.le_of_not_gt h
  calc
    dist? G u v = some (Classical.choose (shortest_path_length G u v)) := rfl
    _ = some d := by rw [Nat.le_antisymm hle1 hle2]

end FMT.Graph
