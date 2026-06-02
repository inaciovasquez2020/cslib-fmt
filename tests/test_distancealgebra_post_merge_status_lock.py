import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distancealgebra_post_merge_status_lock_2026_06_02.json")
VERIFY = Path("tools/verify_distancealgebra_post_merge_status_lock.py")

def test_post_merge_status_lock_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "DISTANCEALGEBRA_POST_MERGE_STATUS_LOCK"
    assert data["status"] == "POST_MERGE_VERIFIED_STOP_POINT"
    assert data["input_pr"] == 151
    assert data["mathematical_decision"] == "DISTANCEALGEBRA_CONCRETE_EXAMPLE_THEOREM_REINTRODUCTION_COMPLETE"

def test_closed_objects_are_recorded():
    data = json.loads(ART.read_text(encoding="utf-8"))
    closed = set(data["closed_objects"])
    assert {"lineGraph_slashAxioms", "lineGraph_dist_ab_ba_symmetry", "lineGraph_dist_ac_le_two"} <= closed

def test_boundary_blocks_global_overclaim():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "no global distance symmetry theorem" in boundary
    assert "no global distance triangle theorem" in boundary
    assert "no broader FMT theorem promotion" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "DISTANCEALGEBRA_POST_MERGE_STATUS_LOCK_OK" in result.stdout
