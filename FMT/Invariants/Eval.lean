import FMT.Types.LocalType

namespace FMT.Invariants

def evalLocal (t : FMT.Types.LocalType) : Nat :=
  match t with
  | true => 1
  | false => 0

theorem evalLocal_spec (t : FMT.Types.LocalType) :
  evalLocal t = (match t with | true => 1 | false => 0) := rfl

end FMT.Invariants
