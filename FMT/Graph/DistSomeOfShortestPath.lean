import FMT.Graph.DistanceCore

namespace FMT.Graph

axiom shortest_selector
  (G : Graph) (u v : G.V) :
  Σ' d : Nat,
    Nonempty (PathLength G u v d) ×
    (∀ m, m < d → ¬ Nonempty (PathLength G u v m))

theorem dist?_some_of_shortest_path
  (G : Graph) {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  dist? G u v = some d := by
  have hs := shortest_selector G u v
  rcases hs with ⟨d0, hd0, hmin0⟩
  have h1 : d0 ≤ d := by
    by_cases hlt : d < d0
    · exfalso
      exact hmin0 d hlt hdpath
    · exact Nat.le_of_not_gt hlt
  have h2 : d ≤ d0 := by
    by_cases hlt : d0 < d
    · exfalso
      exact hdmin d0 hlt hd0
    · exact Nat.le_of_not_gt hlt
  have hEq : d0 = d := Nat.le_antisymm h1 h2
  subst hEq
  unfold dist?
  simp [shortest_selector]

end FMT.Graph
