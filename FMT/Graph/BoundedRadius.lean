import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

end FMT.Graph
