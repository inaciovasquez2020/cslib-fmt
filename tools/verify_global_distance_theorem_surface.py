#!/usr/bin/env python3
import json
from pathlib import Path

ART = Path("artifacts/cslib-fmt/global_distance_theorem_surface_2026_06_02.json")

def main() -> None:
    data = json.loads(ART.read_text(encoding="utf-8"))

    assert data["object"] == "GLOBAL_DISTANCE_THEOREM_SURFACE"
    assert data["status"] == "TARGET_SURFACE_ONLY_GLOBAL_THEOREMS_NOT_PROVED"
    assert data["input_object"] == "DISTANCEALGEBRA_POST_MERGE_STATUS_LOCK"

    missing = set(data["missing_objects"])
    assert "GlobalShortestPathExistenceOrDistanceTotality" in missing
    assert "GlobalPathReversalClosure" in missing
    assert "GlobalPathConcatenationClosure" in missing
    assert "GlobalDistanceSymmetryTheorem" in missing
    assert "GlobalDistanceTriangleTheorem" in missing

    boundary = " ".join(data["boundary"])
    assert "target surface only" in boundary
    assert "does not prove global distance symmetry" in boundary
    assert "does not prove global triangle inequality" in boundary
    assert "does not promote the concrete Line3 DistanceAlgebra theorem to all graphs" in boundary

    assert data["next_admissible_object"] == "GLOBAL_DISTANCE_SYMMETRY_OR_TRIANGLE_THEOREM_PATCH"
    assert data["weakest_sufficient_next_input"] == "GlobalShortestPathExistenceAndPathReversalConcatenationLemmas"

    print("GLOBAL_DISTANCE_THEOREM_SURFACE_OK")
    print(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
