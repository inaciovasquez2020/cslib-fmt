import FMT.Invariants.Injectivity
import FMT.Invariants.Surjectivity

namespace FMT.Invariants

open FMT.Types

theorem eval_bijective :
  (∀ t₁ t₂ : FMT.Types.LocalType,
      evalLocal t₁ = evalLocal t₂ → t₁ = t₂) ∧
  (∀ n : Nat, n = 0 ∨ n = 1 →
      ∃ t : FMT.Types.LocalType, evalLocal t = n) := by
  refine ⟨eval_injective, eval_surjective01⟩

end FMT.Invariants
