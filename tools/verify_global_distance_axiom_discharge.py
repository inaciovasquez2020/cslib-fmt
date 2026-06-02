#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_axiom_discharge_2026_06_02.json")
LEAN = Path("FMT/Graph/GlobalDistanceAxiomDischarge.lean")
ROOT = Path("FMT/Graph.lean")

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))
    lean = LEAN.read_text(encoding="utf-8")
    root = ROOT.read_text(encoding="utf-8")

    assert data["object"] == "GLOBAL_DISTANCE_AXIOM_DISCHARGE"
    assert data["status"] == "SLASH_AXIOM_DISCHARGED_ADJACENCY_SYMMETRY_REMAINS_EXPLICIT"
    assert data["input_object"] == "GLOBAL_DISTANCE_THEOREM_PATCH"

    assert "instance globalSLASHAxioms" in lean
    assert "exact FMT.Graph.exists_min_pathLength G u v h" in lean
    assert "theorem global_dist?_symmetry_from_SymmAdj" in lean
    assert "theorem global_dist?_triangle_unconditional" in lean
    assert "import FMT.Graph.GlobalDistanceAxiomDischarge" in root

    boundary = " ".join(data["boundary"])
    assert "SLASHAxioms is discharged globally" in boundary
    assert "global symmetry still requires SymmAdj" in boundary
    assert "does not prove every graph is undirected" in boundary

    closed = set(data["closed_objects"])
    assert "GlobalSLASHAxiomsDischarge" in closed
    assert "GlobalDistanceTriangleTheoremUnconditionalOnSLASH" in closed
    assert "GlobalDistanceSymmetryTheoremConditionalOnlyOnSymmAdj" in closed

    assert data["next_admissible_object"] == "STOP_OR_UNDIRECTED_GRAPH_CLASS_DISTANCE_SYMMETRY_API"

    print("GLOBAL_DISTANCE_AXIOM_DISCHARGE_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
