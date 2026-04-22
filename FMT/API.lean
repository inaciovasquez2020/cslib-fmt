import FMT.Types.LocalType
import FMT.Types.Factorization
import FMT.Bridge.LocalGlobal

namespace FMT

open FMT.Types

def useLocalType : LocalType := LocalType.one

def useLocalFactorization : FactorsThrough evalLocal FMT.Bridge.localProjection :=
  FMT.Bridge.localToGlobal

end FMT
