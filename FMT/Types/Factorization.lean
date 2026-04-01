import FMT.Types.LocalType

namespace FMT.Types

def factorsThrough (f : LocalType → Nat) : Prop :=
  ∃ g : Nat → Nat, ∀ x, f x = g (f x)

def invariant (n : Nat) : Nat := n

theorem factors_example : ∃ f : LocalType → Nat, factorsThrough f := by
  refine ⟨fun _ => 0, ?_⟩
  refine ⟨fun n => n, ?_⟩
  intro x
  rfl

end FMT.Types
