import FMT.Types.LocalType

namespace FMT.Types

axiom code : LocalType → Nat

def factorsThrough (f : LocalType → Nat) : Prop :=
  ∃ g : Nat → Nat, ∀ x, f x = g (code x)

def invariant (n : Nat) : Nat := n

theorem factors_example : ∃ f : LocalType → Nat, factorsThrough f := by
  refine ⟨fun x => code x, ?_⟩
  refine ⟨fun n => n, ?_⟩
  intro x
  rfl

end FMT.Types
