import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // True }

theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  ∃ u : Ball G r v, u.val = v := by
  exact ⟨⟨v, trivial⟩, rfl⟩

end FMT.Graph
