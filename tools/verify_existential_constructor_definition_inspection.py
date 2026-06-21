#!/usr/bin/env python3
from pathlib import Path
import json
import subprocess

ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
ART = ROOT / "artifacts/existential_constructor_definition_inspection_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION.md"

art = json.loads(ART.read_text())
doc = DOC.read_text()

if art.get("status") != "EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_ONLY":
    raise SystemExit("MISSING_OBJECT := existential constructor definition inspection status")

if art.get("weakest_next_missing_object") != "existential_body_witness_locality_transport":
    raise SystemExit("MISSING_OBJECT := weakest inspected missing object")

expected = [
    "not existential_locality_radius_constructor",
    "not existential_body_witness_locality_transport",
    "not full_quantifier_locality_transport",
    "not full_formula_radius_construction",
    "not Pk1",
    "not 2vK",
    "not full_unguarded_fo_locality",
]

for boundary in expected:
    if boundary not in art.get("boundary", []):
        raise SystemExit("MISSING_OBJECT := artifact boundary " + boundary)

markers = [
    "EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_ONLY",
    "existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_locality_radius_constructor",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ full_quantifier_locality_transport",
    "BOUNDARY := ¬ full_formula_radius_construction",
    "BOUNDARY := ¬ Pk1",
    "BOUNDARY := ¬ 2vK",
    "BOUNDARY := ¬ full_unguarded_fo_locality",
]

for marker in markers:
    if marker not in doc:
        raise SystemExit("MISSING_OBJECT := doc marker " + marker)

print("EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_OK")
