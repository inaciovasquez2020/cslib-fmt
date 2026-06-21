#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/formula_radius_construction_gate_structural_recursion_edge_2026_06_21.json")
doc = Path("docs/status/FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

status = "FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE"
target = "formula_radius_construction_gate_structural_recursion_edge"
old_gate = "formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate"
assembler = "formula_structural_recursion_assembler_target"

assert data["status"] == status
assert data["parent_status"] == "FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE"
assert data["target"] == target
assert data["preserves_dependency"] == old_gate
assert data["new_dependency"] == assembler
assert data["scope"] == "one_formula_radius_gate_edge_refinement"
assert f"STATUS := {status}" in doc_text

target_start = src_text.index(f"def {target}")
target_end = src_text.index("structure SharedRadiusBooleanConstructorRollupTarget")
target_block = src_text[target_start:target_end]

for needle in [
    f"{old_gate} ∧",
    assembler,
    "constructor",
    f"exact {old_gate}_closed",
    f"exact {assembler}_closed",
]:
    assert needle in target_block

assert src_text.index("def formula_structural_recursion_assembler_target") < target_start
assert src_text.index(f"def {target}") < src_text.index("structure SharedRadiusBooleanConstructorRollupTarget")
assert "full formula-radius construction" in data["boundary"]
assert "full unguarded FO locality" in data["boundary"]

print("FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE_OK")
