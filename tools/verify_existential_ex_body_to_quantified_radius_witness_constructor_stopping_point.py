import json
from pathlib import Path

ROOT = Path(".")
LEAN = ROOT / "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
ART = ROOT / "artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md"

for path in (LEAN, ART, DOC):
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path}")

lean = LEAN.read_text()
art = json.loads(ART.read_text())
art_text = json.dumps(art)
doc = DOC.read_text()

for forbidden in (
    "def existential_body_witness_locality_transport :=",
    "def existential_body_witness_locality_transport :=",
    "axiom existential_body_witness_locality_transport",
    "opaque existential_body_witness_locality_transport",
    "def existential_ex_body_to_quantified_radius_witness_constructor :=",
    "axiom existential_ex_body_to_quantified_radius_witness_constructor",
    "opaque existential_ex_body_to_quantified_radius_witness_constructor",
    "sorry",
    "admit",
):
    if forbidden in lean:
        raise SystemExit(f"MISSING_OBJECT := forbidden proof marker absence {forbidden}")

for marker in (
    "def existential_ex_body_to_quantified_radius_witness_constructor_shell : Type 1 :=",
    "theorem existential_body_assignment_extension_invariance_component_package",
    "def existential_constructor_frontier_from_body_invariance_package_status : Prop :=",
    "def existential_constructor_obligation_gap_package_status : Prop :=",
):
    if marker not in lean:
        raise SystemExit(f"MISSING_OBJECT := {marker}")

for marker in (
    "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_ONLY",
    "existential_ex_body_to_quantified_radius_witness_constructor",
):
    if marker not in art_text:
        raise SystemExit(f"MISSING_OBJECT := artifact marker {marker}")

expected = {
    "constructor_frontier_status_object": "existential_constructor_frontier_from_body_invariance_package_status",
    "constructor_obligation_gap_package_status_object": "existential_constructor_obligation_gap_package_status",
    "body_invariance_package_object": "existential_body_assignment_extension_invariance_component_package",
    "remaining_constructor_gap": "existential_ex_body_to_quantified_radius_witness_constructor",
    "remaining_transport_gap": "existential_body_witness_locality_transport",
    "refined_after_obligation_gap_package_commit": "e92b656",
}

for key, value in expected.items():
    if art.get(key) != value:
        raise SystemExit(f"MISSING_OBJECT := artifact {key} {value}")

for boundary in [
    "not existential_body_witness_locality_transport",
    "not existential_ex_body_to_quantified_radius_witness_constructor",
    "not existential_locality_radius_constructor",
    "not full_quantifier_locality_transport",
    "not full_formula_radius_construction",
    "not Pk1",
    "not 2vK",
    "not full_unguarded_fo_locality",
]:
    if boundary not in art_text:
        raise SystemExit(f"MISSING_OBJECT := boundary {boundary}")

for marker in [
    "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT",
    "BODY_INVARIANCE_PACKAGE_OBJECT := existential_body_assignment_extension_invariance_component_package",
    "CONSTRUCTOR_FRONTIER_STATUS_OBJECT := existential_constructor_frontier_from_body_invariance_package_status",
    "CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS_OBJECT := existential_constructor_obligation_gap_package_status",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
    "MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor",
    "MISSING_OBJECT := existential_body_witness_locality_transport",
]:
    if marker not in doc:
        raise SystemExit(f"MISSING_OBJECT := doc marker {marker}")

print("EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_OK")
