import FMT.Graph.DistanceCore
import FMT.Graph.PathLength

namespace FMT.Graph

axiom dist?_some_of_path
  {G : Graph} {u v : G.V} {n : Nat} :
  PathLength G u v n → dist? G u v = some n

end FMT.Graph
