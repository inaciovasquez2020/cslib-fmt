import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose h)
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
    exact Classical.choose_spec hex
  · simp [hex] at h

theorem path_of_dist?_some
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) :=
  shortest_path_selector G h

axiom dist?_bound_of_path
  (G : Graph) {u v : G.V} {n : Nat} :
  Nonempty (PathLength G u v n) → Nat

theorem dist?_cases (G : Graph) (u v : G.V) :
  (∃ n, dist? G u v = some n) ∨ dist? G u v = none := by
  classical
  unfold dist?
  by_cases h : ∃ n, Nonempty (PathLength G u v n)
  · left
    refine ⟨Classical.choose h, ?_⟩
    simp [h]
  · right
    simp [h]

end FMT.Graph
