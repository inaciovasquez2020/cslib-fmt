import FMT.Graph.PathLength
import FMT.Graph.PathLengthLemmas

namespace FMT.Graph

open Classical

theorem exists_min_pathLength
  (G : Graph) (u v : G.V)
  (h : ∃ n, Nonempty (PathLength G u v n)) :
  ∃ d, Nonempty (PathLength G u v d) ∧
    ∀ m, m < d → ¬ Nonempty (PathLength G u v m) := by
  classical
  let P : Nat → Prop := fun n => Nonempty (PathLength G u v n)
  have haux :
      ∀ d, (∃ k, k ≤ d ∧ P k) →
        ∃ k, k ≤ d ∧ P k ∧ ∀ m, m < k → ¬ P m := by
    intro d
    induction d with
    | zero =>
        intro hex
        rcases hex with ⟨k, hk0, hkP⟩
        have hk : k = 0 := Nat.le_zero.mp hk0
        refine ⟨0, by omega, ?_, ?_⟩
        · simpa [P, hk] using hkP
        · intro m hm
          omega
    | succ d ih =>
        intro hex
        by_cases hsmall : ∃ k, k ≤ d ∧ P k
        · rcases ih hsmall with ⟨k, hk_le, hkP, hkmin⟩
          exact ⟨k, Nat.le_trans hk_le (Nat.le_succ _), hkP, hkmin⟩
        · rcases hex with ⟨k, hk_le_succ, hkP⟩
          have hk_not_le : ¬ k ≤ d := by
            intro hk_le
            exact hsmall ⟨k, hk_le, hkP⟩
          have hk_eq : k = d + 1 := by
            omega
          refine ⟨d + 1, by omega, ?_, ?_⟩
          · simpa [P, hk_eq] using hkP
          · intro m hm hmP
            exact hsmall ⟨m, Nat.le_of_lt_succ hm, hmP⟩
  rcases h with ⟨d, hd⟩
  rcases haux d ⟨d, by omega, hd⟩ with ⟨k, _, hkP, hkmin⟩
  exact ⟨k, hkP, hkmin⟩

end FMT.Graph
