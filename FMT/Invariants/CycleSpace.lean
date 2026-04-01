import FMT.Graph.Basic

namespace FMT.Invariants

structure CycleSpace where
  dim : Nat

def cycleRank (V E c : Nat) : CycleSpace :=
  ⟨E - V + c⟩

end FMT.Invariants
