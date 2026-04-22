import FMT.Types.LocalType
import FMT.Types.Factorization

namespace FMT.Bridge

open FMT.Types

def localProjection : LocalType → LocalType := id

def globalLift : LocalType → Nat := evalLocal

def localToGlobal : FactorsThrough evalLocal localProjection :=
  ⟨globalLift, by
    intro x
    rfl⟩

end FMT.Bridge
