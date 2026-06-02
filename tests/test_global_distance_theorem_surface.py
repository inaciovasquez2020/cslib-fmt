import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_theorem_surface_2026_06_02.json")
VERIFY = Path("tools/verify_global_distance_theorem_surface.py")

def test_global_distance_surface_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "GLOBAL_DISTANCE_THEOREM_SURFACE"
    assert data["status"] == "TARGET_SURFACE_ONLY_GLOBAL_THEOREMS_NOT_PROVED"

def test_missing_objects_record_global_theorem_gap():
    data = json.loads(ART.read_text(encoding="utf-8"))
    missing = set(data["missing_objects"])
    assert "GlobalDistanceSymmetryTheorem" in missing
    assert "GlobalDistanceTriangleTheorem" in missing

def test_boundary_blocks_line3_overpromotion():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "does not promote the concrete Line3 DistanceAlgebra theorem to all graphs" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "GLOBAL_DISTANCE_THEOREM_SURFACE_OK" in result.stdout
