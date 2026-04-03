import FMT.Graph.DistanceCore
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_le_of_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
  Nonempty (PathLength G u v n) →
  ∃ d, dist? G u v = some d ∧ d ≤ n :=
  FMT.Inputs.SLASHAxioms.dist_le_of_path

def dist?_bound_of_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
  Nonempty (PathLength G u v n) → Nat :=
  FMT.Inputs.SLASHAxioms.dist_bound_of_path

end FMT.Graph
