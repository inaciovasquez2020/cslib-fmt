#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/twovk_bridge_target_shell_2026_06_21.json")
doc = Path("docs/status/TWOVK_BRIDGE_TARGET_SHELL.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

status = "TWOVK_BRIDGE_TARGET_SHELL"
target = "TwoVK_bridge_target_shell"
parent = "Pk1_unguarded_fo_locality_theorem_statement_shell"
parent_closed = "Pk1_unguarded_fo_locality_theorem_statement_shell_closed"

assert data["status"] == status
assert data["parent_status"] == "PK1_TARGET_THEOREM_STATEMENT_SHELL"
assert data["target"] == target
assert data["source_edge"] == parent
assert data["scope"] == "target_only_2vK_bridge_shell"
assert parent_closed in data["uses_proofs"]
assert "STATUS := TWOVK_BRIDGE_TARGET_SHELL" in doc_text

parent_pos = src_text.index(f"theorem {parent_closed}")
target_pos = src_text.index(f"def {target}")
assert parent_pos < target_pos

target_end = src_text.find("\nend UnguardedFO", target_pos)
assert target_end != -1, "could not find namespace end marker after 2vK bridge target"
target_block = src_text[target_pos:target_end]

for needle in [
    f"def {target} : Prop :=",
    parent,
    f"theorem {target}_closed",
    f"exact {parent_closed}",
]:
    assert needle in target_block

for boundary in [
    "does not prove 2vK",
    "does not prove Pk1",
    "full formula-radius construction",
    "full quantifier locality transport",
    "full unguarded FO locality",
]:
    assert boundary in data["boundary"]
    assert boundary in doc_text

print("TWOVK_BRIDGE_TARGET_SHELL_OK")
