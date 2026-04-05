import FMT.Types.Factorization
import FMT.Types.LocalType

namespace FMT.Examples

open FMT.Types

def f (_x : Unit) : Nat := 0
def τ (_x : Unit) : LocalType := LocalType.zero

example : factorsThrough (fun _ : LocalType => 0) := by
  refine ⟨fun _ => 0, ?_⟩
  intro x
  rfl

end FMT.Examples
