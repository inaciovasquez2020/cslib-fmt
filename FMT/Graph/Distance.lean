import FMT.Graph.DistancePath

open Classical

namespace FMT.Graph

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

theorem dist_eq_zero_of_eq (G : Graph) (u : G.V) :
  dist G u u = 0 := by
  classical
  unfold dist dist?
  have h0 := path_refl G u
  have hex : ∃ n, Nonempty (PathLength G u u n) := ⟨0, h0⟩
  simp [hex]
  have hspec :=
    (minNat (fun n => Nonempty (PathLength G u u n))
            (Classical.choose hex)
            (Classical.choose_spec hex)).2
  have hmin := hspec.2
  have : ¬ Nonempty (PathLength G u u 0) → False := by
    intro h; exact h h0
  have : (minNat _ _ _).1 = 0 := by
    apply Nat.le_antisymm
    · apply Nat.zero_le
    · by_contra hlt
      have : 0 < (minNat _ _ _).1 := Nat.pos_of_ne_zero (by exact hlt)
      exact (hspec.2 0 this) h0
  simp [this]

end FMT.Graph
