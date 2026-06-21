#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/pk1_target_theorem_statement_shell_2026_06_21.json")
doc = Path("docs/status/PK1_TARGET_THEOREM_STATEMENT_SHELL.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

status = "PK1_TARGET_THEOREM_STATEMENT_SHELL"
target = "Pk1_unguarded_fo_locality_theorem_statement_shell"
parent = "pk1_quantified_constructor_branch_frontier_status"
parent_closed = "pk1_quantified_constructor_branch_frontier_status_closed"

assert data["status"] == status
assert data["parent_status"] == "PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS"
assert data["target"] == target
assert data["source_edge"] == parent
assert data["scope"] == "target_only_pk1_theorem_statement_shell"
assert parent_closed in data["uses_proofs"]
assert "STATUS := PK1_TARGET_THEOREM_STATEMENT_SHELL" in doc_text

parent_pos = src_text.index(f"theorem {parent_closed}")
target_pos = src_text.index(f"def {target}")
assert parent_pos < target_pos

target_end = src_text.index(f"theorem {target}_closed", target_pos)
target_block = src_text[target_pos:target_end]
closed_block_start = target_end
closed_block_end_candidates = [
    pos for marker in [
        "\n/-- Target-only 2vK bridge shell.",
        "\nend UnguardedFO",
    ]
    if (pos := src_text.find(marker, closed_block_start)) != -1
]
assert closed_block_end_candidates, "could not find end marker after Pk1 closed theorem"
closed_block = src_text[closed_block_start:min(closed_block_end_candidates)]

for needle in [
    f"def {target} : Prop :=",
    parent,
]:
    assert needle in target_block

for needle in [
    f"theorem {target}_closed",
    f"exact {parent_closed}",
]:
    assert needle in closed_block

for forbidden in [
    "def twovk",
    "theorem twovk",
    "def two_vk",
    "theorem two_vk",
    "def TwoVK",
    "theorem TwoVK",
    "def 2vK",
    "theorem 2vK",
]:
    assert forbidden not in target_block
    assert forbidden not in closed_block

for boundary in [
    "does not prove Pk1",
    "does not define or prove 2vK",
    "full formula-radius construction",
    "full quantifier locality transport",
    "full unguarded FO locality",
]:
    assert boundary in data["boundary"]
    assert boundary in doc_text

print("PK1_TARGET_THEOREM_STATEMENT_SHELL_OK")
