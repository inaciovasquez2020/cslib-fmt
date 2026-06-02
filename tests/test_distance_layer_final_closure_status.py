import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distance_layer_final_closure_status_2026_06_02.json")
VERIFY = Path("tools/verify_distance_layer_final_closure_status.py")

def test_final_status_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "DISTANCE_LAYER_FINAL_CLOSURE_STATUS"
    assert data["status"] == "DISTANCE_LAYER_FINAL_STATUS_REGISTERED"

def test_closed_objects_recorded():
    data = json.loads(ART.read_text(encoding="utf-8"))
    closed = set(data["closed_objects"])
    assert "GlobalDistanceTriangleTheoremUnconditionalOnSLASH" in closed
    assert "DistanceSymmetryForUndirectedGraphClass" in closed

def test_directed_boundary_remains():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "arbitrary directed graph distance symmetry is not claimed" in boundary
    assert "underlying Graph structure remains directed" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "DISTANCE_LAYER_FINAL_CLOSURE_STATUS_OK" in result.stdout
