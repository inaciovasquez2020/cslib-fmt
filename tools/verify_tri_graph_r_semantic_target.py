#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_r_semantic_target_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_R_SEMANTIC_TARGET.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

required = [
    "tri_graph_assignment_extension_projection_radius_control_semantics_target",
    "assignment_extension_projection_radius_control_statement_target",
    "quantified_formula_radius_constructor_target_status",
    "radius_preservation_under_quantifier_assignment_move_target",
    "locality_surface_transport_body_to_quantified_formula_target",
]

assert data["status"] == "TRI_GRAPH_R_SEMANTIC_TARGET"
assert data["parent_status"] == "TRI_GRAPH_NAME_LAYER_ONLY"
assert data["new_component"] == "R"
assert data["tri_graph_name_layer_only"] is False
assert data["new_target"] == "tri_graph_assignment_extension_projection_radius_control_semantics_target"
assert "no assignment-extension theorem" in data["boundary"]
assert "STATUS := TRI_GRAPH_R_SEMANTIC_TARGET" in doc_text

for needle in required:
    assert needle in src_text

payload_start = src_text.index("def tri_graph_assignment_extension_semantics_payload")
payload_end = src_text.index("def proof_bearing_quantifier_assignment_radius_control_statement")
payload = src_text[payload_start:payload_end]

assert "(M = M)" not in payload
assert "(r = r)" not in payload
assert "(φ = φ)" not in payload
assert "tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ" in payload

print("TRI_GRAPH_R_SEMANTIC_TARGET_OK")
