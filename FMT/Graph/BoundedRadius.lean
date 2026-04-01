import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  ∃ u : Ball G r v, u.val = v := by
  refine ⟨⟨v, ?h⟩, rfl⟩
  have : dist G v v = 0 := dist_refl G v
  simpa [this]

end FMT.Graph
