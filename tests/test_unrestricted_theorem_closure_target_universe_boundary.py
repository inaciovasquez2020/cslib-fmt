from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs/status/UNRESTRICTED_THEOREM_CLOSURE_TARGET_UNIVERSE.md"
VERIFIER = ROOT / "scripts/verify_unrestricted_theorem_closure_target_universe_boundary.py"


def test_unrestricted_theorem_closure_target_universe_boundary() -> None:
    text = DOC.read_text(encoding="utf-8")

    required = [
        "STATUS := TARGET_UNIVERSE_MISSING",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%",
        "WEAKEST_ADMISSIBLE_REPLACEMENT := bounded_recursive_theorem_family_closure",
        "POSITIVE_FINITE_FAMILY_CRITERION :=",
        "REJECTED_PROMOTION := bounded theorem-closure audit examples do not imply unrestricted theorem closure.",
        "BOUNDARY := ¬ unrestricted_theorem_closure",
    ]

    forbidden = [
        "CLAIM_NOW_SAFE := unrestricted theorem closure",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 1%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 10%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 20%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 50%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 88%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 100%",
        "bounded theorem-closure audit examples imply unrestricted theorem closure",
        "BOUNDARY := unrestricted_theorem_closure",
    ]

    for item in required:
        assert item in text

    for item in forbidden:
        assert item not in text

    result = subprocess.run(
        [sys.executable, str(VERIFIER)],
        cwd=ROOT,
        check=True,
        text=True,
        capture_output=True,
    )
    assert "UNRESTRICTED_THEOREM_CLOSURE_TARGET_UNIVERSE_BOUNDARY_OK" in result.stdout
