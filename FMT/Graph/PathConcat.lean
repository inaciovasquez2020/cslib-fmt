import FMT.Graph.PathLength

namespace FMT.Graph

axiom path_concat
  {G : Graph} {u v w : G.V} {n m : Nat} :
  PathLength G u v n → PathLength G v w m → PathLength G u w (n + m)

end FMT.Graph
