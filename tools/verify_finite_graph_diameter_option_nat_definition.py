#!/usr/bin/env python3
import json
from pathlib import Path

artifact = Path("artifacts/cslib-fmt/finite_graph_diameter_option_nat_definition_2026_06_02.json")
lean = Path("FMT/Graph/FiniteGraphDiameter.lean")
doc = Path("docs/status/FINITE_GRAPH_DIAMETER_OPTION_NAT_DEFINITION_2026_06_02.md")

for p in [artifact, lean, doc]:
    if not p.exists():
        raise SystemExit(f"missing required file: {p}")

data = json.loads(artifact.read_text())

required_status = "TARGET_IMPLEMENTED_PENDING_VERIFICATION"
if data.get("status") != required_status:
    raise SystemExit(f"bad status: {data.get('status')}")

required_objects = {
    "ConnectedGraph",
    "allVertexPairs",
    "pairDistance?",
    "allPairDistancesReachable",
    "pairDistanceValues",
    "finiteGraphDiameter?",
    "connected_implies_all_pair_distances_reachable",
    "finite_connected_graph_diameter_exists",
    "distance_mem_pairDistanceValues",
    "distance_le_diameter_of_finite_connected",
}

implemented = set(data.get("implemented_objects", []))
missing = sorted(required_objects - implemented)
if missing:
    raise SystemExit(f"artifact missing objects: {missing}")

lean_text = lean.read_text()
for token in required_objects:
    if token not in lean_text:
        raise SystemExit(f"Lean file missing token: {token}")

doc_text = doc.read_text()
for forbidden in [
    "arbitrary directed graph distance symmetry",
    "every graph is undirected",
    "removal of SymmAdj for directed graphs",
    "underlying directed Graph structure",
]:
    if forbidden not in json.dumps(data) and forbidden not in doc_text:
        raise SystemExit(f"missing boundary: {forbidden}")

print("FINITE_GRAPH_DIAMETER_OPTION_NAT_DEFINITION_OK")
print(json.dumps({
    "artifact": str(artifact),
    "lean": str(lean),
    "doc": str(doc),
    "status": data["status"],
    "next_admissible_object": data["next_admissible_object"],
}, indent=2, sort_keys=True))
