#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/proof_bearing_quantifier_positive_radius_projection_edge_2026_06_21.json")
doc = Path("docs/status/PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

statement = "proof_bearing_quantifier_assignment_radius_control_statement"
proof = "trebuchet_variant_full_unguarded_fo_formula_radius_construction"
uses = "tri_graph_payload_positive_radius_assignment_extension_projection_with_transport_target"

assert data["status"] == "PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE"
assert data["parent_status"] == "TRI_GRAPH_PAYLOAD_POSITIVE_RADIUS_TRANSPORT_REFINEMENT"
assert data["statement"] == statement
assert data["proof"] == proof
assert data["uses_theorem"] == uses
assert data["scope"] == "downstream_edge_refinement_only"
assert "STATUS := PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE" in doc_text

for needle in [
    statement,
    "locality_surface_transport_body_to_quantified_formula_target ∧",
    "∀ (ρ τ : Fin n → M.carrier) (x y : M.carrier)",
    "AssignmentGaifmanClose M r ρ τ →",
    "GaifmanDistanceLe M x y r →",
    "AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y)",
    uses,
    "hTriGraph ρ τ x y hbase hxy).1",
]:
    assert needle in src_text

print("PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE_OK")
