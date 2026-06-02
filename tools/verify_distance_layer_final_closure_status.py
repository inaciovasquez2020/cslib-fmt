#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/distance_layer_final_closure_status_2026_06_02.json")

REQUIRED = [
    Path("FMT/Graph/GlobalDistanceAxiomDischarge.lean"),
    Path("FMT/Graph/UndirectedGraphDistanceSymmetryAPI.lean"),
    Path("tools/verify_global_distance_axiom_discharge.py"),
    Path("tools/verify_undirected_graph_distance_symmetry_api.py"),
]

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))

    assert data["object"] == "DISTANCE_LAYER_FINAL_CLOSURE_STATUS"
    assert data["status"] == "DISTANCE_LAYER_FINAL_STATUS_REGISTERED"
    assert data["theorem_boundary"] == "GLOBAL_TRIANGLE_CLOSED_UNDIRECTED_SYMMETRY_API_CLOSED_DIRECTED_SYMMETRY_NOT_CLOSED"

    closed = set(data["closed_objects"])
    assert "GlobalSLASHAxiomsDischarge" in closed
    assert "GlobalDistanceTriangleTheoremUnconditionalOnSLASH" in closed
    assert "DistanceSymmetryForUndirectedGraphClass" in closed

    boundary = " ".join(data["boundary"])
    assert "SLASHAxioms discharged globally" in boundary
    assert "distance symmetry available for explicit UndirectedGraph class" in boundary
    assert "arbitrary directed graph distance symmetry is not claimed" in boundary
    assert "underlying Graph structure remains directed" in boundary

    for path in REQUIRED:
        assert path.exists(), f"missing required file: {path}"

    assert data["next_admissible_object"] == "STOP"

    print("DISTANCE_LAYER_FINAL_CLOSURE_STATUS_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
