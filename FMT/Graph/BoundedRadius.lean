import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph


namespace FMT.Graph

-- distance on graphs (to be refined with paths later)
constant dist : Graph → Graph.V → Graph.V → Nat

-- bounded-radius ball as subtype
def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

end FMT.Graph
