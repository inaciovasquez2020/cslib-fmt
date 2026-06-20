#!/usr/bin/env python3
from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_shared_radius_family_introductions_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_SHARED_RADIUS_FAMILY_INTRODUCTIONS_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

required_objects = [
    "singleton_shared_radius_target_family",
    "atomic_shared_radius_target_family",
    "neg_shared_radius_target_family",
    "conj_shared_radius_target_family",
    "disj_shared_radius_target_family",
]

for name in required_objects:
    assert name in lean, name
    assert name in artifact["added_objects"], name
    assert name in doc, name

required_phrases = [
    "explicit-radius inputs",
    "Boolean constructor outputs",
    "target-family scoped",
    "left.sharedRadius = right.sharedRadius",
]

for phrase in required_phrases:
    assert phrase in doc, phrase

required_boundaries = [
    "formula-radius construction theorem",
    "existence of atomic locality inputs",
    "radius monotonicity",
    "arbitrary bounded-fragment closure",
    "unguarded FO locality theorem",
    "full Gaifman locality",
    "Fagin theorem",
    "0-1 Law",
    "general FMT closure",
]

for boundary in required_boundaries:
    assert boundary in artifact["does_not_prove"], boundary
    assert boundary in doc, boundary

assert artifact["status"] == "SHARED_RADIUS_FAMILY_INTRODUCTIONS"
assert "NEXT_TARGET := finite Boolean expression family fold under explicit shared-radius environment." in doc

print("UNGUARDED_FO_SHARED_RADIUS_FAMILY_INTRODUCTIONS_OK")
