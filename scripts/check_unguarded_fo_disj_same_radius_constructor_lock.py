#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/unguarded_fo_disj_same_radius_constructor_lock_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_DISJ_SAME_RADIUS_CONSTRUCTOR_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "UNGUARDED_FO_DISJ_SAME_RADIUS_CONSTRUCTOR_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "theorem unguarded_fo_disj_same_radius_constructor",
    "UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) r",
    "unguarded_fo_locality_input_surface_invariant M φ r hφ ρ τ hclose",
    "unguarded_fo_locality_input_surface_invariant M ψ r hψ ρ τ hclose",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_disjunction_constructor_lock_2026_06_20",
    "STATUS := UNGUARDED_FO_DISJ_SAME_RADIUS_CONSTRUCTOR_LOCK_ONLY",
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
    assert artifact["object"] == "unguarded_fo_disj_same_radius_constructor"
    assert artifact["lean_file"] == str(LEAN)

    theorem_pos = lean.index("theorem unguarded_fo_disj_same_radius_constructor")
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

    print("UNGUARDED_FO_DISJ_SAME_RADIUS_CONSTRUCTOR_LOCK_OK")

if __name__ == "__main__":
    main()
