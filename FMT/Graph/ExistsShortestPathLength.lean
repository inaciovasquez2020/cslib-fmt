import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms
import FMT.Inputs.ConstructiveSLASHAxioms

namespace FMT.Graph

theorem exists_shortest_path_length
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v : G.V) :
  (∃ n, Nonempty (PathLength G u v n)) →
  ∃ n, Nonempty (PathLength G u v n) ∧
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) :=
  FMT.Inputs.SLASHAxioms.exists_shortest_path_length u v

end FMT.Graph
