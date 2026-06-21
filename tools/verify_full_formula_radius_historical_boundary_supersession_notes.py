#!/usr/bin/env python3
from pathlib import Path
import json

artifact_path = Path("artifacts/full_formula_radius_historical_boundary_supersession_notes_2026_06_21.json")
doc_path = Path("docs/status/FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES.md")
audit_path = Path("artifacts/full_formula_radius_downstream_old_boundary_audit_2026_06_21.json")
closure_path = Path("artifacts/full_formula_radius_construction_2026_06_21.json")
src_path = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact_path.read_text())
doc = doc_path.read_text()
audit = json.loads(audit_path.read_text())
closure = json.loads(closure_path.read_text())
src = src_path.read_text()

assert data["status"] == "FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES"
assert data["superseding_commit"] == "e352dfa"
assert data["audit_commit"] == "936a562"
assert data["closed_object"] == "full_formula_radius_construction"
assert data["closed_object_status"] == "repository_internal_formula_radius_construction_only"
assert data["policy"]["preserve_historical_boundary_records"] is True
assert data["policy"]["add_targeted_supersession_notes"] is True
assert data["policy"]["rewrite_historical_status_records"] is False
assert data["source_hit_count"] == audit["hit_count"]
assert data["superseded_paths"] == sorted(hit["path"] for hit in audit["hits"])
assert closure["status"] == "FULL_FORMULA_RADIUS_CONSTRUCTION_CLOSED"
assert "noncomputable def unguarded_fo_formula_radius_construction" in src
assert "def full_formula_radius_construction : Type 1" in src
assert "noncomputable def full_formula_radius_construction_closed" in src
assert "theorem full_formula_radius_construction_status_closed" in src

assert "Status: `FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES`" in doc
assert "Preserve old historical boundary records unchanged." in doc
assert "Add targeted supersession notes." in doc
assert "Do not rewrite historical status records." in doc
assert "pre-`e352dfa` historical boundary records" in doc
assert "supersession-notes only" in data["boundary"]
assert "old historical artifacts and docs are preserved unchanged" in doc

for path in data["superseded_paths"]:
    assert Path(path).exists(), f"missing superseded path: {path}"
    assert f"`{path}`" in doc

print("FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES_OK")
