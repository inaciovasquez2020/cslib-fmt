import FMT.Graph.PathLength
import FMT.Graph.ExistsMinPathLength

open Classical

namespace FMT.Graph

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose (exists_min_pathLength G u v h))
  else
    none

theorem path_of_dist?_some
    (G : Graph) {u v : G.V} {n : Nat}
    (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) := by
  unfold dist? at h
  by_cases hex : ∃ m, Nonempty (PathLength G u v m)
  · rw [dif_pos hex] at h
    have heq : Classical.choose (exists_min_pathLength G u v hex) = n :=
      Option.some.inj h
    have hspec := Classical.choose_spec (exists_min_pathLength G u v hex)
    rw [← heq]
    exact hspec.1
  · rw [dif_neg hex] at h
    cases h

theorem dist?_minimal
    (G : Graph) {u v : G.V} {n : Nat}
    (h : dist? G u v = some n) :
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  unfold dist? at h
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · rw [dif_pos hex] at h
    have heq : Classical.choose (exists_min_pathLength G u v hex) = n :=
      Option.some.inj h
    have hspec := Classical.choose_spec (exists_min_pathLength G u v hex)
    rw [← heq]
    exact hspec.2
  · rw [dif_neg hex] at h
    cases h

theorem dist?_cases (G : Graph) (u v : G.V) :
    (∃ n, dist? G u v = some n) ∨ dist? G u v = none := by
  unfold dist?
  by_cases hex : ∃ n, Nonempty (PathLength G u v n)
  · rw [dif_pos hex]
    exact Or.inl ⟨_, rfl⟩
  · rw [dif_neg hex]
    exact Or.inr rfl

end FMT.Graph
