#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_quantifier_extension_radius_zero_projection_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

theorem = "tri_graph_r_target_to_quantifier_assignment_extension_radius_zero_projection"

assert data["status"] == "TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION"
assert data["parent_status"] == "TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT"
assert data["theorem"] == theorem
assert data["uses_assignment_extension"] == "extendAssignment"
assert data["scope"] == "radius_zero_only"
assert "STATUS := TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION" in doc_text

for needle in [
    theorem,
    "extendAssignment ρ x i = extendAssignment τ y i",
    "tri_graph_radius_zero_assignment_projection_invariant (n := n) M := hR.2.1",
    "AssignmentGaifmanClose M 0 ρ τ",
    "simpa [extendAssignment] using hxy",
    "simpa [extendAssignment] using hproj",
]:
    assert needle in src_text

print("TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION_OK")
