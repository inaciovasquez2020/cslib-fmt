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
  · have : some (Classical.choose hex) = some n := by simpa [hex] using h
    have hEq : Classical.choose hex = n := Option.some.inj this
    subst hEq
    exact Classical.choose_spec hex
  · simp [hex] at h

end FMT.Graph
