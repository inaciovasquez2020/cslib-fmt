#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/smaller_radius_locality_surface_weakening_lock_2026_06_20.json")
DOC = Path("docs/status/SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "theorem unguarded_fo_locality_input_surface_weaken_radius",
    "s ≤ r",
    "UnguardedFOLocalityInputSurface M φ r →",
    "UnguardedFOLocalityInputSurface M φ s",
    "assignment_gaifman_close_mono M hsr hclose",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_smaller_radius_locality_surface_weakening_lock_2026_06_20",
    "STATUS := SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_ONLY",
    "No proof of larger-radius strengthening of locality input surfaces.",
    "No proof of reverse assignment-close monotonicity.",
    "No proof of max-radius conjunction closure.",
    "No proof of max-radius disjunction closure.",
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
    assert artifact["object"] == "unguarded_fo_locality_input_surface_weaken_radius"
    assert artifact["lean_file"] == str(LEAN)

    theorem_pos = lean.index("theorem unguarded_fo_locality_input_surface_weaken_radius")
    atomic_pos = lean.index("abbrev AtomicLocalityInput")
    assert theorem_pos < atomic_pos

    for marker in REQUIRED_LEAN_MARKERS:
        assert marker in lean, marker
        assert marker in artifact["required_lean_markers"], marker

    for marker in REQUIRED_DOC_MARKERS:
        assert marker in doc, marker

    nonclaims = "\n".join(artifact["nonclaims"])
    for marker in [
        "Does not prove larger-radius strengthening of locality input surfaces.",
        "Does not prove reverse assignment-close monotonicity.",
        "Does not prove max-radius conjunction closure.",
        "Does not prove max-radius disjunction closure.",
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

    print("SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING_LOCK_OK")

if __name__ == "__main__":
    main()
