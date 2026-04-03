import FMT.Graph.DistancePath

namespace FMT.Graph

axiom dist?_triangle
  (G : Graph) (u v w : G.V) {a b : Nat} :
  dist? G u v = some a →
  dist? G v w = some b →
  ∃ c, dist? G u w = some c ∧ c ≤ a + b

end FMT.Graph
