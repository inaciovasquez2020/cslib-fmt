import FMT.Graph.Basic

namespace FMT.Graph

def Walk (G : Graph) : Type := List G.V

def walkLength {G : Graph} (w : Walk G) : Nat := w.length

def dist (G : Graph) (u v : G.V) : Nat := 0

theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := rfl

end FMT.Graph
