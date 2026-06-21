#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_positive_radius_obstruction_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

closed = "tri_graph_r_target_to_quantifier_assignment_extension_radius_zero_projection"

assert data["status"] == "TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION"
assert data["parent_status"] == "TRI_GRAPH_R_QUANTIFIER_EXTENSION_RADIUS_ZERO_PROJECTION"
assert data["closed_theorem"] == closed
assert data["remaining_obstruction"] == "positive_radius_assignment_extension_projection_control"
assert "positive-radius assignment-extension control is not proved" in data["boundary"]
assert "STATUS := TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION" in doc_text
assert "WEAKEST_MISSING_OBJECT :=" in doc_text
assert closed in src_text
assert "AssignmentGaifmanClose M 0 ρ τ" in src_text
assert "x = y" in src_text
assert "AssignmentGaifmanClose M r ρ τ" not in src_text[src_text.index(closed):src_text.index("/-- TRI Graph assignment-extension semantics payload.")]

print("TRI_GRAPH_R_POSITIVE_RADIUS_OBSTRUCTION_OK")
