import Mathlib

namespace FMT.Invariants

universe u

variable {V : Type u}

abbrev CycleSpace (α : Type u) := Submodule (GF(2)) α

noncomputable def cycleQuotientProjection
    (Z L : CycleSpace V) :
    Z →ₗ[GF(2)] Z ⧸ (L.comap Z.subtype) :=
  Submodule.mkQ _

@[simp] theorem cycleQuotientProjection_apply
    (Z L : CycleSpace V) (z : Z) :
    cycleQuotientProjection Z L z = Submodule.Quotient.mk z := rfl

theorem cycleQuotientProjection_ker
    (Z L : CycleSpace V) :
    LinearMap.ker (cycleQuotientProjection Z L) = L.comap Z.subtype := by
  ext z
  rfl

end FMT.Invariants
