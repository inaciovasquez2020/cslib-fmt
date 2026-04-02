import FMT.Graph.PathLength
import FMT.Graph.PathLengthLemmas

namespace FMT.Graph

axiom exists_min_pathLength
  (G : Graph) (u v : G.V)
  (h : ∃ n, Nonempty (PathLength G u v n)) :
  ∃ d, Nonempty (PathLength G u v d) ∧
    ∀ m, m < d → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
