import FMT.Graph.Basic

namespace FMT.Types

constant LocalType : Type

-- fix: Prop structure fields must be proofs
def FactorsThrough
  {G : Type} (f : G → Nat) (τ : G → LocalType) : Prop :=
  ∃ g : LocalType → Nat, ∀ x, f x = g (τ x)

end FMT.Types
