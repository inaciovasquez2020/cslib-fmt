import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_theorem_patch_2026_06_02.json")
LEAN = Path("FMT/Graph/GlobalDistanceTheorems.lean")
VERIFY = Path("tools/verify_global_distance_theorem_patch.py")

def test_global_distance_patch_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "GLOBAL_DISTANCE_THEOREM_PATCH"
    assert data["status"] == "CONDITIONAL_GLOBAL_DISTANCE_THEOREM_WRAPPERS_ADDED"

def test_lean_wrappers_present():
    text = LEAN.read_text(encoding="utf-8")
    assert "theorem global_dist?_symmetry" in text
    assert "theorem global_dist?_triangle" in text

def test_boundary_remains_conditional():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "does not prove all graphs satisfy adjacency symmetry" in boundary
    assert "does not prove all graphs satisfy SLASHAxioms" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "GLOBAL_DISTANCE_THEOREM_PATCH_OK" in result.stdout
