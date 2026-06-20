#!/usr/bin/env python3
from pathlib import Path
import json

lean_path = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
artifact_path = Path("artifacts/cslib_fmt/unguarded_fo_bounded_fragment_radius_constructors_2026_06_20.json")
doc_path = Path("docs/status/UNGUARDED_FO_BOUNDED_FRAGMENT_RADIUS_CONSTRUCTORS_2026_06_20.md")

for path in [lean_path, artifact_path, doc_path]:
    assert path.exists(), str(path)

lean = lean_path.read_text(encoding="utf-8")
artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

required_objects = [
    "singleton_bounded_syntactic_fragment",
    "atomic_bounded_syntactic_fragment",
    "singleton_radius_construction_target",
    "atomic_radius_constructor",
    "neg_radius_input",
    "neg_radius_constructor",
    "conj_radius_input",
    "conj_radius_constructor",
    "disj_radius_input",
    "disj_radius_constructor",
]

for name in required_objects:
    assert name in lean, name
    assert name in artifact["added_objects"], name
    assert name in doc, name

required_boundaries = [
    "formula-radius construction theorem",
    "existence of atomic locality inputs",
    "radius monotonicity",
    "closure of arbitrary bounded syntactic fragments",
    "unguarded FO locality theorem",
    "full Gaifman locality",
    "Fagin theorem",
    "0-1 Law",
    "general FMT closure",
]

for boundary in required_boundaries:
    assert boundary in artifact["does_not_prove"], boundary
    assert boundary in doc, boundary

assert artifact["status"] == "BOUNDED_FRAGMENT_ATOMIC_BOOLEAN_RADIUS_CONSTRUCTORS"
assert "NEXT_TARGET := bounded-fragment Boolean closure from target families with an explicit shared-radius invariant." in doc

print("UNGUARDED_FO_BOUNDED_FRAGMENT_RADIUS_CONSTRUCTORS_OK")
