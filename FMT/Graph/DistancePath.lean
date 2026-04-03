import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

section CoreOnly

variable {p : Nat → Prop}

-- stub: witness only (no minimality, no recursion)
noncomputable def findWitness (hex : ∃ n, p n) : {n // p n} :=
  ⟨Classical.choose hex, Classical.choose_spec hex⟩

end CoreOnly

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (findWitness (p := fun n => Nonempty (PathLength G u v n)) h).1
  else
    none

theorem dist?_exists (G : Graph) (u v : G.V) {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) := by
  classical
  unfold dist? at h
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · simp [hex] at h
    cases h
    exact (findWitness (p := fun n => Nonempty (PathLength G u v n)) hex).2
  · simp [hex] at h

end FMT.Graph
