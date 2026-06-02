#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distancealgebra_dependency_axiom_output_classification_2026_06_02.json")
DOC = Path("docs/status/DISTANCEALGEBRA_DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION_2026_06_02.md")

data = json.loads(ART.read_text())

assert data["object"] == "DISTANCEALGEBRA_DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION_OR_DISTANCE_THEOREM_REINTRODUCTION_SURFACE"
assert data["selected_branch"] == "DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION"
assert data["status"] == "CLASSIFICATION_SURFACE_RECORDED"
assert data["closed_pr"] == 148
assert data["closed_commit"] == "8a1b67f"
assert data["classification"]["DistanceAlgebra"]["reintroduced_distance_theorems"] is False
assert data["classification"]["DistanceAlgebra"]["new_dependency_axioms_discharged"] is False
assert data["next_admissible_object"] == "DISTANCEALGEBRA_DISTANCE_THEOREM_REINTRODUCTION_SURFACE_OR_DEPENDENCY_AXIOM_DISCHARGE"
assert DOC.exists()

print("DISTANCEALGEBRA_DEPENDENCY_AXIOM_OUTPUT_CLASSIFICATION_OK")
print(json.dumps(data, indent=2, sort_keys=True))
