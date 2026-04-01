import FMT.Game.EF

namespace FMT.Game

structure PositionBR (G H : Type) where
  pebbles : Nat

def winsLocal (k R : Nat) : Prop :=
  indistinguishable k R

theorem winsLocal_reflexive (k R : Nat) : winsLocal k R := by
  unfold winsLocal indistinguishable
  exact ⟨rfl, rfl⟩

end FMT.Game
