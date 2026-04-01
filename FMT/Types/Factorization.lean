import FMT.Graph.Basic

namespace FMT.Types

-- abstract local type extractor
constant LocalType : Type

-- factorization through local types (commutative form)
structure FactorsThrough
  {G : Type} (f : G → Nat) (τ : G → LocalType) : Prop :=
  (g : LocalType → Nat)
  (comm : ∀ x, f x = g (τ x))

end FMT.Types
