from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/unguarded_fo_conditional_atomic_locality_targets_lock_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_CONDITIONAL_ATOMIC_LOCALITY_TARGETS_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(ART.read_text(encoding="utf-8"))
doc = DOC.read_text(encoding="utf-8")
lean = LEAN.read_text(encoding="utf-8")

assert data["object"] == "UnguardedFOConditionalAtomicLocalityTargetsLock"
assert data["after_head"] == "46b9e7e"
assert data["status"] == "CONDITIONAL_ATOMIC_TARGETS_ONLY_NO_UNCONDITIONAL_ATOMIC_LOCALITY"

target_names = {target["name"] for target in data["locked_targets"]}
assert "equality_atom_locality_input_of_assignment_eq" in target_names
assert "relation_atom_locality_input_of_interp_iff" in target_names

assert "equality_atom_locality_input_of_assignment_eq" in lean
assert "relation_atom_locality_input_of_interp_iff" in lean
assert "AtomicLocalityInput M (Formula.eq x y) 0" in lean
assert "AtomicLocalityInput M (Formula.rel R args) r" in lean

for forbidden in [
    "unconditional atomic_formula_locality_input_exists",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert "CONDITIONAL_ATOMIC_TARGETS_ONLY_NO_UNCONDITIONAL_ATOMIC_LOCALITY" in doc
assert "This invariant is not proved by the target." in doc
assert "Boolean recursion" in doc
assert "quantifier recursion" in doc

print("UNGUARDED_FO_CONDITIONAL_ATOMIC_LOCALITY_TARGETS_LOCK_OK")
