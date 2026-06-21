#!/usr/bin/env python3
from pathlib import Path
import json

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/twovk_to_pk1_structural_recursion_proof_bearing_quantifier_status_2026_06_21.json")
DOC = Path("docs/status/TWOVK_TO_PK1_STRUCTURAL_RECURSION_PROOF_BEARING_QUANTIFIER_STATUS.md")

src = SRC.read_text()
artifact = json.loads(ART.read_text())
doc = DOC.read_text()

required_src = [
    "def TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status : Prop :=",
    "theorem TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status_closed :",
    "TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status ∧",
    "proof_bearing_quantifier_assignment_radius_control_statement",
    "TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status_closed",
    "exact hStatus.2.2",
]

for needle in required_src:
    if needle not in src:
        raise SystemExit(f"MISSING_OBJECT := {needle}")

if artifact.get("status") != "TWOVK_TO_PK1_STRUCTURAL_RECURSION_PROOF_BEARING_QUANTIFIER_STATUS_ONLY":
    raise SystemExit("MISSING_OBJECT := artifact status lock")

if artifact.get("target_lean_definition") != "proof_bearing_quantifier_assignment_radius_control_statement":
    raise SystemExit("MISSING_OBJECT := target_lean_definition")

for boundary in [
    "BOUNDARY := ¬ 2vK",
    "BOUNDARY := ¬ Pk1",
    "BOUNDARY := ¬ full_formula_radius_construction",
    "BOUNDARY := ¬ full_quantifier_locality_transport",
    "BOUNDARY := ¬ full_unguarded_fo_locality",
]:
    if boundary not in doc:
        raise SystemExit(f"MISSING_OBJECT := {boundary}")

print("TWOVK_TO_PK1_STRUCTURAL_RECURSION_PROOF_BEARING_QUANTIFIER_STATUS_OK")
