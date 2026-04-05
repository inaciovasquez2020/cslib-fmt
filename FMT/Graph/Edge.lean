import FMT.Graph.Finite
import Mathlib

namespace FMT.Graph

def Edge (G : Graph) [FiniteGraph G] : Type :=
  { p : G.V × G.V // G.Adj p.1 p.2 }

instance (G : Graph) [FiniteGraph G] : DecidableEq (Edge G) := by
  unfold Edge
  infer_instance

noncomputable instance (G : Graph) [FiniteGraph G] : Fintype (Edge G) := by
  unfold Edge
  infer_instance

noncomputable def edgeCount (G : Graph) [FiniteGraph G] : Nat :=
  Fintype.card (Edge G)

theorem edgeCount_nonneg (G : Graph) [FiniteGraph G] :
    0 ≤ edgeCount G := by
  omega

end FMT.Graph
