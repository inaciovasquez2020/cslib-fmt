import FMT.Types.LocalType
import FMT.Invariants.Eval

namespace FMT.API

def evalAPI (t : FMT.Types.LocalType) : Nat :=
  FMT.Invariants.evalLocal t

theorem evalAPI_spec (t : FMT.Types.LocalType) :
  evalAPI t = (if t then 1 else 0) := rfl

end FMT.API
