import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse

namespace FMT.Graph

axiom dist?_symm
  (G : Graph)
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  {u v : G.V} :
  dist? G u v = dist? G v u

end FMT.Graph
