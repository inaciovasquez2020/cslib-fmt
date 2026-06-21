#!/usr/bin/env python3
from pathlib import Path
import json
import subprocess
ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())
REPORT = ROOT / "artifacts/full_unguarded_fo_pk1_route_gap_rank_2026_06_21.json"
DOC = ROOT / "docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK.md"
report = json.loads(REPORT.read_text())
doc = DOC.read_text()
if report.get("status") != "FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_ONLY": raise SystemExit("MISSING_OBJECT := full route gap-rank status")
expected = ["existential_locality_radius_constructor", "full_quantifier_locality_transport", "full_formula_radius_construction", "Pk1", "2vK"]
ranked = report.get("ranked_gaps", [])
actual = [entry.get("missing_object") for entry in ranked]
if actual != expected: raise SystemExit("MISSING_OBJECT := ordered full route missing-object rank")
boundaries = ["not existential_locality_radius_constructor", "not full_quantifier_locality_transport", "not full_formula_radius_construction", "not Pk1", "not 2vK", "not full_unguarded_fo_locality"]
missing_boundary = next((boundary for boundary in boundaries if boundary not in report.get("boundary", [])), None)
if missing_boundary is not None: raise SystemExit("MISSING_OBJECT := artifact boundary " + missing_boundary)
markers = ["FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_ONLY", "BOUNDARY := ¬ existential_locality_radius_constructor", "BOUNDARY := ¬ full_quantifier_locality_transport", "BOUNDARY := ¬ full_formula_radius_construction", "BOUNDARY := ¬ Pk1", "BOUNDARY := ¬ 2vK", "BOUNDARY := ¬ full_unguarded_fo_locality"]
missing_doc = next((marker for marker in markers if marker not in doc), None)
if missing_doc is not None: raise SystemExit("MISSING_OBJECT := doc marker " + missing_doc)
print("FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK_OK")
