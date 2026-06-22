from pathlib import Path
import json

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
DOC = Path("docs/status/EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION.md")
ARTIFACT = Path("artifacts/existential_body_witness_locality_transport_boundary_supersession_2026_06_22.json")

lean = LEAN.read_text()
doc = DOC.read_text()
artifact = json.loads(ARTIFACT.read_text())

required_lean = [
    "theorem existential_body_witness_locality_transport :",
    "def existential_locality_radius_constructor :",
]
for marker in required_lean:
    assert marker in lean, marker

required_doc = [
    "STATUS := EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION_ONLY",
    "SUPERSEDED_STALE_BOUNDARY := not existential_body_witness_locality_transport",
    "SOURCE_STALE_STATUS := EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_ONLY",
    "WEAKEST_NEXT_BOUNDARY := downstream_use_of_current_existential_body_witness_locality_transport",
]
for marker in required_doc:
    assert marker in doc, marker

assert artifact["status"] == "EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION_ONLY"
assert artifact["superseded_stale_boundary"] == "not existential_body_witness_locality_transport"
assert artifact["source_stale_status"] == "EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_ONLY"
assert "existential_body_witness_locality_transport" in artifact["current_lean_objects"]
assert "existential_locality_radius_constructor" in artifact["current_lean_objects"]
assert artifact["weakest_next_boundary"] == "downstream_use_of_current_existential_body_witness_locality_transport"

for forbidden_claim in [
    "external acceptance",
    "independent expert validation",
    "mathematical certification",
    "Fagin theorem",
    "0-1 Law",
    "Pk1 route closure",
    "2vK route closure",
    "full unguarded FO locality",
]:
    assert forbidden_claim in artifact["does_not_claim"], forbidden_claim

print("EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_BOUNDARY_SUPERSESSION_OK")
