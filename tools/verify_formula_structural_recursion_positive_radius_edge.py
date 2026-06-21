#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/formula_structural_recursion_positive_radius_edge_2026_06_21.json")
doc = Path("docs/status/FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

target = "formula_structural_recursion_assembler_target"
proof = "trebuchet_variant_full_unguarded_fo_formula_radius_construction"

assert data["status"] == "FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE"
assert data["parent_status"] == "PROOF_BEARING_QUANTIFIER_POSITIVE_RADIUS_PROJECTION_EDGE"
assert data["target"] == target
assert data["new_dependency"] == "proof_bearing_quantifier_assignment_radius_control_statement"
assert data["uses_proof"] == proof
assert data["scope"] == "one_downstream_target_edge_replacement"
assert "STATUS := FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE" in doc_text

target_start = src_text.index(f"def {target}")
target_end = src_text.index("structure SharedRadiusBooleanConstructorRollupTarget")
target_block = src_text[target_start:target_end]

for needle in [
    "quantified_formula_radius_constructor_target_status ∧",
    "proof_bearing_quantifier_assignment_radius_control_statement",
    "constructor",
    "exact quantified_formula_radius_constructor_target_status_closed",
    f"exact {proof}",
]:
    assert needle in target_block

assert src_text.index(proof) < src_text.index(f"def {target}")

print("FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE_OK")
