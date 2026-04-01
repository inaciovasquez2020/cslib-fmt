import FMT.Types.Factorization
import FMT.Types.LocalType

namespace FMT.Examples

open FMT.Types

def f (x : Bool) : Nat := if x then 1 else 0

def τ (x : Bool) : LocalType := ()

-- This should fail if FactorsThrough is meaningful
example : ¬ FactorsThrough f τ := by
  intro h
  cases h with
  | intro g hg =>
    have h₁ := hg true
    have h₂ := hg false
    simp at h₁ h₂
    contradiction

end FMT.Examples
