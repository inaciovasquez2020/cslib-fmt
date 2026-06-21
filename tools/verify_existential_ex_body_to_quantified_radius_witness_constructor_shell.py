from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ARTIFACT = Path("artifacts/existential_ex_body_to_quantified_radius_witness_constructor_shell_2026_06_21.json")
DOC = Path("docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL.md")

required = {
    LEAN: [
        "def existential_ex_body_to_quantified_radius_witness_constructor_shell : Type 1 :=",
        "existential_body_witness_locality_transport_type",
    ],
    ARTIFACT: [
        "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL_ONLY",
        "existential_ex_body_to_quantified_radius_witness_constructor_shell_only",
        "not existential_ex_body_to_quantified_radius_witness_constructor",
        "existential_ex_body_to_quantified_radius_witness_constructor",
    ],
    DOC: [
        "ACHIEVED := existential_ex_body_to_quantified_radius_witness_constructor_shell_only",
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

lean_text = LEAN.read_text()
for forbidden in ("axiom existential_ex_body_to_quantified_radius_witness_constructor", "opaque existential_ex_body_to_quantified_radius_witness_constructor", "sorry", "admit"):
    if forbidden in lean_text:
        raise SystemExit(f"MISSING_OBJECT := no forbidden Lean placeholder for {forbidden}")

print("EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL_OK")
