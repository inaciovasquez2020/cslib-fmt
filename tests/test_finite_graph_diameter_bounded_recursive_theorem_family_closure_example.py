from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs/status/FINITE_GRAPH_DIAMETER_BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE_EXAMPLE.md"
VERIFIER = ROOT / "scripts/verify_finite_graph_diameter_bounded_recursive_theorem_family_closure_example.py"


def test_finite_graph_diameter_bounded_recursive_theorem_family_closure_example() -> None:
    text = DOC.read_text(encoding="utf-8")

    required = [
        "STATUS := CONCRETE_BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE_EXAMPLE",
        "FAMILY_NAME := finite_graph_diameter_bounded_recursive_family",
        "MEMBERSHIP_RULE :=",
        "STOPPING_CONDITION :=",
        "POSITIVE_CLOSURE_CRITERION :=",
        "FORBIDDEN_PROMOTION := finite_graph_diameter_bounded_recursive_family closure does not imply unrestricted theorem closure.",
        "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%",
        "BOUNDARY := ¬ unrestricted_theorem_closure",
        "finite_graph_diameter_option_nat_definition",
        "finite_graph_diameter_none_theorem",
        "finite_graph_diameter_some_iff_reachable",
        "finite_graph_diameter_exact_some_value",
        "finite_graph_diameter_final_convenience_layer",
        "tests/test_finite_graph_diameter_option_nat_definition.py",
        "tests/test_finite_graph_diameter_none_theorem.py",
        "tests/test_finite_graph_diameter_some_iff_reachable.py",
        "tests/test_finite_graph_diameter_exact_some_value.py",
        "tests/test_finite_graph_diameter_final_convenience_layer.py",
    ]

    forbidden = [
        "STATUS := unrestricted theorem closure",
        "CLAIM_NOW_SAFE := unrestricted theorem closure",
        "finite_graph_diameter_bounded_recursive_family closure implies unrestricted theorem closure",
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
    assert "FINITE_GRAPH_DIAMETER_BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE_EXAMPLE_OK" in result.stdout
