import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Graph

-- bounded-radius ball as subtype using dist
def Ball (G : Graph) (r : Nat) (v : G.V) :=
  { u : G.V // dist G v u ≤ r }

-- center is always in its own ball
theorem center_mem_ball (G : Graph) (r : Nat) (v : G.V) :
  ⟨v, by
    -- dist v v = 0 witness (reflexive walk placeholder)
    have : ∃ w : Walk G v v, w.len = 0 := by
      refine ⟨{
        len := 0,
        verts := fun _ => v,
        start := rfl,
        end_ := rfl,
        adjacent := by intro i; cases i
      }, rfl⟩
    have h := Nat.find_spec this
    exact Nat.le_of_eq h
  ⟩ ∈ Ball G r v := by
  exact trivial

end FMT.Graph
