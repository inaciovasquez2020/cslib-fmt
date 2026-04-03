import FMT.Graph.PathLength
import Mathlib.Tactic

open Classical

namespace FMT.Graph

section MinNat

variable {p : Nat → Prop} [DecidablePred p]

lemma minNat_minimal {k : Nat} (hk : ∀ m < k, ¬ p m) (h : ¬ p k) :
    ∀ m < k + 1, ¬ p m := by
  intro m hm
  have : m < k ∨ m = k := Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hm)
  rcases this with hlt | rfl
  · exact hk m hlt
  · exact h

lemma nat_lt_zero_false {m : Nat} (hm : m < 0) : False :=
  Nat.not_lt_zero m hm

noncomputable def findMinAux (hex : ∃ n, p n) (k : Nat)
    (hk : ∀ m < k, ¬ p m) : {n // p n} :=
  if h : p k then
    ⟨k, h⟩
  else
    let b := Classical.choose hex
    have hb : p b := Classical.choose_spec hex
    have hk_le_b : k ≤ b := by
      by_contra h_not_le
      exact hk b (Nat.lt_of_not_le h_not_le) hb
    have hk_ne_b : k ≠ b := by
      intro h_eq; subst h_eq; exact h hb
    have hk_lt_b : k < b := Nat.lt_of_le_of_ne hk_le_b hk_ne_b
    findMinAux hex (k + 1) (minNat_minimal hk h)
termination_by Classical.choose hex - k
decreasing_by
  exact Nat.sub_lt_sub_left hk_lt_b (Nat.lt_succ_self k)

noncomputable def findMin (hex : ∃ n, p n) : {n // p n} :=
  findMinAux hex 0 (fun m hm => False.elim (nat_lt_zero_false hm))

end MinNat

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (findMin (p := fun n => Nonempty (PathLength G u v n)) h).1
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
    exact (findMin (p := fun n => Nonempty (PathLength G u v n)) hex).2
  · simp [hex] at h

end FMT.Graph
