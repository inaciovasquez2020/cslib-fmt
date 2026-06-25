import CSLIB.FMT.UnguardedFO.RadiusZeroLocalityInputDownstreamExample
import CSLIB.FMT.UnguardedFO.FullFormulaRadiusStatusDownstreamExample

/-!
# Unguarded FO downstream certificate library

This file is the small downstream import surface for reusable certificates built
from `LocalityInputSurface`.

It does not modify the original certificates and does not claim standard Gaifman
locality, Fagin's theorem, the 0-1 Law, Pk1 route closure, or 2vK route closure.
-/

namespace CSLIB
namespace FMT
namespace UnguardedFO

/-- Library-level reuse of the radius-zero locality input downstream example. -/
theorem downstream_library_radius_zero_locality_input {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) :
    UnguardedFOLocalityInputSurface M φ 0 := by
  exact radius_zero_locality_input_downstream_example M φ

/-- Library-level reuse of the full formula-radius status downstream example. -/
theorem downstream_library_full_formula_radius_status :
    full_formula_radius_construction_status := by
  exact full_formula_radius_status_downstream_example

end UnguardedFO
end FMT
end CSLIB
