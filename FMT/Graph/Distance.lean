import FMT.Graph.Basic

namespace FMT.Graph

variable [DecidableEq G.V]

def dist (G : Graph) (u v : G.V) : Nat :=
  if u = v then 0 else 1

theorem dist_refl (G : Graph) (v : G.V) :
  dist G v v = 0 := by
  simp [dist]

end FMT.Graph
