import FMT.Graph.Basic

namespace FMT.Graph

variable (G : Graph)
variable [DecidableEq G.V]
variable [∀ u v : G.V, Decidable (G.Adj u v)]

inductive Path : G.V → G.V → Type where
| nil (v : G.V) : Path v v
| cons {u v w : G.V} : G.Adj u v → Path v w → Path u w

def pathLength : {u v : G.V} → Path u v → Nat
| _, _, Path.nil _ => 0
| _, _, Path.cons _ p => Nat.succ (pathLength p)

def dist (u v : G.V) : Nat :=
  if u = v then 0 else
  if G.Adj u v then 1 else 2

theorem dist_refl (v : G.V) :
  dist G v v = 0 := by
  simp [dist]

end FMT.Graph
