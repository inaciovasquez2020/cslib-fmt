#!/usr/bin/env python3
from pathlib import Path
import json, subprocess
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
SRC = ROOT / "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
ART = ROOT / "artifacts/existential_body_witness_locality_transport_type_shell_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL.md"
src = SRC.read_text(); art = json.loads(ART.read_text()); doc = DOC.read_text()
if art.get("status") != "EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL_ONLY": raise SystemExit("MISSING_OBJECT := type-shell artifact status")
markers = ["def existential_body_witness_locality_transport_type : Type 1 :=", "HasUnguardedFOLocalityRadius M φ →", "HasUnguardedFOLocalityRadius M (Formula.ex φ)"]
missing_src = next((x for x in markers if x not in src), None)
if missing_src is not None: raise SystemExit("MISSING_OBJECT := Lean source marker " + missing_src)
forbidden = ["def existential_body_witness_locality_transport :=", "axiom existential_body_witness_locality_transport", "opaque existential_body_witness_locality_transport", "sorry", "admit"]
bad = next((x for x in forbidden if x in src), None)
if bad is not None: raise SystemExit("MISSING_OBJECT := forbidden proof marker absence " + bad)
boundaries = ["not existential_body_witness_locality_transport", "not existential_locality_radius_constructor", "not full_quantifier_locality_transport", "not full_formula_radius_construction", "not Pk1", "not 2vK", "not full_unguarded_fo_locality"]
missing_boundary = next((x for x in boundaries if x not in art.get("boundary", [])), None)
if missing_boundary is not None: raise SystemExit("MISSING_OBJECT := artifact boundary " + missing_boundary)
doc_markers = ["EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL_ONLY", "def existential_body_witness_locality_transport_type : Type 1 :=", "BOUNDARY := ¬ existential_body_witness_locality_transport", "BOUNDARY := ¬ existential_locality_radius_constructor", "BOUNDARY := ¬ full_quantifier_locality_transport", "BOUNDARY := ¬ full_formula_radius_construction", "BOUNDARY := ¬ Pk1", "BOUNDARY := ¬ 2vK", "BOUNDARY := ¬ full_unguarded_fo_locality"]
missing_doc = next((x for x in doc_markers if x not in doc), None)
if missing_doc is not None: raise SystemExit("MISSING_OBJECT := doc marker " + missing_doc)
print("EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL_OK")
