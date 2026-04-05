import FMT.Graph.Finite

namespace FMT.Invariants

open FMT.Graph

structure CycleSpace (G : Graph) where
  dim : Nat

def vertexCount (G : Graph) [FiniteGraph G] : Nat :=
  Fintype.card G.V

def cycleSpaceOfGraph (G : Graph) [FiniteGraph G] : CycleSpace G :=
  ⟨vertexCount G⟩

theorem cycleDim_nonneg (G : Graph) [FiniteGraph G] :
    0 ≤ (cycleSpaceOfGraph G).dim := by
  omega

end FMT.Invariants
