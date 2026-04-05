import FMT.Invariants.GenuineCycleRankV2
import FMT.Examples.GenuineCycleRankWitnessV2
import FMT.Examples.GenuineCycleRankPath3WitnessV2
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

example : 0 ≤ genuineCycleRankV2 trivialGraph := by
  exact genuineCycleRankV2_nonneg trivialGraph

example : 0 ≤ genuineCycleRankV2 path3Graph := by
  exact genuineCycleRankV2_nonneg path3Graph

example : (cycleSpaceOfGraph trivialGraph).dim = 1 := by
  simp [cycleSpaceOfGraph, vertexCount, trivialGraph]

example : (cycleSpaceOfGraph path3Graph).dim = 3 := by
  native_decide

end FMT.Examples
