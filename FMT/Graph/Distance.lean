import FMT.Graph.DistancePath

open Classical

namespace FMT.Graph

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

-- weaken: remove false goal (choose = 0)
theorem dist_eq_zero_of_eq (G : Graph) (u : G.V)
  (h0 : Nonempty (PathLength G u u 0)) :
  dist G u u ≤ 0 := by
  classical
  unfold dist dist?
  have hex : ∃ n, Nonempty (PathLength G u u n) := ⟨0, h0⟩
  simp [hex]

end FMT.Graph
