import json
import subprocess
from pathlib import Path

def test_distancealgebra_distance_theorem_reintroduction_surface_artifact():
    data = json.loads(Path("artifacts/cslib-fmt/distancealgebra_distance_theorem_reintroduction_surface_2026_06_02.json").read_text())
    assert data["status"] == "TARGET_SURFACE_RECORDED_NO_THEOREM_REINTRODUCED"
    assert data["selected_branch"] == "DISTANCE_THEOREM_REINTRODUCTION_SURFACE"
    assert data["target_reintroduction_surface"]["chosen_now"] == "record target only"
    assert data["current_build_surface"]["distance_symmetry_example_reintroduced"] is False
    assert data["current_build_surface"]["distance_triangle_example_reintroduced"] is False

def test_distancealgebra_distance_theorem_reintroduction_surface_verifier():
    result = subprocess.run(
        ["python3", "tools/verify_distancealgebra_distance_theorem_reintroduction_surface.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert "DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE_OK" in result.stdout
