import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/undirected_graph_distance_symmetry_api_2026_06_02.json")
LEAN = Path("FMT/Graph/UndirectedGraphDistanceSymmetryAPI.lean")
VERIFY = Path("tools/verify_undirected_graph_distance_symmetry_api.py")

def test_api_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "UNDIRECTED_GRAPH_CLASS_DISTANCE_SYMMETRY_API"
    assert data["status"] == "UNDIRECTED_GRAPH_DISTANCE_SYMMETRY_API_ADDED"

def test_lean_api_present():
    text = LEAN.read_text(encoding="utf-8")
    assert "class UndirectedGraph" in text
    assert "theorem global_dist?_symmetry_from_UndirectedGraph" in text

def test_boundary_keeps_directed_graph_limit():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "does not prove every graph is undirected" in boundary
    assert "does not prove distance symmetry for arbitrary directed graphs" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "UNDIRECTED_GRAPH_DISTANCE_SYMMETRY_API_OK" in result.stdout
