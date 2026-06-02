import json
import subprocess
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_axiom_discharge_2026_06_02.json")
LEAN = Path("FMT/Graph/GlobalDistanceAxiomDischarge.lean")
VERIFY = Path("tools/verify_global_distance_axiom_discharge.py")

def test_axiom_discharge_artifact():
    data = json.loads(ART.read_text(encoding="utf-8"))
    assert data["object"] == "GLOBAL_DISTANCE_AXIOM_DISCHARGE"
    assert data["status"] == "SLASH_AXIOM_DISCHARGED_ADJACENCY_SYMMETRY_REMAINS_EXPLICIT"

def test_global_slash_instance_present():
    text = LEAN.read_text(encoding="utf-8")
    assert "instance globalSLASHAxioms" in text
    assert "exists_min_pathLength" in text

def test_boundary_keeps_symmetry_hypothesis():
    data = json.loads(ART.read_text(encoding="utf-8"))
    boundary = " ".join(data["boundary"])
    assert "global symmetry still requires SymmAdj" in boundary
    assert "does not prove every graph is undirected" in boundary

def test_verifier_passes():
    result = subprocess.run(["python3", str(VERIFY)], text=True, capture_output=True, check=True)
    assert "GLOBAL_DISTANCE_AXIOM_DISCHARGE_OK" in result.stdout
