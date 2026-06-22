from pathlib import Path
import json

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
DOC = Path("docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_BOUNDARY_SUPERSESSION.md")
ARTIFACT = Path("artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_boundary_supersession_2026_06_22.json")
HISTORICAL_ARTIFACT = Path("artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json")
HISTORICAL_DOC = Path("docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md")

lean = LEAN.read_text()
doc = DOC.read_text()
artifact = json.loads(ARTIFACT.read_text())
historical_artifact_text = HISTORICAL_ARTIFACT.read_text()
historical_doc_text = HISTORICAL_DOC.read_text()

for marker in [
    "theorem existential_ex_body_to_quantified_radius_witness_constructor :",
    "theorem existential_body_witness_locality_transport :",
    "def existential_locality_radius_constructor :",
    "noncomputable def full_formula_radius_construction_closed :",
    "exact existential_locality_radius_constructor M ih",
]:
    assert marker in lean, marker

for marker in [
    "not existential_ex_body_to_quantified_radius_witness_constructor",
    "not existential_body_witness_locality_transport",
    "not existential_locality_radius_constructor",
]:
    assert marker in historical_artifact_text, marker

for marker in [
    "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_locality_radius_constructor",
    "MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor",
    "MISSING_OBJECT := existential_body_witness_locality_transport",
]:
    assert marker in historical_doc_text, marker

for marker in [
    "STATUS := EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_BOUNDARY_SUPERSESSION_ONLY",
    "SOURCE_HISTORICAL_ARTIFACT := artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json",
    "SOURCE_HISTORICAL_DOC := docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md",
    "WEAKEST_NEXT_BOUNDARY := next_historical_missing_constructor_record_supersession",
]:
    assert marker in doc, marker

assert artifact["status"] == "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_BOUNDARY_SUPERSESSION_ONLY"
assert artifact["source_historical_artifact"] == "artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json"
assert artifact["source_historical_doc"] == "docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md"
assert "not existential_ex_body_to_quantified_radius_witness_constructor" in artifact["superseded_historical_missing_objects"]
assert "not existential_body_witness_locality_transport" in artifact["superseded_historical_missing_objects"]
assert "not existential_locality_radius_constructor" in artifact["superseded_historical_missing_objects"]
assert "existential_ex_body_to_quantified_radius_witness_constructor" in artifact["current_lean_objects"]
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

print("EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_BOUNDARY_SUPERSESSION_OK")
