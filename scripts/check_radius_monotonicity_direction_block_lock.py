#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ART = Path("artifacts/cslib_fmt/radius_monotonicity_direction_block_lock_2026_06_20.json")
DOC = Path("docs/status/RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

EXPECTED_STATUS = "RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_ONLY"

REQUIRED_LEAN_MARKERS = [
    "theorem assignment_gaifman_close_mono",
    "AssignmentGaifmanClose M r ρ τ →",
    "AssignmentGaifmanClose M s ρ τ",
    "structure RadiusMonotonicityTarget",
]

REQUIRED_DOC_MARKERS = [
    "PROGRESS_ID := cslib_fmt_radius_monotonicity_direction_block_lock_2026_06_20",
    "STATUS := RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_ONLY",
    "BLOCKED_CLAIM :=",
    "ADMISSIBLE_REPLACEMENT_DIRECTION :=",
    "No proof of radius monotonicity of locality input surfaces.",
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
    assert artifact["object"] == "RadiusMonotonicityTarget"
    assert artifact["lean_file"] == str(LEAN)
    assert "blocked" in artifact["blocked_claim"].lower()
    assert "s ≤ r" in artifact["admissible_replacement_direction"]

    for marker in REQUIRED_LEAN_MARKERS:
        assert marker in lean, marker
        assert marker in artifact["required_lean_markers"], marker

    for marker in REQUIRED_DOC_MARKERS:
        assert marker in doc, marker

    nonclaims = "\n".join(artifact["nonclaims"])
    for marker in [
        "Does not prove radius monotonicity of locality input surfaces.",
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

    print("RADIUS_MONOTONICITY_DIRECTION_BLOCK_LOCK_OK")

if __name__ == "__main__":
    main()
