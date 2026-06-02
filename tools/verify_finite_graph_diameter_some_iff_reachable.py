#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/cslib-fmt/finite_graph_diameter_some_iff_reachable_2026_06_02.json")
lean = Path("FMT/Graph/FiniteGraphDiameter.lean")
doc = Path("docs/status/FINITE_GRAPH_DIAMETER_SOME_IFF_REACHABLE_2026_06_02.md")

for p in [artifact, lean, doc]:
    if not p.exists():
        raise SystemExit(f"missing required file: {p}")

data = json.loads(artifact.read_text())
if data.get("status") != "TARGET_IMPLEMENTED_PENDING_VERIFICATION":
    raise SystemExit(f"bad status: {data.get('status')}")

required = [
    "finiteGraphDiameter_exists_of_allPairDistancesReachable",
    "finiteGraphDiameter_exists_iff_allPairDistancesReachable",
]

lean_text = lean.read_text()
for token in required:
    if token not in data.get("implemented_objects", []):
        raise SystemExit(f"artifact missing theorem token: {token}")
    if f"theorem {token}" not in lean_text:
        raise SystemExit(f"Lean file missing theorem declaration: {token}")

if "(∃ d : Nat, finiteGraphDiameter? G = some d) ↔ allPairDistancesReachable G" not in lean_text:
    raise SystemExit("Lean file missing iff statement")

doc_text = doc.read_text()
for boundary in [
    "directed distance symmetry",
    "new connectedness closure",
    "any change to Graph",
    "new diameter computation algorithm",
]:
    if boundary not in doc_text and boundary not in json.dumps(data):
        raise SystemExit(f"missing boundary: {boundary}")

print("FINITE_GRAPH_DIAMETER_SOME_IFF_REACHABLE_OK")
print(json.dumps({
    "artifact": str(artifact),
    "lean": str(lean),
    "doc": str(doc),
    "status": data["status"],
    "next_admissible_object": data["next_admissible_object"],
}, indent=2, sort_keys=True))
