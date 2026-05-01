import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem existsMinPath
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v : G.V)
  (hex : ∃ n, Nonempty (PathLength G u v n)) :
  ∃ n, Nonempty (PathLength G u v n) ∧
    ∀ k, k < n → ¬ Nonempty (PathLength G u v k) := by
  exact FMT.Inputs.SLASHAxioms.exists_shortest_path_length
    (G:=G) (u:=u) (v:=v) hex

end FMT.Graph
