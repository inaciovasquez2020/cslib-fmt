import FMT.Graph.DistanceCore
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_triangle
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v w : G.V) {a b : Nat} :
  dist? G u v = some a →
  dist? G v w = some b →
  ∃ c, dist? G u w = some c ∧ c ≤ a + b :=
  FMT.Inputs.SLASHAxioms.dist_triangle u v w

end FMT.Graph
