#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_radius_zero_projection_invariant_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

invariant = "tri_graph_radius_zero_assignment_projection_invariant"
closed = "tri_graph_radius_zero_assignment_projection_invariant_closed"

assert data["status"] == "TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT"
assert data["parent_status"] == "TRI_GRAPH_R_PROJECTION_LEMMA"
assert data["invariant"] == invariant
assert data["closed_by"] == closed
assert data["uses_existing_theorem"] == "assignment_gaifman_close_radius_zero_preservation"
assert data["scope"] == "radius_zero_only"
assert "STATUS := TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT" in doc_text

for needle in [
    invariant,
    closed,
    "AssignmentGaifmanClose M 0 ρ τ",
    "∀ x : Fin n, ρ x = τ x",
    "assignment_gaifman_close_radius_zero_preservation M ρ τ hclose x",
    "tri_graph_radius_zero_assignment_projection_invariant (n := n) M",
]:
    assert needle in src_text

r_start = src_text.index("def tri_graph_assignment_extension_projection_radius_control_semantics_target")
r_end = src_text.index("/-- R-projection lemma:")
r_block = src_text[r_start:r_end]
assert "tri_graph_radius_zero_assignment_projection_invariant (n := n) M" in r_block

print("TRI_GRAPH_R_RADIUS_ZERO_PROJECTION_INVARIANT_OK")
