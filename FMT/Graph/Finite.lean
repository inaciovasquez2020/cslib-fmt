import FMT.Graph.Basic
import Mathlib

namespace FMT.Graph

class FiniteGraph (G : Graph) where
  fintypeV : Fintype G.V
  decEqV : DecidableEq G.V
  decAdj : DecidableRel G.Adj

@[reducible] instance finiteGraphFintype (G : Graph) [h : FiniteGraph G] : Fintype G.V :=
  h.fintypeV

@[reducible] instance finiteGraphDecEq (G : Graph) [h : FiniteGraph G] : DecidableEq G.V :=
  h.decEqV

@[reducible] instance finiteGraphDecAdj (G : Graph) [h : FiniteGraph G] : DecidableRel G.Adj :=
  h.decAdj

end FMT.Graph
