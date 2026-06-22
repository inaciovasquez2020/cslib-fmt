from pathlib import Path
import json

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
DOC = Path("docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_CONSTRUCTOR_BOUNDARY_SUPERSESSION.md")
ARTIFACT = Path("artifacts/full_unguarded_fo_pk1_route_gap_rank_constructor_boundary_supersession_2026_06_22.json")
HISTORICAL_ARTIFACT = Path("artifacts/full_unguarded_fo_pk1_route_gap_rank_2026_06_21.json")
HISTORICAL_DOC = Path("docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK.md")

lean = LEAN.read_text()
doc = DOC.read_text()
artifact = json.loads(ARTIFACT.read_text())
historical_artifact_text = HISTORICAL_ARTIFACT.read_text()
historical_doc_text = HISTORICAL_DOC.read_text()

for marker in [
    "def existential_locality_radius_constructor :",
    "noncomputable def full_formula_radius_construction_closed :",
    "exact existential_locality_radius_constructor M ih",
]:
    assert marker in lean, marker

assert "not existential_locality_radius_constructor" in historical_artifact_text
assert "BOUNDARY := ¬ existential_locality_radius_constructor" in historical_doc_text

for marker in [
    "STATUS := FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_CONSTRUCTOR_BOUNDARY_SUPERSESSION_ONLY",
    "SOURCE_HISTORICAL_ARTIFACT := artifacts/full_unguarded_fo_pk1_route_gap_rank_2026_06_21.json",
    "SOURCE_HISTORICAL_DOC := docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK.md",
    "SUPERSEDED_HISTORICAL_MISSING_OBJECT := not existential_locality_radius_constructor",
    "WEAKEST_NEXT_BOUNDARY := full_quantifier_locality_transport_or_route_closure_boundary_audit",
]:
    assert marker in doc, marker

assert artifact["status"] == "FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_CONSTRUCTOR_BOUNDARY_SUPERSESSION_ONLY"
assert artifact["source_historical_artifact"] == "artifacts/full_unguarded_fo_pk1_route_gap_rank_2026_06_21.json"
assert artifact["source_historical_doc"] == "docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK.md"
assert artifact["superseded_historical_missing_object"] == "not existential_locality_radius_constructor"
assert "existential_locality_radius_constructor" in artifact["current_lean_objects"]
assert "full_formula_radius_construction_closed" in artifact["current_lean_objects"]
assert "not full_quantifier_locality_transport" in artifact["remaining_boundaries"]
assert "not Pk1 route closure" in artifact["remaining_boundaries"]
assert artifact["weakest_next_boundary"] == "full_quantifier_locality_transport_or_route_closure_boundary_audit"

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

print("FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_CONSTRUCTOR_BOUNDARY_SUPERSESSION_OK")
