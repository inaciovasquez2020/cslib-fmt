#!/usr/bin/env python3
import json
from pathlib import Path

root = Path.cwd()
lean = root / "FMT/Graph/FiniteGraphDiameter.lean"
artifact = root / "artifacts/cslib-fmt/finite_graph_diameter_final_convenience_layer_2026_06_02.json"
doc = root / "docs/status/FINITE_GRAPH_DIAMETER_FINAL_CONVENIENCE_LAYER_2026_06_02.md"

required = [
    "finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable",
    "finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable",
    "finiteGraphDiameter_none_of_not_allPairDistancesReachable'",
    "finiteGraphDiameter_some_iff_allPairDistancesReachable",
    "finiteGraphDiameter_closed_option_nat_cases",
]

for path in [lean, artifact, doc]:
    if not path.exists():
        raise SystemExit(f"missing required file: {path}")

text = lean.read_text(encoding="utf-8")
for name in required:
    if name not in text:
        raise SystemExit(f"missing theorem name in Lean file: {name}")

data = json.loads(artifact.read_text(encoding="utf-8"))
if data.get("status") != "FINITE_GRAPH_DIAMETER_OPTION_NAT_LAYER_PUBLIC_CONVENIENCE_CLOSED":
    raise SystemExit("bad status")
if data.get("next_admissible_object") != "PreparePublicCslibFmtRelease":
    raise SystemExit("bad next admissible object")
for name in required:
    if name not in data.get("closed_objects", []):
        raise SystemExit(f"missing closed object in artifact: {name}")

doc_text = doc.read_text(encoding="utf-8")
for name in required:
    if name not in doc_text:
        raise SystemExit(f"missing closed object in doc: {name}")

print("FINITE_GRAPH_DIAMETER_FINAL_CONVENIENCE_LAYER_OK")
print(json.dumps({
    "status": data["status"],
    "closed_objects": data["closed_objects"],
    "next_admissible_object": data["next_admissible_object"],
}, indent=2, sort_keys=True))
