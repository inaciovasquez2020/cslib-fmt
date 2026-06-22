from pathlib import Path
import json

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
DOC = Path("docs/status/EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_DOWNSTREAM_USE.md")
ARTIFACT = Path("artifacts/existential_locality_radius_constructor_downstream_use_2026_06_22.json")

lean = LEAN.read_text()
doc = DOC.read_text()
artifact = json.loads(ARTIFACT.read_text())

required_lean = [
    "def existential_locality_radius_constructor :",
    "existential_body_witness_locality_transport_type_constructor",
    "| ex φ ih =>",
    "exact existential_locality_radius_constructor M ih",
    "def full_formula_radius_construction : Type 1 :=",
    "noncomputable def full_formula_radius_construction_closed :",
]
for marker in required_lean:
    assert marker in lean, marker

for forbidden in [
    "axiom existential_locality_radius_constructor",
    "opaque existential_locality_radius_constructor",
    "sorry",
    "admit",
]:
    assert forbidden not in lean, forbidden

required_doc = [
    "STATUS := EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_DOWNSTREAM_USE_ONLY",
    "SOURCE_STATUS := EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION_ONLY",
    "DOWNSTREAM_USE := full_formula_radius_construction_closed existential branch",
    "WEAKEST_NEXT_BOUNDARY := bounded_status_audit_for_remaining_historical_missing_constructor_records",
]
for marker in required_doc:
    assert marker in doc, marker

assert artifact["status"] == "EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_DOWNSTREAM_USE_ONLY"
assert artifact["source_status"] == "EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION_ONLY"
assert artifact["downstream_use"] == "full_formula_radius_construction_closed existential branch"
assert "existential_locality_radius_constructor" in artifact["lean_objects"]
assert "full_formula_radius_construction_closed" in artifact["lean_objects"]
assert artifact["weakest_next_boundary"] == "bounded_status_audit_for_remaining_historical_missing_constructor_records"

for claim in [
    "external acceptance",
    "independent expert validation",
    "mathematical certification",
    "Fagin theorem",
    "0-1 Law",
    "Pk1 route closure",
    "2vK route closure",
    "full unguarded FO locality",
]:
    assert claim in artifact["does_not_claim"], claim

print("EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_DOWNSTREAM_USE_OK")
