#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_name_layer_only_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_NAME_LAYER_ONLY.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

assert data["status"] == "TRI_GRAPH_NAME_LAYER_ONLY"
assert data["tri_graph_name_layer_only"] is True
assert data["tri_graph_parts"]["T"] == "quantifier_assignment_semantics_bridge_target"
assert data["tri_graph_parts"]["R"] == "assignment_extension_projection_radius_control_statement_target"
assert data["tri_graph_parts"]["I"] == "locality_surface_transport_body_to_quantified_formula_target"
assert "no claim of a new mathematical theorem" in data["boundary"]
assert "STATUS := TRI_GRAPH_NAME_LAYER_ONLY" in doc_text
assert "tri_graph_assignment_extension_semantics_payload" in src_text
assert "proof_bearing_quantifier_assignment_radius_control_statement" in src_text

print("TRI_GRAPH_NAME_LAYER_ONLY_OK")
