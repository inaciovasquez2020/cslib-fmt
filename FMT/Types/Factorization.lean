namespace FMT.Types

constant LocalType : Type

def FactorsThrough {G : Type} (f : G → Nat) (τ : G → LocalType) : Prop :=
  ∃ g : LocalType → Nat, ∀ x, f x = g (τ x)
def factorsThrough (f : LocalType → Nat) : Prop :=
  ∃ g : Nat → Nat, ∀ t : LocalType, f t = g t.code

def invariant (n : Nat) : Nat := n

theorem factors_identity :
  factorsThrough (fun t => t.code) := by
  refine ⟨fun n => n, ?_⟩
  intro t
  rfl

end FMT.Types
