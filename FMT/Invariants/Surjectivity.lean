import FMT.Types.LocalType

namespace FMT.Invariants

open FMT.Types

theorem eval_surjective01 :
  ∀ n : Nat, n = 0 ∨ n = 1 → ∃ t : FMT.Types.LocalType, evalLocal t = n := by
  intro n h
  rcases h with h0 | h1
  · refine ⟨LocalType.zero, ?_⟩
    simp [evalLocal, h0]
  · refine ⟨LocalType.one, ?_⟩
    simp [evalLocal, h1]

end FMT.Invariants
