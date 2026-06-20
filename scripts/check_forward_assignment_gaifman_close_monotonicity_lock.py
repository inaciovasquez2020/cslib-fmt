#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/forward_assignment_gaifman_close_monotonicity_lock_2026_06_20.json")
DOC = Path("docs/status/FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "theorem gaifman_distance_le_mono",
    "theorem assignment_gaifman_close_mono",
    "GaifmanDistanceLe M x y r →",
    "GaifmanDistanceLe M x y s",
    "AssignmentGaifmanClose M r ρ τ →",
    "AssignmentGaifmanClose M s ρ τ",
    "Nat.le_trans hn hrs",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_forward_assignment_close_monotonicity_lock_2026_06_20",
    "STATUS := FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_ONLY",
    "REVERSE_DIRECTION_STATUS := NOT_AVAILABLE_FROM_CURRENT_DEFINITION",
    "No proof of reverse assignment-close monotonicity.",
    "No proof of radius monotonicity of locality input surfaces.",
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
    assert artifact["object"] == "assignment_gaifman_close_mono"
    assert artifact["lean_file"] == str(LEAN)
    assert artifact["reverse_direction_status"] == "NOT_AVAILABLE_FROM_CURRENT_DEFINITION"

    distance_pos = lean.index("theorem gaifman_distance_le_mono")
    assignment_pos = lean.index("theorem assignment_gaifman_close_mono")
    surface_pos = lean.index("structure UnguardedFOLocalityInputSurface")
    assert distance_pos < assignment_pos < surface_pos

    for marker in REQUIRED_LEAN_MARKERS:
        assert marker in lean, marker
        assert marker in artifact["required_lean_markers"], marker

    for marker in REQUIRED_DOC_MARKERS:
        assert marker in doc, marker

    nonclaims = "\n".join(artifact["nonclaims"])
    for marker in [
        "Does not prove the reverse direction AssignmentGaifmanClose M s ρ τ implies AssignmentGaifmanClose M r ρ τ.",
        "Does not prove radius monotonicity of locality input surfaces.",
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

    print("FORWARD_ASSIGNMENT_GAIFMAN_CLOSE_MONOTONICITY_LOCK_OK")

if __name__ == "__main__":
    main()
