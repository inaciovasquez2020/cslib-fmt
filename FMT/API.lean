import FMT.Graph.Basic
import FMT.Types.LocalType
import FMT.Invariants.CycleSpace

namespace FMT

structure Query where
  radius : Nat

def extractType (q : Query) (n : Nat) : Types.LocalType :=
  ⟨q.radius + n⟩

def invariantDim (V E c : Nat) : Invariants.CycleSpace :=
  ⟨E - V + c⟩

end FMT
