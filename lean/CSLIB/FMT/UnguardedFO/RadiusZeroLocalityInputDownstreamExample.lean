import CSLIB.FMT.UnguardedFO.LocalityInputSurface

/-!
# Radius-zero locality input downstream example

This file is a minimal downstream use of the committed certificate
`unguarded_fo_formula_radius_zero_locality_input`.

It does not modify the original theorem and does not claim standard Gaifman
locality, Fagin's theorem, the 0-1 Law, Pk1 route closure, or 2vK route closure.
-/

namespace CSLIB
namespace FMT
namespace UnguardedFO

/-- Downstream reusable wrapper around the radius-zero locality input certificate. -/
theorem radius_zero_locality_input_downstream_example {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) :
    UnguardedFOLocalityInputSurface M φ 0 := by
  exact unguarded_fo_formula_radius_zero_locality_input M φ

end UnguardedFO
end FMT
end CSLIB
