import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

-- bounded-radius ball as subtype using dist
def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

-- membership lemma (coercion-based)
theorem mem_ball {G : Graph} {r : Nat} {v u : G.V} :
  u ∈ Ball G r v ↔ dist G v u ≤ r := Iff.rfl

-- center is always in its own ball
theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  v ∈ Ball G r v := by
  simpa [mem_ball, dist_refl]

end FMT.Graph
