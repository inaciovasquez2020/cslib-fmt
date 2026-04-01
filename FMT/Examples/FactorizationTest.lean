import FMT.Types.Factorization
import FMT.Types.LocalType

namespace FMT.Examples

open FMT.Types

def f (x : Unit) : Nat := 0

def τ (x : Unit) : LocalType := ()

example : FactorsThrough f τ := by
  exact ⟨fun _ => 0, by intro x; rfl⟩

end FMT.Examples
