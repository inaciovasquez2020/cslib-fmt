import FMT.Types.LocalType

namespace FMT.Invariants

def evalLocal (t : FMT.Types.LocalType) : Nat :=
  if t then 1 else 0

theorem evalLocal_spec (t : FMT.Types.LocalType) :
  evalLocal t = (if t then 1 else 0) := rfl

end FMT.Invariants
