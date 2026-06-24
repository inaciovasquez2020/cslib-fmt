import CSLIB.FMT.UnguardedFO.LocalityInputSurface

/-!
# Full formula-radius status downstream example

This file is a minimal downstream use of the committed certificate
`full_formula_radius_construction_status_closed`.

It does not modify the original theorem and does not claim standard Gaifman
locality, Fagin's theorem, the 0-1 Law, Pk1 route closure, or 2vK route closure.
-/

namespace CSLIB
namespace FMT
namespace UnguardedFO

/-- Downstream reusable wrapper around the full formula-radius status certificate. -/
theorem full_formula_radius_status_downstream_example :
    full_formula_radius_construction_status := by
  exact full_formula_radius_construction_status_closed

end UnguardedFO
end FMT
end CSLIB
