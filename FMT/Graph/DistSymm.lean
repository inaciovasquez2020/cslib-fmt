import FMT.Graph.DistancePath

namespace FMT.Graph

axiom dist?_symm
  (G : Graph) (u v : G.V) :
  dist? G u v = dist? G v u

end FMT.Graph
