namespace FMT.Types

def FactorsThrough {G : Type} (f : G → Nat) (τ : G → Type) : Prop :=
  ∃ g : τ → Nat, ∀ x, f x = g (τ x)

end FMT.Types
