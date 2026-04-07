import FMT.Invariants.GenuineCycleRankV2
import FMT.Examples.CycleSpaceTest
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

example : (cycleSpaceOfGraph trivialGraph).dim = 1 := by
  simp [cycleSpaceOfGraph, vertexCount, trivialGraph]

example : 0 ≤ genuineCycleRankV2 trivialGraph := by
  exact genuineCycleRankV2_nonneg trivialGraph

end FMT.Examples
