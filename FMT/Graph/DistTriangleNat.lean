import FMT.Graph.Distance
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

open FMT.Inputs

theorem dist_triangle_nat
  (G : Graph) [SLASHAxioms G] (u v w : G.V) {a b : Nat}
  (huv : dist? G u v = some a)
  (hvw : dist? G v w = some b) :
  dist G u w ≤ a + b := by
  unfold dist
  rcases SLASHAxioms.dist_triangle (G := G) u v w huv hvw with ⟨c, hcw, hle⟩
  simp [hcw, hle]

end FMT.Graph
