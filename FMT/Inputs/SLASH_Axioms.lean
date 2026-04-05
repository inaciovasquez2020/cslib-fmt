import FMT.Graph.DistanceCore
import FMT.Graph.PathLength

namespace FMT.Inputs

class SLASHAxioms (G : FMT.Graph.Graph) where
  exists_shortest_path_length :
    ∀ (u v : G.V),
    (∃ n, Nonempty (FMT.Graph.PathLength G u v n)) →
    ∃ d, Nonempty (FMT.Graph.PathLength G u v d) ∧
      ∀ m, m < d → ¬ Nonempty (FMT.Graph.PathLength G u v m)

end FMT.Inputs
