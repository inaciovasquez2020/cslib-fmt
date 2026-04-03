import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

def IsMinPathLength (G : Graph) (u v : G.V) (n : Nat) : Prop :=
  Nonempty (PathLength G u v n) ∧ ∀ m < n, ¬ Nonempty (PathLength G u v m)

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose (by
      rcases h with ⟨n, hn⟩
      exact ⟨n, ⟨hn, by intro m hm; intro h'; exact False.elim (by cases hm)⟩⟩))
  else
    none

theorem shortest_path_selector
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) := by
  classical
  unfold dist? at h
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · simp [hex] at h
    cases h
    exact (Classical.choose_spec _).left
  · simp [hex] at h

end FMT.Graph
