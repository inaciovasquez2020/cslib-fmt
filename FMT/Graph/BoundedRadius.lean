import FMT.Graph.Basic

namespace FMT.Graph

def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // True }

end FMT.Graph
