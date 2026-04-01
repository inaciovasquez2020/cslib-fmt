namespace FMT.Types

def FactorsThrough {G : Type} (f : G → Nat) (τ : G → Type) : Prop :=
  ∃ g : Type → Nat, True

end FMT.Types
