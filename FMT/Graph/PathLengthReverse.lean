import FMT.Graph.PathLength

namespace FMT.Graph

axiom pathLength_reverse
  (G : Graph)
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  {u v : G.V} {n : Nat} :
  PathLength G u v n → PathLength G v u n

end FMT.Graph
