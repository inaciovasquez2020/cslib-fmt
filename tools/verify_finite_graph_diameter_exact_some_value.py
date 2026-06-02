#!/usr/bin/env python3
import json
from pathlib import Path

ARTIFACT = Path("artifacts/cslib-fmt/finite_graph_diameter_exact_some_value_2026_06_02.json")
LEAN = Path("FMT/Graph/FiniteGraphDiameter.lean")
DOC = Path("docs/status/FINITE_GRAPH_DIAMETER_EXACT_SOME_VALUE_2026_06_02.md")

def read(path: Path) -> str:
    if not path.exists():
        raise AssertionError(f"missing file: {path}")
    return path.read_text(encoding="utf-8")

def main() -> None:
    data = json.loads(read(ARTIFACT))
    lean = read(LEAN)
    doc = read(DOC)

    if data["status"] != "TARGET_IMPLEMENTED_PENDING_VERIFICATION":
        raise AssertionError("bad status")

    token = "finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable"

    if token not in data["implemented_objects"]:
        raise AssertionError("artifact missing theorem token")

    if f"theorem {token}" not in lean:
        raise AssertionError("Lean file missing theorem declaration")

    if "finiteGraphDiameter? G = some (natListMax (pairDistanceValues G).toList)" not in lean:
        raise AssertionError("Lean file missing exact some value conclusion")

    for boundary in [
        "directed distance symmetry",
        "new connectedness closure",
        "any change to Graph",
        "new diameter computation algorithm",
    ]:
        if boundary not in doc and boundary not in json.dumps(data):
            raise AssertionError(f"missing boundary: {boundary}")

    print("FINITE_GRAPH_DIAMETER_EXACT_SOME_VALUE_OK")
    print(json.dumps({
        "artifact": str(ARTIFACT),
        "lean": str(LEAN),
        "doc": str(DOC),
        "status": data["status"],
        "next_admissible_object": data["next_admissible_object"],
    }, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
