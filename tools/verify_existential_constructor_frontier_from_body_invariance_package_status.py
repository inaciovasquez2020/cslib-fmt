import json
from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ARTIFACT = Path("artifacts/existential_constructor_frontier_from_body_invariance_package_status_2026_06_21.json")
DOC = Path("docs/status/EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS.md")

required = {
    LEAN: [
        "def existential_constructor_frontier_from_body_invariance_package_status : Prop :=",
        "theorem existential_body_assignment_extension_invariance_component_package",
    ],
    DOC: [
        "ACHIEVED := existential_constructor_frontier_from_body_invariance_package_status_only",
        "LEAN_OBJECT := existential_constructor_frontier_from_body_invariance_package_status",
        "SOURCE_OBJECT := existential_body_assignment_extension_invariance_component_package",
        "FRONTIER_TARGET := existential_ex_body_to_quantified_radius_witness_constructor",
        "BOUNDARY := ¬ existential_body_witness_locality_transport",
        "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
        "MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor",
    ],
}

for path, needles in required.items():
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path}")
    text = path.read_text()
    for needle in needles:
        if needle not in text:
            raise SystemExit(f"MISSING_OBJECT := {needle}")

if not ARTIFACT.exists():
    raise SystemExit(f"MISSING_OBJECT := {ARTIFACT}")

art = json.loads(ARTIFACT.read_text())

expected = {
    "status": "EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_ONLY",
    "achieved": "existential_constructor_frontier_from_body_invariance_package_status_only",
    "lean_object": "existential_constructor_frontier_from_body_invariance_package_status",
    "source_object": "existential_body_assignment_extension_invariance_component_package",
    "frontier_target": "existential_ex_body_to_quantified_radius_witness_constructor",
    "remaining_gap": "existential_ex_body_to_quantified_radius_witness_constructor",
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
    if boundary not in json.dumps(art):
        raise SystemExit(f"MISSING_OBJECT := boundary {boundary}")

lean_text = LEAN.read_text()
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

print("EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_OK")
