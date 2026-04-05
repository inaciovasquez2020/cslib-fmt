import FMT.Graph.DistanceCore
import FMT.Graph.PathLength

namespace FMT.Graph

axiom dist_is_shortest
  {G : Graph} (u v : G.V) :
  dist? (G:=G) u v = none ∨
  ∃ d, dist? (G:=G) u v = some d ∧
       ∀ m, m < d → ¬ Nonempty (PathLength G u v m)

end FMT.Graph
