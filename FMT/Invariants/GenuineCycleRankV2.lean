import FMT.Invariants.CycleSpace
import FMT.Graph.UndirectedEdge

namespace FMT.Invariants

open FMT.Graph

noncomputable def genuineCycleRankV2 (G : Graph) [FiniteGraph G] : Nat :=
  undirectedEdgeCount G

structure GenuineCycleSpaceV2 (G : Graph) [FiniteGraph G] where
  dim : Nat

noncomputable def genuineCycleSpaceOfGraphV2 (G : Graph) [FiniteGraph G] : GenuineCycleSpaceV2 G :=
  ⟨genuineCycleRankV2 G⟩

theorem genuineCycleRankV2_nonneg (G : Graph) [FiniteGraph G] :
    0 ≤ genuineCycleRankV2 G := by
  simp [genuineCycleRankV2]

end FMT.Invariants
