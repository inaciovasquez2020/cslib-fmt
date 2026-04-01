import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

-- bounded-radius ball as subtype using dist
def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

-- center is always in its own ball (using dist_refl)
theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  (⟨v, by
      have h : dist G v v = 0 := dist_refl G v
      simpa [h] using (Nat.zero_le r)
   ⟩ : Ball G r v) = ⟨v, by
      have h : dist G v v = 0 := dist_refl G v
      simpa [h] using (Nat.zero_le r)
   ⟩ := rfl

end FMT.Graph
