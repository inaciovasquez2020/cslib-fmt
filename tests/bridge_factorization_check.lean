import FMT.Bridge.LocalGlobal
import FMT.Types.Factorization

namespace FMT.Bridge

open FMT.Types

example : FactorsThrough evalLocal localProjection :=
  localToGlobal

example (x : LocalType) : evalLocal x = localToGlobal.lift (localProjection x) := by
  exact localToGlobal.comm x

example (x : LocalType) : globalLift (localProjection x) = evalLocal x := by
  rfl

end FMT.Bridge
