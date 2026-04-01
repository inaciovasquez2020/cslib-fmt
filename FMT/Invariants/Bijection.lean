import FMT.Types.LocalType
import FMT.Invariants.Eval
import FMT.Invariants.Injectivity
import FMT.Invariants.Surjectivity

namespace FMT.Invariants

theorem eval_bijective :
  (∀ t₁ t₂ : FMT.Types.LocalType,
      evalLocal t₁ = evalLocal t₂ → t₁ = t₂) ∧
  (∀ n : Nat, n = 0 ∨ n = 1 →
      ∃ t : FMT.Types.LocalType, evalLocal t = n) :=
by
  constructor
  · exact eval_injective
  · exact eval_surjective

end FMT.Invariants
