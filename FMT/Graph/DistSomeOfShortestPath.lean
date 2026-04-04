import FMT.Graph.DistanceCore

namespace FMT.Graph

theorem dist?_some_of_shortest_path
    (G : Graph) {u v : G.V} {d : Nat}
    (hdpath : Nonempty (PathLength G u v d))
    (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
    dist? G u v = some d := by
  have hex : ∃ n, Nonempty (PathLength G u v n) := ⟨d, hdpath⟩
  simp only [dist?, dif_pos hex]
  let k := Classical.choose (exists_min_pathLength G u v hex)
  have hspec := Classical.choose_spec (exists_min_pathLength G u v hex)
  have hkpath : Nonempty (PathLength G u v k) := hspec.1
  have hkmin : ∀ m, m < k → ¬ Nonempty (PathLength G u v m) := hspec.2
  have hle1 : k ≤ d := by
    by_cases h : d < k
    · exact absurd hdpath (hkmin d h)
    · exact Nat.le_of_not_gt h
  have hle2 : d ≤ k := by
    by_cases h : k < d
    · exact absurd hkpath (hdmin k h)
    · exact Nat.le_of_not_gt h
  congr
  exact Nat.le_antisymm hle1 hle2

end FMT.Graph
