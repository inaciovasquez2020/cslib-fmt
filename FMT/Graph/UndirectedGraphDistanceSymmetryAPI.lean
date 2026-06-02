import FMT.Graph.GlobalDistanceAxiomDischarge
import FMT.Graph.UndirectedEdge

namespace FMT.Graph

class UndirectedGraph (G : Graph) : Prop where
  symmAdj : SymmAdj G

theorem symmAdj_of_undirectedGraph
    (G : Graph) [h : UndirectedGraph G] :
    SymmAdj G := by
  exact h.symmAdj

theorem global_dist?_symmetry_from_UndirectedGraph
    {G : Graph} [UndirectedGraph G]
    (u v : G.V) :
    dist? (G := G) u v = dist? (G := G) v u := by
  exact global_dist?_symmetry_from_SymmAdj
    (G := G) (symmAdj_of_undirectedGraph G) u v

end FMT.Graph
