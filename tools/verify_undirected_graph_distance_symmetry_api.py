#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/undirected_graph_distance_symmetry_api_2026_06_02.json")
LEAN = Path("FMT/Graph/UndirectedGraphDistanceSymmetryAPI.lean")
ROOT = Path("FMT/Graph.lean")

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))
    lean = LEAN.read_text(encoding="utf-8")
    root = ROOT.read_text(encoding="utf-8")

    assert data["object"] == "UNDIRECTED_GRAPH_CLASS_DISTANCE_SYMMETRY_API"
    assert data["status"] == "UNDIRECTED_GRAPH_DISTANCE_SYMMETRY_API_ADDED"
    assert data["input_object"] == "GLOBAL_DISTANCE_AXIOM_DISCHARGE"

    assert "class UndirectedGraph" in lean
    assert "symmAdj : SymmAdj G" in lean
    assert "theorem symmAdj_of_undirectedGraph" in lean
    assert "theorem global_dist?_symmetry_from_UndirectedGraph" in lean
    assert "exact global_dist?_symmetry_from_SymmAdj" in lean
    assert "import FMT.Graph.UndirectedGraphDistanceSymmetryAPI" in root

    boundary = " ".join(data["boundary"])
    assert "API layer only" in boundary
    assert "does not prove every graph is undirected" in boundary
    assert "does not prove distance symmetry for arbitrary directed graphs" in boundary

    closed = set(data["closed_objects"])
    assert "UndirectedGraphClass" in closed
    assert "SymmAdjProjectionFromUndirectedGraph" in closed
    assert "DistanceSymmetryForUndirectedGraphClass" in closed

    assert data["next_admissible_object"] == "STOP_OR_REGISTER_DISTANCE_LAYER_FINAL_CLOSURE_STATUS"

    print("UNDIRECTED_GRAPH_DISTANCE_SYMMETRY_API_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
