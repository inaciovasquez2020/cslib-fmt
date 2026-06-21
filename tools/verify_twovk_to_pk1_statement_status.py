#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/twovk_to_pk1_statement_status_2026_06_21.json")
doc = Path("docs/status/TWOVK_TO_PK1_STATEMENT_STATUS.md")
src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

data = json.loads(artifact.read_text())
doc_text = doc.read_text()
src_text = src.read_text()

status = "TWOVK_TO_PK1_STATEMENT_STATUS"
target = "TwoVK_bridge_target_to_Pk1_statement_status"
parent = "TwoVK_bridge_target_shell"
projected = "Pk1_unguarded_fo_locality_theorem_statement_shell"
parent_closed = "TwoVK_bridge_target_shell_closed"

assert data["status"] == status
assert data["parent_status"] == "TWOVK_BRIDGE_TARGET_SHELL"
assert data["target"] == target
assert data["source_edge"] == parent
assert data["projected_dependency"] == projected
assert data["scope"] == "one_direct_twovk_to_pk1_statement_status_edge"
assert parent_closed in data["uses_proofs"]
assert "STATUS := TWOVK_TO_PK1_STATEMENT_STATUS" in doc_text

parent_pos = src_text.index(f"theorem {parent_closed}")
target_pos = src_text.index(f"def {target}")
assert parent_pos < target_pos

target_end = src_text.find("\n/--", target_pos + 1)
if target_end == -1:
    target_end = src_text.find("\nend UnguardedFO", target_pos)
assert target_end != -1, "could not find target block end after TwoVK to Pk1 statement status"
target_block = src_text[target_pos:target_end]

for needle in [
    f"def {target} : Prop :=",
    f"{parent} ∧",
    projected,
    f"theorem {target}_closed",
    f"have hBridge : {parent}",
    parent_closed,
    "exact hBridge",
]:
    assert needle in target_block

for forbidden in [
    "def TwoVK_proved",
    "theorem TwoVK_proved",
    "def Pk1_proved",
    "theorem Pk1_proved",
    "full_formula_radius_construction",
    "full_quantifier_locality_transport",
    "full_unguarded_fo_locality",
]:
    assert forbidden not in target_block

for boundary in [
    "does not prove 2vK",
    "does not prove Pk1",
    "full formula-radius construction",
    "full quantifier locality transport",
    "full unguarded FO locality",
]:
    assert boundary in data["boundary"]
    assert boundary in doc_text

print("TWOVK_TO_PK1_STATEMENT_STATUS_OK")
