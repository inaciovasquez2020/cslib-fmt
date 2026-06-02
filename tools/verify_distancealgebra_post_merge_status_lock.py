#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distancealgebra_post_merge_status_lock_2026_06_02.json")

REQUIRED_FILES = [
    Path("FMT/Examples/DistanceAlgebra.lean"),
    Path("artifacts/cslib-fmt/distancealgebra_unconditional_theorem_reintroduction_2026_06_02.json"),
    Path("docs/status/DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_2026_06_02.md"),
    Path("tests/test_distancealgebra_unconditional_theorem_reintroduction.py"),
    Path("tools/verify_distancealgebra_unconditional_theorem_reintroduction.py"),
]

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))

    assert data["object"] == "DISTANCEALGEBRA_POST_MERGE_STATUS_LOCK"
    assert data["status"] == "POST_MERGE_VERIFIED_STOP_POINT"
    assert data["input_pr"] == 151
    assert data["input_object"] == "DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION"

    closed = set(data["closed_objects"])
    assert "lineGraph_slashAxioms" in closed
    assert "lineGraph_dist_ab_ba_symmetry" in closed
    assert "lineGraph_dist_ac_le_two" in closed

    boundary = " ".join(data["boundary"])
    assert "concrete Line3" in boundary
    assert "no global distance symmetry theorem" in boundary
    assert "no global distance triangle theorem" in boundary
    assert "no broader FMT theorem promotion" in boundary

    for path in REQUIRED_FILES:
        assert path.exists(), f"missing required file: {path}"

    assert data["mathematical_decision"] == "DISTANCEALGEBRA_CONCRETE_EXAMPLE_THEOREM_REINTRODUCTION_COMPLETE"
    assert data["next_admissible_object"] == "STOP_OR_GLOBAL_DISTANCE_THEOREM_SURFACE"
    assert data["weakest_sufficient_next_input"] == "GeneralGraphDistanceSymmetryOrTriangleTheoremStatementWithRequiredAxioms"

    print("DISTANCEALGEBRA_POST_MERGE_STATUS_LOCK_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
