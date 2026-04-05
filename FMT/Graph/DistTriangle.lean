import FMT.Graph.DistanceCore
import FMT.Graph.PathConcat

namespace FMT.Graph

axiom dist?_triangle
  {G : Graph} (u v w : G.V) :
  match dist? (G:=G) u v, dist? v w with
  | some a, some b => ∃ c, dist? u w = some c ∧ c ≤ a + b
  | _, _ => True

end FMT.Graph
