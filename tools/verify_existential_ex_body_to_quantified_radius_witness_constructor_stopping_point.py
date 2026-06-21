#!/usr/bin/env python3
from pathlib import Path
import json
import subprocess

ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
ART = ROOT / "artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md"
SRC = ROOT / "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"

art = json.loads(ART.read_text())
doc = DOC.read_text()
src = SRC.read_text()

if art.get("status") != "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_ONLY":
    raise SystemExit("MISSING_OBJECT := stopping-point artifact status")

if art.get("weakest_missing_object") != "existential_ex_body_to_quantified_radius_witness_constructor":
    raise SystemExit("MISSING_OBJECT := weakest missing witness constructor")

for marker in ["HasUnguardedFOLocalityRadius", "Formula.ex", "existential_body_witness_locality_transport_type"]:
    if marker not in src:
        raise SystemExit("MISSING_OBJECT := inspected source marker " + marker)

for boundary in [
    "not existential_ex_body_to_quantified_radius_witness_constructor",
    "not existential_body_witness_locality_transport",
    "not existential_locality_radius_constructor",
    "not full_quantifier_locality_transport",
    "not full_formula_radius_construction",
    "not Pk1",
    "not 2vK",
    "not full_unguarded_fo_locality",
]:
    if boundary not in art.get("boundary", []):
        raise SystemExit("MISSING_OBJECT := artifact boundary " + boundary)

for marker in [
    "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_ONLY",
    "existential_ex_body_to_quantified_radius_witness_constructor",
    "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_locality_radius_constructor",
    "BOUNDARY := ¬ full_quantifier_locality_transport",
    "BOUNDARY := ¬ full_formula_radius_construction",
    "BOUNDARY := ¬ Pk1",
    "BOUNDARY := ¬ 2vK",
    "BOUNDARY := ¬ full_unguarded_fo_locality",
]:
    if marker not in doc:
        raise SystemExit("MISSING_OBJECT := doc marker " + marker)

print("EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_OK")
