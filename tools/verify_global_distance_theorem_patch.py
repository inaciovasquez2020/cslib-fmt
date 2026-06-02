#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_theorem_patch_2026_06_02.json")
LEAN = Path("FMT/Graph/GlobalDistanceTheorems.lean")
ROOT = Path("FMT/Graph.lean")

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))
    lean = LEAN.read_text(encoding="utf-8")
    root = ROOT.read_text(encoding="utf-8")

    assert data["object"] == "GLOBAL_DISTANCE_THEOREM_PATCH"
    assert data["status"] == "CONDITIONAL_GLOBAL_DISTANCE_THEOREM_WRAPPERS_ADDED"
    assert data["input_object"] == "GLOBAL_DISTANCE_THEOREM_SURFACE"

    assert "theorem global_dist?_symmetry" in lean
    assert "exact dist?_symm (G := G) hsymm u v" in lean
    assert "theorem global_dist?_triangle" in lean
    assert "exact dist?_triangle" in lean
    assert "import FMT.Graph.GlobalDistanceTheorems" in root

    boundary = " ".join(data["boundary"])
    assert "conditional on SLASHAxioms and an explicit adjacency-symmetry hypothesis" in boundary
    assert "conditional on SLASHAxioms shortest-path selection" in boundary
    assert "does not prove all graphs satisfy adjacency symmetry" in boundary
    assert "does not prove all graphs satisfy SLASHAxioms" in boundary

    assert data["next_admissible_object"] == "GLOBAL_DISTANCE_AXIOM_DISCHARGE_OR_STOP"
    print("GLOBAL_DISTANCE_THEOREM_PATCH_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
