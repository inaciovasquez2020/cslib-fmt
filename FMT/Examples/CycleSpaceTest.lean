import FMT.Invariants.CycleSpace
import FMT.Examples.HighGirthLift
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

instance : FiniteGraph trivialGraph where
  fintypeV := by
    change Fintype Unit
    infer_instance
  decEqV := by
    change DecidableEq Unit
    infer_instance
  decAdj := by
    intro a b
    change Decidable False
    infer_instance

example : vertexCount trivialGraph = 1 := by
  simp [vertexCount, trivialGraph]

example : (cycleSpaceOfGraph trivialGraph).dim = 1 := by
  simp [cycleSpaceOfGraph, vertexCount, trivialGraph]

end FMT.Examples
