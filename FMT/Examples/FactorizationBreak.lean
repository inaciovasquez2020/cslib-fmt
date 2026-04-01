import FMT.Types.Factorization
import FMT.Types.LocalType

namespace FMT.Examples

open FMT.Types

def f (x : Bool) : Nat := if x then 1 else 0

def τ (x : Bool) : LocalType := x

example : FactorsThrough f τ := by
  exact ⟨fun b => if b then 1 else 0, by intro x; cases x <;> rfl⟩

end FMT.Examples
