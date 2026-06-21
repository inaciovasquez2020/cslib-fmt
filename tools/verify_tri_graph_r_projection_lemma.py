#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_projection_lemma_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_PROJECTION_LEMMA.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

lemma = "tri_graph_r_target_to_assignment_extension_projection_radius_control"

assert data["status"] == "TRI_GRAPH_R_PROJECTION_LEMMA"
assert data["parent_status"] == "TRI_GRAPH_R_SEMANTIC_TARGET"
assert data["lemma"] == lemma
assert "Projection lemma only" in data["boundary"]
assert "STATUS := TRI_GRAPH_R_PROJECTION_LEMMA" in doc_text
assert lemma in src_text
assert "tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ →" in src_text
assert "assignment_extension_projection_radius_control_statement_target := by" in src_text
assert "exact hR.1" in src_text

print("TRI_GRAPH_R_PROJECTION_LEMMA_OK")
