import json
import subprocess
from pathlib import Path

def test_distancealgebra_dependency_axiom_output_classification_artifact():
    data = json.loads(Path("artifacts/cslib-fmt/distancealgebra_dependency_axiom_output_classification_2026_06_02.json").read_text())
    assert data["status"] == "CLASSIFICATION_SURFACE_RECORDED"
    assert data["classification"]["DistanceAlgebra"]["reintroduced_distance_theorems"] is False
    assert data["classification"]["DistanceAlgebra"]["new_dependency_axioms_discharged"] is False

def test_distancealgebra_dependency_axiom_output_classification_verifier():
    result = subprocess.run(
        ["python3", "tools/verify_distancealgebra_dependency_axiom_output_classification.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "DISTANCEALGEBRA_DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION_OK" in result.stdout
