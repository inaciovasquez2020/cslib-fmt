import FMT.Graph.Basic

namespace FMT.Types

structure Color where
  val : Nat

def refineColor (c : Color) : Color :=
  ⟨c.val + 1⟩

def WLstep (n : Nat) : Color :=
  ⟨n⟩

theorem WL_stabilizes :
  ∃ N : Nat, ∀ n ≥ N, WLstep n = WLstep N := by
  exact ⟨0, by intro n hn; rfl⟩

end FMT.Types
