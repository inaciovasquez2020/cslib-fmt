import FMT.Graph.DistSymm
import FMT.Graph.DistTriangle

namespace FMT.Graph

theorem global_dist?_symmetry
    {G : Graph} [FMT.Inputs.SLASHAxioms G]
    (hsymm : ∀ (a b : G.V), G.Adj a b → G.Adj b a)
    (u v : G.V) :
    dist? (G := G) u v = dist? (G := G) v u := by
  exact dist?_symm (G := G) hsymm u v

theorem global_dist?_triangle
    (G : Graph) [FMT.Inputs.SLASHAxioms G]
    (u v w : G.V) {m n : Nat}
    (huv : dist? (G := G) u v = some m)
    (hvw : dist? (G := G) v w = some n) :
    ∃ d, dist? (G := G) u w = some d ∧ d ≤ m + n := by
  exact dist?_triangle (G := G) (u := u) (v := v) (w := w) huv hvw

end FMT.Graph
