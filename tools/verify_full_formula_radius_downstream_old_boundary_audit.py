#!/usr/bin/env python3
from pathlib import Path
import json

artifact_path = Path("artifacts/full_formula_radius_downstream_old_boundary_audit_2026_06_21.json")
doc_path = Path("docs/status/FULL_FORMULA_RADIUS_DOWNSTREAM_OLD_BOUNDARY_AUDIT.md")
src_path = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact_path.read_text())
doc = doc_path.read_text()
src = src_path.read_text()

assert data["status"] == "FULL_FORMULA_RADIUS_DOWNSTREAM_OLD_BOUNDARY_AUDIT"
assert data["source_commit"] == "e352dfa"
assert data["closed_object"] == "full_formula_radius_construction"
assert data["closed_object_status"] == "repository_internal_formula_radius_construction_only"
assert "noncomputable def unguarded_fo_formula_radius_construction" in src
assert "def full_formula_radius_construction : Type 1" in src
assert "noncomputable def full_formula_radius_construction_closed" in src
assert "theorem full_formula_radius_construction_status_closed" in src
assert isinstance(data["hits"], list)
assert data["hit_count"] == len(data["hits"])
assert data["hit_count"] >= 0
assert "Status: `FULL_FORMULA_RADIUS_DOWNSTREAM_OLD_BOUNDARY_AUDIT`" in doc
assert "audit-only inventory" in data["boundary"]
assert "no historical status rewrite" in doc

for hit in data["hits"]:
    path = Path(hit["path"])
    assert path.exists(), f"missing hit path: {path}"
    text = path.read_text(errors="ignore")
    assert any(pattern in text for pattern in hit["matched_patterns"])
    assert hit["line_count"] >= 1
    assert isinstance(hit["lines"], list)

print("FULL_FORMULA_RADIUS_DOWNSTREAM_OLD_BOUNDARY_AUDIT_OK")
