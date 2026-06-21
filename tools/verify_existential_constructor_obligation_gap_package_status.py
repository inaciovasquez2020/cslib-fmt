import json
from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ARTIFACT = Path("artifacts/existential_constructor_obligation_gap_package_status_2026_06_21.json")
DOC = Path("docs/status/EXISTENTIAL_CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS.md")

for path in (LEAN, ARTIFACT, DOC):
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path}")

lean_text = LEAN.read_text()
artifact = json.loads(ARTIFACT.read_text())
artifact_text = json.dumps(artifact)
doc_text = DOC.read_text()

for marker in [
    "def existential_constructor_obligation_gap_package_status : Prop :=",
    "existential_constructor_frontier_from_body_invariance_package_status",
    "existential_body_assignment_extension_invariance_component_package",
]:
    if marker not in lean_text:
        raise SystemExit(f"MISSING_OBJECT := {marker}")

expected = {
    "status": "EXISTENTIAL_CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS_ONLY",
    "achieved": "existential_constructor_obligation_gap_package_status_only",
    "lean_object": "existential_constructor_obligation_gap_package_status",
}

for key, value in expected.items():
    if artifact.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := artifact {key} {value}")

for marker in [
    "existential_constructor_frontier_from_body_invariance_package_status",
    "existential_body_assignment_extension_invariance_component_package",
    "existential_body_witness_locality_transport",
    "existential_ex_body_to_quantified_radius_witness_constructor",
    "not existential_body_witness_locality_transport",
    "not existential_ex_body_to_quantified_radius_witness_constructor",
]:
    if marker not in artifact_text:
        raise SystemExit(f"MISSING_OBJECT := artifact marker {marker}")

for marker in [
    "ACHIEVED := existential_constructor_obligation_gap_package_status_only",
    "LEAN_OBJECT := existential_constructor_obligation_gap_package_status",
    "SOURCE_STATUS_OBJECT := existential_constructor_frontier_from_body_invariance_package_status",
    "SOURCE_STATUS_OBJECT := existential_body_assignment_extension_invariance_component_package",
    "REMAINING_GAP := existential_body_witness_locality_transport",
    "REMAINING_GAP := existential_ex_body_to_quantified_radius_witness_constructor",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
    "MISSING_OBJECT := existential_body_witness_locality_transport",
    "MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor",
]:
    if marker not in doc_text:
        raise SystemExit(f"MISSING_OBJECT := doc marker {marker}")

for forbidden in (
    "def existential_body_witness_locality_transport :=",
    "def existential_body_witness_locality_transport :=",
    "axiom existential_body_witness_locality_transport",
    "opaque existential_body_witness_locality_transport",
    "theorem existential_ex_body_to_quantified_radius_witness_constructor",
    "def existential_ex_body_to_quantified_radius_witness_constructor :=",
    "axiom existential_ex_body_to_quantified_radius_witness_constructor",
    "opaque existential_ex_body_to_quantified_radius_witness_constructor",
    "sorry",
    "admit",
):
    if forbidden in lean_text:
        raise SystemExit(f"MISSING_OBJECT := forbidden proof marker absence {forbidden}")

print("EXISTENTIAL_CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS_OK")
