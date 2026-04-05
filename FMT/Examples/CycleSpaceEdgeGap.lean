import FMT.Invariants.CycleSpace
import FMT.Graph.Edge
import FMT.Examples.CycleSpaceTest
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

example : edgeCount trivialGraph = 0 := by
  simp [edgeCount, Edge, trivialGraph]

example : vertexCount trivialGraph = 1 := by
  simp [vertexCount, trivialGraph]

example : edgeCount trivialGraph ≠ vertexCount trivialGraph := by
  simp [edgeCount, Edge, vertexCount, trivialGraph]

example : (cycleSpaceOfGraph trivialGraph).dim = vertexCount trivialGraph := by
  rfl

end FMT.Examples
