#!/usr/bin/env python3
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1]
artifacts = sorted((root / "artifacts" / "cslib-fmt").glob("flagship_finite_graph_diameter_closure_v1_*.json"))
docs = sorted((root / "docs" / "status").glob("FLAGSHIP_FINITE_GRAPH_DIAMETER_CLOSURE_V1_*.md"))

assert artifacts, "missing flagship closure artifact"
assert docs, "missing flagship closure status document"

artifact = artifacts[-1]
doc = docs[-1]

data = json.loads(artifact.read_text(encoding="utf-8"))
text = doc.read_text(encoding="utf-8")

assert data["schema"] == "cslib_fmt_flagship_closure_v1"
assert data["repository"] == "inaciovasquez2020/cslib-fmt"
assert data["flagship_object"] == "finite_graph_diameter_public_release"
assert data["status"] == "FLAGSHIP_CLOSURE_PACKET_RECORDED"
assert data["claim_level"] == "bounded_unconditional_repository_result"

closed = data["closed_public_result"]
assert closed["lean_module"] == "FMT.Graph.FiniteGraphDiameter"
assert closed["release_tag"] == "public-cslib-fmt-finite-graph-diameter-2026-06-02"
assert closed["zenodo_doi"] == "10.5281/zenodo.20518144"
assert closed["zenodo_concept_doi"] == "10.5281/zenodo.20518143"
assert closed["zenodo_record_url"] == "https://zenodo.org/records/20518144"

required = data["required_closure_components"]
for key, value in required.items():
    assert value is True, f"required closure component not true: {key}"

for forbidden in [
    "P vs NP",
    "Clay problem",
    "unrestricted Chronos-RR",
    "unrestricted H4.1/FGL",
    "new physics",
    "all URF frontiers",
]:
    assert any(forbidden in boundary for boundary in data["non_claim_boundaries"]), forbidden

for required_text in [
    "FLAGSHIP_CLOSURE_PACKET_RECORDED",
    "FMT.Graph.FiniteGraphDiameter",
    "10.5281/zenodo.20518144",
    "public-cslib-fmt-finite-graph-diameter-2026-06-02",
    "one bounded public flagship result only",
]:
    assert required_text in text, required_text

print("FLAGSHIP_FINITE_GRAPH_DIAMETER_CLOSURE_V1_OK")
print(json.dumps({
    "artifact": str(artifact.relative_to(root)),
    "status_doc": str(doc.relative_to(root)),
    "status": data["status"],
    "flagship_object": data["flagship_object"],
    "doi": closed["zenodo_doi"],
}, indent=2, sort_keys=True))
