#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distancealgebra_distance_theorem_reintroduction_surface_2026_06_02.json")
DOC = Path("docs/status/DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE_2026_06_02.md")
SRC = Path("FMT/Examples/DistanceAlgebra.lean")

data = json.loads(ART.read_text())
src = SRC.read_text()

assert data["object"] == "DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE_OR_DEPENDENCY_AXIOM_DISCHARGE"
assert data["selected_branch"] == "DISTANCE_THEOREM_REINTRODUCTION_SURFACE"
assert data["status"] == "TARGET_SURFACE_RECORDED_NO_THEOREM_REINTRODUCED"
assert data["input_pr"] == 149
assert data["input_commit"] == "8451e64"
assert "theorem lineGraph_symm" in src
assert "theorem lineGraph_path_ab" in src
assert "theorem lineGraph_path_bc" in src
assert data["current_build_surface"]["distance_symmetry_example_reintroduced"] is False
assert data["current_build_surface"]["distance_triangle_example_reintroduced"] is False
assert data["target_reintroduction_surface"]["chosen_now"] == "record target only"
assert data["next_admissible_object"] == "DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_PATCH_OR_EXPLICIT_DEPENDENCY_AXIOM_DISCHARGE"
assert DOC.exists()

print("DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE_OK")
print(json.dumps(data, indent=2, sort_keys=True))
