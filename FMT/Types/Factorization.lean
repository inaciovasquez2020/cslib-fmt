import FMT.Types.LocalType

namespace FMT.Types

def code : LocalType → Nat := fun _ => 0

def factorsThrough (f : LocalType → Nat) : Prop :=
  ∃ g : Nat → Nat, ∀ x, f x = g (code x)

def invariant (n : Nat) : Nat := n

theorem factors_example : ∃ f : LocalType → Nat, factorsThrough f := by
  refine ⟨fun _ => 0, ?_⟩
  refine ⟨fun _ => 0, ?_⟩
  intro x
  simp [code]

end FMT.Types
