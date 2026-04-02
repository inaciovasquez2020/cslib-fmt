import FMT.Graph.PathLength

namespace FMT.Graph

/-- Concatenate a path u -> v of length m and a path v -> w of length n. -/
axiom pathLength_concat (G : Graph) {u v w : G.V} {m n : Nat} :
  PathLength G u v m → PathLength G v w n → PathLength G u w (m + n)

end FMT.Graph
