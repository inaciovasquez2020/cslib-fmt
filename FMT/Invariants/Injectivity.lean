import FMT.Types.LocalType
import FMT.Invariants.Eval

namespace FMT.Invariants

theorem eval_injective :
  ∀ t₁ t₂ : FMT.Types.LocalType,
    evalLocal t₁ = evalLocal t₂ → t₁ = t₂ := by
  intro t₁ t₂ h
  cases t₁ <;> cases t₂ <;> simp [evalLocal] at h <;> try contradiction <;> rfl

end FMT.Invariants
