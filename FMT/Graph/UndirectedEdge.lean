import FMT.Graph.Edge
import Mathlib

namespace FMT.Graph

def SymmAdj (G : Graph) : Prop :=
  ∀ u v : G.V, G.Adj u v → G.Adj v u

def UndirectedEdge (G : Graph) [FiniteGraph G] : Type :=
  Quot (fun p q : Edge G => p.1.1 = q.1.2 ∧ p.1.2 = q.1.1)

noncomputable def undirectedEdgeCount (G : Graph) [FiniteGraph G] : Nat :=
  Nat.card (UndirectedEdge G)

theorem undirectedEdgeCount_nonneg (G : Graph) [FiniteGraph G] :
    0 ≤ undirectedEdgeCount G := by
  omega

end FMT.Graph
