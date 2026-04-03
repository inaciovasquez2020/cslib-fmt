import FMT.Graph.DistanceCore
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_some_of_shortest_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  dist? G u v = some d :=
  FMT.Inputs.SLASHAxioms.dist_some_of_shortest_path hdpath hdmin

end FMT.Graph
