from pathlib import Path
import json

ART = Path("artifacts/cslib_fmt/unguarded_fo_atomic_assignment_tuple_preservation_invariant_ledger_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_ATOMIC_ASSIGNMENT_TUPLE_PRESERVATION_INVARIANT_LEDGER_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(ART.read_text(encoding="utf-8"))
doc = DOC.read_text(encoding="utf-8")
lean = LEAN.read_text(encoding="utf-8")

assert data["object"] == "UnguardedFOAtomicAssignmentTuplePreservationInvariantLedger"
assert data["after_head"] == "9bf9fe7"
assert data["status"] == "ATOMIC_INVARIANT_LEDGER_ONLY_NO_PRESERVATION_PROOF"

assert "equality_atom_locality_input_of_assignment_eq" in data["depends_on_committed_targets"]
assert "relation_atom_locality_input_of_interp_iff" in data["depends_on_committed_targets"]
assert "equality_atom_locality_input_of_assignment_eq" in lean
assert "relation_atom_locality_input_of_interp_iff" in lean

invariant_names = {item["name"] for item in data["ledgered_invariants"]}
assert "equality_assignment_preservation_at_radius_zero" in invariant_names
assert "relation_tuple_interpretation_preservation_at_radius_r" in invariant_names

for item in data["ledgered_invariants"]:
    assert item["status"] == "MISSING_UNPROVED_INVARIANT"

for forbidden in [
    "unconditional atomic_formula_locality_input_exists",
    "unconditional equality atom locality",
    "unconditional relation atom locality",
    "assignment preservation under AssignmentGaifmanClose",
    "relation tuple interpretation preservation under AssignmentGaifmanClose",
    "Boolean recursion",
    "quantifier recursion",
    "Gaifman locality",
]:
    assert forbidden in data["does_not_claim"]

assert data["recursion_gate"] == (
    "Boolean or quantifier recursion is inadmissible until atomic preservation "
    "invariants are classified."
)

assert "ATOMIC_INVARIANT_LEDGER_ONLY_NO_PRESERVATION_PROOF" in doc
assert "MISSING_UNPROVED_INVARIANT" in doc
assert "Boolean or quantifier recursion is inadmissible" in doc
assert "AssignmentGaifmanClosePreservationTargetOrTupleInterpretationPreservationTarget" in doc

print("UNGUARDED_FO_ATOMIC_ASSIGNMENT_TUPLE_PRESERVATION_INVARIANT_LEDGER_OK")
