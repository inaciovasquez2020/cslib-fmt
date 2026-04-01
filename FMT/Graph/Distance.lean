import FMT.Graph.Basic

namespace FMT.Graph

-- minimal stub to restore build
def dist (G : Graph) (u v : G.V) : Nat := 0

theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := rfl

end FMT.Graph
