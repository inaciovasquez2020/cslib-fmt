from pathlib import Path
import json

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
DOC = Path("docs/status/EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_BOUNDARY_SUPERSESSION.md")
ARTIFACT = Path("artifacts/existential_constructor_definition_inspection_boundary_supersession_2026_06_22.json")
HISTORICAL = Path("artifacts/existential_constructor_definition_inspection_2026_06_21.json")

lean = LEAN.read_text()
doc = DOC.read_text()
artifact = json.loads(ARTIFACT.read_text())
historical_text = HISTORICAL.read_text()
historical = json.loads(historical_text)

for marker in [
    "theorem existential_body_witness_locality_transport :",
    "def existential_locality_radius_constructor :",
    "noncomputable def full_formula_radius_construction_closed :",
    "exact existential_locality_radius_constructor M ih",
]:
    assert marker in lean, marker

assert historical["weakest_next_missing_object"] == "existential_body_witness_locality_transport"
assert "not existential_body_witness_locality_transport" in historical_text
assert "not existential_locality_radius_constructor" in historical_text

for marker in [
    "STATUS := EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_BOUNDARY_SUPERSESSION_ONLY",
    "SOURCE_HISTORICAL_ARTIFACT := artifacts/existential_constructor_definition_inspection_2026_06_21.json",
    "WEAKEST_NEXT_BOUNDARY := next_historical_missing_constructor_record_supersession",
]:
    assert marker in doc, marker

assert artifact["status"] == "EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_BOUNDARY_SUPERSESSION_ONLY"
assert artifact["source_historical_artifact"] == "artifacts/existential_constructor_definition_inspection_2026_06_21.json"
assert "not existential_body_witness_locality_transport" in artifact["superseded_historical_missing_objects"]
assert "not existential_locality_radius_constructor" in artifact["superseded_historical_missing_objects"]
assert "existential_body_witness_locality_transport" in artifact["current_lean_objects"]
assert "existential_locality_radius_constructor" in artifact["current_lean_objects"]
assert "full_formula_radius_construction_closed" in artifact["current_lean_objects"]
assert artifact["weakest_next_boundary"] == "next_historical_missing_constructor_record_supersession"

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

print("EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_BOUNDARY_SUPERSESSION_OK")
