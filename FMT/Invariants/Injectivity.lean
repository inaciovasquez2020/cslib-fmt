import FMT.Types.LocalType

namespace FMT.Invariants

open FMT.Types

theorem eval_injective :
  ∀ t₁ t₂ : FMT.Types.LocalType,
    evalLocal t₁ = evalLocal t₂ → t₁ = t₂ := by
  intro t₁ t₂ h
  cases t₁ <;> cases t₂ <;> simp [evalLocal] at h ⊢

end FMT.Invariants
