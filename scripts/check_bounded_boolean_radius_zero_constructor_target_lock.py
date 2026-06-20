#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/bounded_boolean_radius_zero_constructor_target_lock_2026_06_20.json")
DOC = Path("docs/status/BOUNDED_BOOLEAN_RADIUS_ZERO_CONSTRUCTOR_TARGET_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "BOUNDED_BOOLEAN_RADIUS_ZERO_CONSTRUCTOR_TARGET_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "structure BoundedBooleanRadiusZeroConstructorTarget",
    "atomic_eq",
    "atomic_rel",
    "boolean_constructor_obligation",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_boolean_radius_zero_constructor_target_lock_2026_06_20",
    "STATUS := BOUNDED_BOOLEAN_RADIUS_ZERO_CONSTRUCTOR_TARGET_LOCK_ONLY",
    "This is target-only. It does not discharge Boolean recursion.",
    "No proof of unguarded FO Gaifman locality.",
    "No proof of Fagin's theorem.",
    "No proof of the 0-1 Law.",
    "No proof of general finite model theory closure.",
]

FORBIDDEN_LIVE_MARKERS = ["axiom", "opaque", "sorry", "admit"]

def main() -> None:
    artifact = json.loads(ART.read_text())
    doc = DOC.read_text()
    lean = LEAN.read_text()

    assert artifact["status"] == EXPECTED_STATUS
    assert artifact["object"] == "BoundedBooleanRadiusZeroConstructorTarget"
    assert artifact["lean_file"] == str(LEAN)

    for marker in REQUIRED_LEAN_MARKERS:
        assert marker in lean, marker
        assert marker in artifact["required_lean_markers"], marker

    for marker in REQUIRED_DOC_MARKERS:
        assert marker in doc, marker

    nonclaims = "\n".join(artifact["nonclaims"])
    for marker in [
        "Does not prove Boolean recursion.",
        "Does not prove negation closure.",
        "Does not prove conjunction closure.",
        "Does not prove disjunction closure.",
        "Does not prove existential quantifier handling.",
        "Does not prove arbitrary formula-radius construction.",
        "Does not prove Gaifman locality for unguarded first-order logic.",
        "Does not prove Fagin's theorem.",
        "Does not prove the 0-1 Law.",
        "Does not prove general finite model theory closure.",
    ]:
        assert marker in nonclaims, marker

    for marker in FORBIDDEN_LIVE_MARKERS:
        assert marker not in lean, marker

    print("BOUNDED_BOOLEAN_RADIUS_ZERO_CONSTRUCTOR_TARGET_LOCK_OK")

if __name__ == "__main__":
    main()
