#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_positive_radius_assignment_extension_projection_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

theorem = "tri_graph_positive_radius_assignment_extension_projection"

assert data["status"] == "TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION"
assert data["parent_status"] == "TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION"
assert data["theorem"] == theorem
assert data["uses_assignment_extension"] == "extendAssignment"
assert data["scope"] == "positive_radius_and_radius_zero_uniform"
assert "STATUS := TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION" in doc_text
assert "Assignment-extension projection lemma only" in data["boundary"]

for needle in [
    theorem,
    "AssignmentGaifmanClose M r ρ τ →",
    "GaifmanDistanceLe M x y r →",
    "AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) := by",
    "simpa [extendAssignment] using hxy",
    "simpa [extendAssignment] using hbase ⟨j, hj⟩",
]:
    assert needle in src_text

print("TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION_OK")
