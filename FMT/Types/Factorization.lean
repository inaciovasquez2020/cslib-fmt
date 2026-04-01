namespace FMT.Types

constant LocalType : Type

def FactorsThrough {G : Type} (f : G → Nat) (τ : G → LocalType) : Prop :=
  ∃ g : LocalType → Nat, ∀ x, f x = g (τ x)

end FMT.Types
