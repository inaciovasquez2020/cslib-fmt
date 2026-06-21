#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/pk1_quantified_constructor_branch_frontier_status_2026_06_21.json")
doc = Path("docs/status/PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

status = "PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS"
target = "pk1_quantified_constructor_branch_frontier_status"
source_edge = "formula_radius_construction_gate_structural_recursion_edge"
projected = "quantified_formula_radius_constructor_target_status"

assert data["status"] == status
assert data["parent_status"] == "FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE"
assert data["target"] == target
assert data["source_edge"] == source_edge
assert data["projected_dependency"] == projected
assert data["scope"] == "one_pk1_quantified_constructor_branch_frontier_status_edge"
assert "STATUS := PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS" in doc_text

target_start = src_text.index(f"def {target}")
target_end_candidates = [
    pos for marker in [
        "structure SharedRadiusBooleanConstructorRollupTarget",
        "end UnguardedFO",
    ]
    if (pos := src_text.find(marker, target_start)) != -1
]
assert target_end_candidates, "could not find end marker after target"
target_end = min(target_end_candidates)
target_block = src_text[target_start:target_end]

for needle in [
    f"def {target}",
    f"{source_edge} ∧",
    projected,
    f"theorem {target}_closed",
    "have hGate : formula_radius_construction_gate_structural_recursion_edge",
    "formula_radius_construction_gate_structural_recursion_edge_closed",
    "exact hGate",
    "exact hGate.2.1",
]:
    assert needle in target_block

assert src_text.index(f"def {source_edge}") < target_start
assert "full formula-radius construction" in data["boundary"]
assert "full quantifier locality transport" in data["boundary"]
assert "full unguarded FO locality" in data["boundary"]
assert "does not define or prove Pk1" in data["boundary"]
assert "2vK" in data["boundary"]

print("PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS_OK")
