import json
import subprocess
from pathlib import Path

def test_distancealgebra_unconditional_theorem_reintroduction_artifact():
    data = json.loads(Path("artifacts/cslib-fmt/distancealgebra_unconditional_theorem_reintroduction_2026_06_02.json").read_text())
    assert data["status"] == "UNCONDITIONAL_THEOREM_REINTRODUCTION_PATCH_BUILDS"
    assert data["dependency_axiom_discharge"]["instance"] == "lineGraph_slashAxioms"
    assert data["dependency_axiom_discharge"]["unconditional"] is True
    assert data["distance_theorem_reintroduction"]["lineGraph_dist_ab_ba_symmetry"] is True
    assert data["distance_theorem_reintroduction"]["lineGraph_dist_ac_le_two"] is True

def test_distancealgebra_unconditional_theorem_reintroduction_source():
    src = Path("FMT/Examples/DistanceAlgebra.lean").read_text()
    assert "instance lineGraph_slashAxioms : FMT.Inputs.SLASHAxioms lineGraph" in src
    assert "theorem lineGraph_dist_ab_ba_symmetry" in src
    assert "theorem lineGraph_dist_ac_le_two" in src
    assert "FMT.Graph.dist?_le_of_path" in src
    assert "FMT.Graph.distLE_of_eq" in src

def test_distancealgebra_unconditional_theorem_reintroduction_verifier():
    result = subprocess.run(
        ["python3", "tools/verify_distancealgebra_unconditional_theorem_reintroduction.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_OK" in result.stdout
