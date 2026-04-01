import FMT.Graph.Basic

namespace FMT.Graph

inductive Path (G : Graph) : G.V → G.V → Type where
| nil (v : G.V) : Path G v v
| cons {u v w : G.V} : G.Adj u v → Path G v w → Path G u w

def pathLength {G : Graph} : {u v : G.V} → Path G u v → Nat
| _, _, Path.nil _ => 0
| _, _, Path.cons _ p => Nat.succ (pathLength p)

def dist (G : Graph) (u v : G.V) : Nat :=
  if h : u = v then 0 else
  if G.Adj u v then 1 else 2

theorem dist_refl (G : Graph) (v : G.V) :
  dist G v v = 0 := by
  simp [dist]

end FMT.Graph
