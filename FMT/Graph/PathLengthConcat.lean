import FMT.Graph.PathLength
import FMT.Graph.PathLengthAccessors

namespace FMT.Graph

axiom pathLength_concat (G : Graph) {u v w : G.V} {m n : Nat} :
  PathLength G u v m → PathLength G v w n → PathLength G u w (m + n)

end FMT.Graph
