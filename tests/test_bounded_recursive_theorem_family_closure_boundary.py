from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs/status/BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE.md"
VERIFIER = ROOT / "scripts/verify_bounded_recursive_theorem_family_closure_boundary.py"


def test_bounded_recursive_theorem_family_closure_boundary() -> None:
    text = DOC.read_text(encoding="utf-8")

    required = [
        "STATUS := WEAKEST_ADMISSIBLE_REPLACEMENT_ONLY",
        "SCOPE := bounded recursive theorem family only",
        "REPLACES_REJECTED_TARGET := unrestricted_theorem_closure",
        "POSITIVE_CRITERION :=",
        "FORBIDDEN_PROMOTION := bounded_recursive_theorem_family_closure does not imply unrestricted theorem closure.",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%",
        "BOUNDARY := ¬ unrestricted_theorem_closure",
    ]

    forbidden = [
        "STATUS := unrestricted theorem closure",
        "CLAIM_NOW_SAFE := unrestricted theorem closure",
        "bounded_recursive_theorem_family_closure implies unrestricted theorem closure",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 1%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 10%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 20%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 50%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 88%",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 100%",
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
    assert "BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE_BOUNDARY_OK" in result.stdout
