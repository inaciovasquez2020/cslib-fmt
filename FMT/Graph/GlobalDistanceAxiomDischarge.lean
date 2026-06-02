import FMT.Graph.ExistsMinPathLength
import FMT.Graph.GlobalDistanceTheorems
import FMT.Graph.UndirectedEdge
import FMT.Inputs.SLASH_Axioms

namespace FMT.Inputs

instance globalSLASHAxioms (G : FMT.Graph.Graph) : SLASHAxioms G where
  exists_shortest_path_length := by
    intro u v h
    exact FMT.Graph.exists_min_pathLength G u v h

end FMT.Inputs

namespace FMT.Graph

theorem global_dist?_symmetry_from_SymmAdj
    {G : Graph}
    (hsymm : SymmAdj G)
    (u v : G.V) :
    dist? (G := G) u v = dist? (G := G) v u := by
  exact global_dist?_symmetry (G := G) hsymm u v

theorem global_dist?_triangle_unconditional
    (G : Graph)
    (u v w : G.V) {m n : Nat}
    (huv : dist? (G := G) u v = some m)
    (hvw : dist? (G := G) v w = some n) :
    ∃ d, dist? (G := G) u w = some d ∧ d ≤ m + n := by
  exact global_dist?_triangle (G := G) u v w huv hvw

end FMT.Graph
