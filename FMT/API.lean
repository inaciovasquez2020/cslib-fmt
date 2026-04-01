import FMT.Types.LocalType
import FMT.Invariants.Eval

namespace FMT.API

def evalAPI (t : FMT.Types.LocalType) : Nat :=
  match t with
  | true => 1
  | false => 0

theorem evalAPI_spec (t : FMT.Types.LocalType) :
  evalAPI t = (match t with | true => 1 | false => 0) := rfl

end FMT.API
