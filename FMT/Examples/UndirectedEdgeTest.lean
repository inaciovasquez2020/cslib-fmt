import FMT.Graph.UndirectedEdge
import FMT.Examples.CycleRankThreeVertex
import Mathlib

namespace FMT.Examples

open FMT.Graph

example : SymmAdj triangleGraph := by
  intro u v h
  cases u <;> cases v <;> simp [triangleGraph] at h ⊢

example : 0 ≤ undirectedEdgeCount triangleGraph := by
  exact undirectedEdgeCount_nonneg triangleGraph

end FMT.Examples
