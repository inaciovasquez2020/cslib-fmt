import FMT.Types.LocalType

namespace FMT.Types

def localCode : LocalType → Nat := evalLocal

theorem localCode_zero :
  localCode LocalType.zero = 0 := by
  rfl

theorem localCode_one :
  localCode LocalType.one = 1 := by
  rfl

theorem localCode_separates :
  localCode LocalType.zero ≠ localCode LocalType.one := by
  intro h
  cases h

end FMT.Types
