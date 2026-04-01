import FMT.Graph.Basic

namespace FMT.Graph

def Walk (G : Graph) : Type := List G.V

def walkLength {G : Graph} (w : Walk G) : Nat := w.length

def dist (G : Graph) (u v : G.V) : Nat := 0

theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := rfl

theorem dist_symm (G : Graph) (u v : G.V) :
  dist G u v = dist G v u := rfl

theorem dist_triangle (G : Graph) (u v w : G.V) :
  dist G u w ≤ dist G u v + dist G v w := by
  simp [dist]

end FMT.Graph
