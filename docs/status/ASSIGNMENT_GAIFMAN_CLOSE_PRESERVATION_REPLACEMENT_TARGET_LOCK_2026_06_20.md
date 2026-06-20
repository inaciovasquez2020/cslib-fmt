# AssignmentGaifmanClose preservation replacement target lock

Date: 2026-06-20
After HEAD: `2075380`

## Status

`ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_ONLY`

This lock records the replacement target added after classifying global
assignment preservation as too strong for positive Gaifman radii.

## Locked target

```lean
AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
cd /Users/inaciof.vasquez/Desktop/GITHUB/cslib-fmt

bash <<'BASH'
set -euo pipefail

ART="artifacts/cslib_fmt/assignment_gaifman_close_preservation_replacement_target_lock_2026_06_20.json"
DOC="docs/status/ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_2026_06_20.md"
VERIFY="scripts/check_assignment_gaifman_close_preservation_replacement_target_lock.py"
TEST="tests/test_assignment_gaifman_close_preservation_replacement_target_lock.py"
LEAN_FILE="lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"

echo "HEAD_BEFORE :="
git log --oneline -1

mkdir -p artifacts/cslib_fmt docs/status scripts tests

cat > "$ART" <<'JSON'
{
  "after_head": "2075380",
  "date": "2026-06-20",
  "does_not_claim": [
    "AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget inhabited",
    "radius-zero preservation proved",
    "exact assignment close branch proved",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality"
  ],
  "lean_file": "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean",
  "locked_target": {
    "name": "AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget",
    "kind": "replacement_target_shell_only",
    "status": "TARGET_ONLY_NO_BRANCH_PROOF",
    "branches": [
      {
        "name": "radius_zero_preservation",
        "statement_shape": "∀ ρ τ : Fin n → M.carrier, AssignmentGaifmanClose M 0 ρ τ → ∀ x : Fin n, ρ x = τ x",
        "proved": false
      },
      {
        "name": "exact_assignment_close",
        "statement_shape": "exact_assignment_close ρ τ ↔ ∀ x : Fin n, ρ x = τ x",
        "proved": false
      }
    ]
  },
  "object": "AssignmentGaifmanClosePreservationReplacementTargetLock",
  "recursion_gate": "Boolean or quantifier recursion remains inadmissible until one replacement branch is classified and connected to atomic preservation.",
  "status": "ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_ONLY",
  "next_admissible_object": "RadiusZeroPreservationBranchClassificationOrExactAssignmentCloseAtomicInputTarget"
}
JSON

cat > "$DOC" <<'MD'
# AssignmentGaifmanClose preservation replacement target lock

Date: 2026-06-20
After HEAD: `2075380`

## Status

`ASSIGNMENT_GAIFMAN_CLOSE_PRESERVATION_REPLACEMENT_TARGET_LOCK_ONLY`

This lock records the replacement target added after classifying global
assignment preservation as too strong for positive Gaifman radii.

## Locked target

```lean
AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
Target shape
structure AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
    {σ : RelLanguage} (M : RelStructure σ) (n : Nat) where
  radius_zero_preservation :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M 0 ρ τ →
      ∀ x : Fin n, ρ x = τ x
  exact_assignment_close :
    (Fin n → M.carrier) → (Fin n → M.carrier) → Prop
  exact_assignment_close_iff :
    ∀ ρ τ : Fin n → M.carrier,
      exact_assignment_close ρ τ ↔ ∀ x : Fin n, ρ x = τ x
Boundary
This lock does not claim:
AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
is inhabited;
radius-zero preservation is proved;
the exact-assignment branch is proved;
unconditional equality atom locality;
unconditional relation atom locality;
unconditional atomic_formula_locality_input_exists;
Boolean recursion;
quantifier recursion;
Gaifman locality.
Recursion gate
Boolean or quantifier recursion remains inadmissible until one replacement
branch is classified and connected to atomic preservation.
Next admissible object
RadiusZeroPreservationBranchClassificationOrExactAssignmentCloseAtomicInputTarget
