import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

-- use constructor directly (no ∈)
theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  ∃ u : Ball G r v, u.val = v := by
  refine ⟨⟨v, ?_⟩, rfl⟩
  simp [dist_refl]

end FMT.Graph
