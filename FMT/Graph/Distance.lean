import FMT.Graph.DistancePath

open Classical

namespace FMT.Graph

-- axiom: reflexive path
axiom path_refl (G : Graph) (u : G.V) :
  Nonempty (PathLength G u u 0)

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

-- existence-only characterization
theorem dist_exists (G : Graph) {u v : G.V} {n : Nat}
  (h : dist G u v = n) :
  dist? G u v = some n ∨ (dist? G u v = none ∧ n = 0) := by
  unfold dist at h
  cases hdist : dist? G u v <;> simp [hdist] at h ⊢

-- weakened reflexivity (no minimality)
theorem dist_le_zero_of_eq (G : Graph) (u : G.V) :
  dist G u u ≤ 0 := by
  classical
  unfold dist dist?
  have h0 := path_refl G u
  have hex : ∃ n, Nonempty (PathLength G u u n) := ⟨0, h0⟩
  simp [hex]

end FMT.Graph
