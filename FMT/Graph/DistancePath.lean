import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

lemma nat_lt_zero_false (m : Nat) (h : m < 0) : False :=
  Nat.not_lt_zero _ h

private noncomputable def minNat (p : Nat → Prop) :
  (b : Nat) → p b → Σ n, p n
| 0, hb => ⟨0, hb⟩
| b+1, hb =>
  if hex : ∃ k ≤ b, p k then
    let k := Classical.choose hex
    have hk : p k := (Classical.choose_spec hex).2
    minNat p k hk
  else
    ⟨b+1, hb⟩

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (minNat (fun n => Nonempty (PathLength G u v n))
                 (Classical.choose h)
                 (Classical.choose_spec h)).1
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
    exact (minNat (fun n => Nonempty (PathLength G u v n))
                  (Classical.choose hex)
                  (Classical.choose_spec hex)).2
  · simp [hex] at h

end FMT.Graph
