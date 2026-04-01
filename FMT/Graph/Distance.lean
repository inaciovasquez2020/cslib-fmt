import FMT.Graph.Basic

namespace FMT.Graph

variable (G : Graph) [DecidableEq G.V]

def dist (u v : G.V) : Nat :=
  if u = v then 0 else 1

theorem dist_refl (v : G.V) :
  dist G v v = 0 := by
  simp [dist]

end FMT.Graph
