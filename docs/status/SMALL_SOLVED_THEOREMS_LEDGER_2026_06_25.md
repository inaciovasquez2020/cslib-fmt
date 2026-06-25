# Small Solved Theorems Ledger — 2026-06-25

REPO := cslib-fmt
MAIN := 4bbe10d
STATUS := public main contains the listed solved theorem surfaces
CHECK := targeted `lake build` passed for every discovered containing module listed below
BOUNDARY := ¬ global_finite_model_theory_closure

## LATEST_CONFIRMED_ON_MAIN

| theorem | source file | line | build target |
|---|---:|---:|---|
| `unguarded_fo_constructed_radius_invariance` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1633 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `exists_unguarded_fo_locality_radius_invariance` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1650 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `has_unguarded_fo_locality_radius_to_exists_invariance` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1663 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |

## EARLIER_CONFIRMED_CSLIB_SURFACES

| theorem | source file | line | build target |
|---|---:|---:|---|
| `unguarded_fo_formula_radius_zero_locality_input` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1610 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `downstream_library_radius_zero_locality_input` | `lean/CSLIB/FMT/UnguardedFO/DownstreamLibrary.lean` | 19 | `lake build CSLIB.FMT.UnguardedFO.DownstreamLibrary` |
| `downstream_library_full_formula_radius_status` | `lean/CSLIB/FMT/UnguardedFO/DownstreamLibrary.lean` | 25 | `lake build CSLIB.FMT.UnguardedFO.DownstreamLibrary` |
| `full_formula_radius_construction_closed` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1591 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `full_formula_radius_construction_status_closed` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 1600 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `assignment_gaifman_close_radius_zero_preservation` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 274 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `gaifman_distance_le_zero_eq` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 261 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `equality_atom_locality_input_radius_zero` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 286 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `relation_atom_locality_input_radius_zero` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 300 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |
| `tri_graph_radius_zero_assignment_projection_invariant_closed` | `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` | 740 | `lake build CSLIB.FMT.UnguardedFO.LocalityInputSurface` |

## EARLIER_BOOLEAN_RADIUS_CONSTRUCTOR_SURFACES

| theorem | source file | line | build target |
|---|---:|---:|---|
| `singleton_bounded_syntactic_fragment` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 165 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `atomic_bounded_syntactic_fragment` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 179 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `singleton_radius_construction_target` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 187 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `atomic_radius_constructor` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 205 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `neg_radius_input` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 220 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `neg_radius_constructor` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 235 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `conj_radius_input` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 252 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `conj_radius_constructor` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 272 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `disj_radius_input` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 290 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |
| `disj_radius_constructor` | `lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean` | 312 | `lake build CSLIB.FMT.UnguardedFO.FormulaRadiusConstructionTarget` |

