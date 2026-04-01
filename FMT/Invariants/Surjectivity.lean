import FMT.Types.LocalType
import FMT.Invariants.Eval

namespace FMT.Invariants

theorem eval_surjective :
  ∀ n : Nat, n = 0 ∨ n = 1 → ∃ t : FMT.Types.LocalType, evalLocal t = n := by
  intro n h
  cases h with
  | inl h0 =>
      refine ⟨false, ?_⟩
      simp [evalLocal, h0]
  | inr h1 =>
      refine ⟨true, ?_⟩
      simp [evalLocal, h1]

end FMT.Invariants
