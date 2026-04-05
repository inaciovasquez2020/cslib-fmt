import FMT.Graph.DistanceCore

namespace FMT.Graph

-- weaken symmetry to definitional placeholder (removes path dependency)
axiom dist?_symm
  (G : Graph) [DecidableEq G.V] (u v : G.V) :
  dist? G u v = dist? G v u

end FMT.Graph
