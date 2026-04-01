import FMT.Graph.Basic
import FMT.Game.EF
import FMT.Types.LocalType
import FMT.Invariants.CycleSpace

namespace FMT

def extractType (n : Nat) : Types.LocalType :=
  ⟨n⟩

def invariantDim (n : Nat) : Invariants.CycleSpace :=
  ⟨n⟩

end FMT
