import FMT.Types.LocalType
import FMT.Invariants.CycleSpace

namespace FMT.Invariants

def factorsThroughLocalTypes : Prop := False

theorem nonFactorization : ¬ factorsThroughLocalTypes := by
  intro h
  exact h

end FMT.Invariants
