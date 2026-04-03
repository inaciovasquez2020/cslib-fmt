import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

-- minimal witness via well-founded recursion
private noncomputable def minNat (p : Nat → Prop) :
  (b : Nat) → p b → {n // p n ∧ ∀ m < n, ¬ p m}
| 0, hb => ⟨0, hb, by intro m hm; exact Nat.not_lt_zero _ hm⟩
| b+1, hb =>
  if hex : ∃ k ≤ b, p k then
    let k := Classical.choose hex
    have hk : p k := (Classical.choose_spec hex).2
    have hk' : k ≤ b := (Classical.choose_spec hex).1
    have : k < b+1 := Nat.lt_succ_of_le hk'
    minNat p k hk
  else
    ⟨b+1, hb, by
      intro m hm hpm
      have : m ≤ b := Nat.le_of_lt_succ hm
      exact hex ⟨m, this, hpm⟩⟩

-- existence of trivial path (axiom layer)
axiom path_refl (G : Graph) (u : G.V) :
  Nonempty (PathLength G u u 0)

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (minNat (fun n => Nonempty (PathLength G u v n))
                 (Classical.choose h)
                 (Classical.choose_spec h)).1
  else
    none

theorem dist?_spec (G : Graph) (u v : G.V) {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) ∧
  ∀ m < n, ¬ Nonempty (PathLength G u v m) := by
  classical
  unfold dist? at h
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · simp [hex] at h
    have hmin :=
      (minNat (fun n => Nonempty (PathLength G u v n))
              (Classical.choose hex)
              (Classical.choose_spec hex)).2
    have : _ = n := Option.some.inj h
    subst this
    exact hmin
  · simp [hex] at h

theorem shortest_path_selector
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) :=
  (dist?_spec G u v h).1

end FMT.Graph
