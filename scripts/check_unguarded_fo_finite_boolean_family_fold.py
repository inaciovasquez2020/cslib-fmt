#!/usr/bin/env python3
from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_finite_boolean_family_fold_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_FINITE_BOOLEAN_FAMILY_FOLD_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

required_objects = [
    "FiniteBooleanFamilyExpr",
    "finite_boolean_family_fold_with_radius",
    "finite_boolean_family_fold",
    "finite_boolean_family_fold_shared_radius",
]

for name in required_objects:
    assert name in lean, name
    assert name in artifact["added_objects"], name
    assert name in doc, name

required_phrases = [
    "explicit finite Boolean expression syntax",
    "indexed environment",
    "∀ i, (env i).sharedRadius = sharedRadius",
    "preserves the invariant through each constructor step",
    "not arbitrary bounded-fragment closure",
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

assert artifact["status"] == "FINITE_BOOLEAN_FAMILY_FOLD_EXPLICIT_SHARED_RADIUS"
assert "NEXT_TARGET := extract finite Boolean fold target and fragment membership lemmas." in doc

print("UNGUARDED_FO_FINITE_BOOLEAN_FAMILY_FOLD_OK")
