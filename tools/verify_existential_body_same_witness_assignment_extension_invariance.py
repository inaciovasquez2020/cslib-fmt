from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ARTIFACT = Path("artifacts/existential_body_same_witness_assignment_extension_invariance_2026_06_21.json")
DOC = Path("docs/status/EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE.md")

required = {
    LEAN: [
        "theorem existential_body_same_witness_assignment_extension_invariance",
        "Holds M (extendAssignment ρ x) φ ↔",
        "Holds M (extendAssignment τ x) φ",
        "GaifmanDistanceLe M x x r",
        "tri_graph_positive_radius_assignment_extension_projection hclose hxx",
        "unguarded_fo_locality_input_surface_invariant M φ r hφ",
    ],
    ARTIFACT: [
        "EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_ONLY",
        "existential_body_same_witness_assignment_extension_invariance_only",
        "existential_body_same_witness_assignment_extension_invariance",
        "not existential_body_witness_locality_transport",
        "not existential_ex_body_to_quantified_radius_witness_constructor",
    ],
    DOC: [
        "ACHIEVED := existential_body_same_witness_assignment_extension_invariance_only",
        "LEAN_OBJECT := existential_body_same_witness_assignment_extension_invariance",
        "BOUNDARY := ¬ existential_body_witness_locality_transport",
        "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
        "MISSING_OBJECT := existential_body_witness_locality_transport",
    ],
}

for path, needles in required.items():
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path}")
    text = path.read_text()
    for needle in needles:
        if needle not in text:
            raise SystemExit(f"MISSING_OBJECT := {needle}")

lean_text = LEAN.read_text()
for forbidden in (
    "def existential_body_witness_locality_transport :=",
    "def existential_body_witness_locality_transport :=",
    "axiom existential_body_witness_locality_transport",
    "opaque existential_body_witness_locality_transport",
    "sorry",
    "admit",
):
    if forbidden in lean_text:
        raise SystemExit(f"MISSING_OBJECT := forbidden proof marker absence {forbidden}")

print("EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_OK")
