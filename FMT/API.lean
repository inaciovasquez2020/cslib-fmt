import FMT.Types.LocalType
import FMT.Invariants.Eval

namespace FMT.API

def evalLocal : FMT.Types.LocalType → Nat := fun _ => 0

theorem evalLocal_const (x : FMT.Types.LocalType) :
  evalLocal x = 0 := rfl

end FMT.API
