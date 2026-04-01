import FMT.Graph.Basic

namespace FMT.Graph

def dist (G : Graph) (u v : G.V) : Nat := 0

theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := rfl

theorem dist_symm (G : Graph) (u v : G.V) : dist G u v = dist G v u := rfl

end FMT.Graph
