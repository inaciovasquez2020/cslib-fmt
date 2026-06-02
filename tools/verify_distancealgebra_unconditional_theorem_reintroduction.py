#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distancealgebra_unconditional_theorem_reintroduction_2026_06_02.json")
DOC = Path("docs/status/DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_2026_06_02.md")
SRC = Path("FMT/Examples/DistanceAlgebra.lean")

data = json.loads(ART.read_text())
src = SRC.read_text()

required_source_fragments = [
    "import FMT.Inputs.SLASH_Axioms",
    "theorem lineGraph_path_ba",
    "theorem lineGraph_path_cb",
    "theorem lineGraph_path_ac_two",
    "theorem lineGraph_path_ca_two",
    "instance lineGraph_slashAxioms : FMT.Inputs.SLASHAxioms lineGraph",
    "theorem lineGraph_dist_ab_le_one",
    "theorem lineGraph_dist_ba_le_one",
    "theorem lineGraph_dist_ab_ba_symmetry",
    "theorem lineGraph_dist_ac_le_two",
    "FMT.Graph.dist?_le_of_path",
    "FMT.Graph.distLE_of_eq",
]

for frag in required_source_fragments:
    assert frag in src, frag

assert data["object"] == "DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION"
assert data["status"] == "UNCONDITIONAL_THEOREM_REINTRODUCTION_PATCH_BUILDS"
assert data["input_pr"] == 150
assert data["input_commit"] == "9678e8a"
assert data["dependency_axiom_discharge"]["class"] == "FMT.Inputs.SLASHAxioms"
assert data["dependency_axiom_discharge"]["instance"] == "lineGraph_slashAxioms"
assert data["dependency_axiom_discharge"]["unconditional"] is True
assert data["distance_theorem_reintroduction"]["lineGraph_dist_ab_ba_symmetry"] is True
assert data["distance_theorem_reintroduction"]["lineGraph_dist_ac_le_two"] is True
assert data["next_admissible_object"] == "DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_REPO_PR"
assert DOC.exists()

print("DISTANCEALGEBRA_UNCONDITIONAL_THEOREM_REINTRODUCTION_OK")
print(json.dumps(data, indent=2, sort_keys=True))
