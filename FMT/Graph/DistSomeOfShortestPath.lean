import FMT.Graph.DistanceCore
import FMT.Graph.PathLength

namespace FMT.Graph

axiom dist?_some_of_shortest_path
  {G : Graph} {u v : G.V} {d : Nat} :
  Nonempty (PathLength G u v d) →
  (∀ m, m < d → ¬ Nonempty (PathLength G u v m)) →
  dist? (G:=G) u v = some d

end FMT.Graph
