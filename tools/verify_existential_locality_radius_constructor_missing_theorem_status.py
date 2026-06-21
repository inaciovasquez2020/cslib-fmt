#!/usr/bin/env python3
from pathlib import Path; import json, subprocess, sys
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
SRC = ROOT / "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
ART = ROOT / "artifacts/existential_locality_radius_constructor_missing_theorem_status_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS.md"
src = SRC.read_text(); art = json.loads(ART.read_text()); doc = DOC.read_text()
def fail(msg): raise SystemExit(msg)
required_src = ["def existential_locality_radius_constructor_missing_theorem_status : Prop :=", "TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status", "theorem existential_locality_radius_constructor_missing_theorem_status_closed :", "exact TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status_closed"]
missing_src = next((x for x in required_src if x not in src), None)
if missing_src is not None: fail("MISSING_OBJECT := Lean source marker " + missing_src)
forbidden = ["axiom existential_locality_radius_constructor", "opaque existential_locality_radius_constructor", "sorry", "admit"]
bad = next((x for x in forbidden if x in src), None)
if bad is not None: fail("MISSING_OBJECT := forbidden Lean marker absence " + bad)
if art.get("status") != "EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_ONLY": fail("MISSING_OBJECT := artifact status")
if art.get("status_def") != "existential_locality_radius_constructor_missing_theorem_status": fail("MISSING_OBJECT := artifact status_def")
if art.get("closed_theorem") != "existential_locality_radius_constructor_missing_theorem_status_closed": fail("MISSING_OBJECT := artifact closed_theorem")
boundaries = ["not existential_locality_radius_constructor", "not 2vK", "not Pk1", "not full_formula_radius_construction", "not full_quantifier_locality_transport", "not full_unguarded_fo_locality"]
missing_boundary = next((x for x in boundaries if x not in art.get("boundary", [])), None)
if missing_boundary is not None: fail("MISSING_OBJECT := artifact boundary " + missing_boundary)
markers = ["EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_ONLY", "BOUNDARY := ¬ existential_locality_radius_constructor", "BOUNDARY := ¬ 2vK", "BOUNDARY := ¬ Pk1", "BOUNDARY := ¬ full_formula_radius_construction", "BOUNDARY := ¬ full_quantifier_locality_transport", "BOUNDARY := ¬ full_unguarded_fo_locality"]
missing_doc = next((x for x in markers if x not in doc), None)
if missing_doc is not None: fail("MISSING_OBJECT := doc marker " + missing_doc)
print("EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_OK")
