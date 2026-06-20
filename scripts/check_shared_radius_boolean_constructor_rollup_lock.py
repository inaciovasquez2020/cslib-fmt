#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/shared_radius_boolean_constructor_rollup_lock_2026_06_20.json")
DOC = Path("docs/status/SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "theorem shared_radius_boolean_constructor_rollup",
    "SharedRadiusBooleanConstructorRollupTarget M",
    "unguarded_fo_neg_radius_constructor M hφ",
    "unguarded_fo_conj_same_radius_constructor M hφ hψ",
    "unguarded_fo_disj_same_radius_constructor M hφ hψ",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_shared_radius_boolean_rollup_constructor_lock_2026_06_20",
    "STATUS := SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_LOCK_ONLY",
    "No proof of shared-radius Boolean family recursion.",
    "No proof of max-radius Boolean recursion.",
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
    assert artifact["object"] == "shared_radius_boolean_constructor_rollup"
    assert artifact["lean_file"] == str(LEAN)

    theorem_pos = lean.index("theorem shared_radius_boolean_constructor_rollup")
    namespace_end_pos = lean.index("end UnguardedFO")
    assert theorem_pos < namespace_end_pos

    for marker in REQUIRED_LEAN_MARKERS:
        assert marker in lean, marker
        assert marker in artifact["required_lean_markers"], marker

    for marker in REQUIRED_DOC_MARKERS:
        assert marker in doc, marker

    nonclaims = "\n".join(artifact["nonclaims"])
    for marker in [
        "Does not prove shared-radius Boolean family recursion.",
        "Does not prove max-radius Boolean recursion.",
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

    print("SHARED_RADIUS_BOOLEAN_CONSTRUCTOR_ROLLUP_LOCK_OK")

if __name__ == "__main__":
    main()
