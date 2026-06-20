#!/usr/bin/env python3
from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_shared_radius_boolean_target_family_closure_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_SHARED_RADIUS_BOOLEAN_TARGET_FAMILY_CLOSURE_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

required_objects = [
    "SharedRadiusTargetFamily",
    "SharedRadiusTargetFamilyPair",
    "neg_shared_radius_target_family_fragment",
    "neg_shared_radius_target_family_constructor",
    "conj_shared_radius_target_family_fragment",
    "conj_shared_radius_target_family_constructor",
    "disj_shared_radius_target_family_fragment",
    "disj_shared_radius_target_family_constructor",
]

for name in required_objects:
    assert name in lean, name
    assert name in artifact["added_objects"], name
    assert name in doc, name

required_phrases = [
    "target-family scoped",
    "explicit shared-radius invariant",
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

assert artifact["status"] == "SHARED_RADIUS_BOOLEAN_TARGET_FAMILY_CLOSURE"
assert "NEXT_TARGET := shared-radius family introduction from singleton constructors and Boolean constructor outputs." in doc

print("UNGUARDED_FO_SHARED_RADIUS_BOOLEAN_TARGET_FAMILY_CLOSURE_OK")
