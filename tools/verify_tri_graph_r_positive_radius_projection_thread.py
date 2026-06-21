#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_positive_radius_projection_thread_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

theorem = "tri_graph_r_target_to_positive_radius_assignment_extension_projection"

assert data["status"] == "TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD"
assert data["parent_status"] == "TRI_GRAPH_POSITIVE_RADIUS_ASSIGNMENT_EXTENSION_PROJECTION"
assert data["theorem"] == theorem
assert data["uses_theorem"] == "tri_graph_positive_radius_assignment_extension_projection"
assert data["scope"] == "positive_radius_and_radius_zero_uniform"
assert "STATUS := TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD" in doc_text

for needle in [
    theorem,
    "tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ →",
    "AssignmentGaifmanClose M r ρ τ →",
    "GaifmanDistanceLe M x y r →",
    "AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) := by",
    "exact tri_graph_positive_radius_assignment_extension_projection hbase hxy",
]:
    assert needle in src_text

closed = "tri_graph_r_target_to_quantifier_assignment_extension_radius_zero_projection"
payload = "/-- TRI Graph assignment-extension semantics payload."
assert "AssignmentGaifmanClose M r ρ τ" not in src_text[src_text.index(closed):src_text.index(payload)]

print("TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD_OK")
