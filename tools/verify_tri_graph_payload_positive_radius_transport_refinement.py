#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/tri_graph_payload_positive_radius_transport_refinement_2026_06_21.json")
doc = Path("docs/status/TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

theorem = "tri_graph_payload_positive_radius_assignment_extension_projection_with_transport_target"

assert data["status"] == "TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT"
assert data["parent_status"] == "TRI_GRAPH_R_POSITIVE_RADIUS_PROJECTION_THREAD"
assert data["theorem"] == theorem
assert data["uses_theorem"] == "tri_graph_r_target_to_positive_radius_assignment_extension_projection"
assert data["uses_payload"] == "tri_graph_assignment_extension_semantics_payload"
assert data["scope"] == "payload_refinement_only"
assert "STATUS := TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT" in doc_text

for needle in [
    theorem,
    "tri_graph_assignment_extension_semantics_payload M r φ →",
    "AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) ∧",
    "locality_surface_transport_body_to_quantified_formula_target := by",
    "tri_graph_r_target_to_positive_radius_assignment_extension_projection",
    "hPayload.2.1 ρ τ x y hbase hxy",
    "exact hPayload.2.2",
]:
    assert needle in src_text

print("TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT_OK")
