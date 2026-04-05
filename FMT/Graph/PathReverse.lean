import FMT.Graph.PathLength

namespace FMT.Graph

axiom path_reverse
  {G : Graph} {u v : G.V} {n : Nat} :
  PathLength G u v n → PathLength G v u n

end FMT.Graph
