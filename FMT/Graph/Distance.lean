import FMT.Graph.DistancePath

open Classical

namespace FMT.Graph

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

theorem dist_exists (G : Graph) {u v : G.V} {n : Nat}
  (h : dist G u v = n) :
  dist? G u v = some n ∨ (dist? G u v = none ∧ n = 0) := by
  unfold dist at h
  cases hdist : dist? G u v with
  | none =>
      simp [hdist] at h
      subst h
      exact Or.inr ⟨rfl, rfl⟩
  | some val =>
      simp [hdist] at h
      subst h
      exact Or.inl rfl

end FMT.Graph
