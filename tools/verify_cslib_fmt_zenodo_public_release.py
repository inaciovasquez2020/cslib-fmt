#!/usr/bin/env python3
import json
from pathlib import Path

artifact_path = Path("artifacts/cslib-fmt/cslib_fmt_zenodo_public_release_2026_06_02.json")
doc_path = Path("docs/status/CSLIB_FMT_ZENODO_PUBLIC_RELEASE_2026_06_02.md")

artifact = json.loads(artifact_path.read_text(encoding="utf-8"))
doc = doc_path.read_text(encoding="utf-8")

assert artifact["artifact"] == "CSLIB_FMT_ZENODO_PUBLIC_RELEASE_2026_06_02"
assert artifact["repository"] == "inaciovasquez2020/cslib-fmt"
assert artifact["github_release_tag"] == "public-cslib-fmt-finite-graph-diameter-2026-06-02"
assert artifact["github_release_url"] == "https://github.com/inaciovasquez2020/cslib-fmt/releases/tag/public-cslib-fmt-finite-graph-diameter-2026-06-02"
assert artifact["zenodo"]["deposition_id"] == 20518144
assert artifact["zenodo"]["doi"] == "10.5281/zenodo.20518144"
assert artifact["zenodo"]["conceptdoi"] == "10.5281/zenodo.20518143"
assert artifact["zenodo"]["record_url"] == "https://zenodo.org/records/20518144"
assert artifact["status"] == "CSLIB_FMT_ZENODO_PUBLIC_RELEASE_PUBLISHED"
assert artifact["next_admissible_object"] == "Stop"

required_doc_tokens = [
    "CSLIB_FMT_ZENODO_PUBLIC_RELEASE_PUBLISHED",
    "20518144",
    "10.5281/zenodo.20518144",
    "10.5281/zenodo.20518143",
    "https://zenodo.org/records/20518144",
    "public-cslib-fmt-finite-graph-diameter-2026-06-02",
    "No infinite graph claim",
    "No weighted graph claim",
    "No full graph theory completion claim",
    "No cross-repository theorem closure claim",
    "Stop",
]

for token in required_doc_tokens:
    assert token in doc, token

print("CSLIB_FMT_ZENODO_PUBLIC_RELEASE_RECORD_OK")
print(json.dumps({
    "status": artifact["status"],
    "repository": artifact["repository"],
    "doi": artifact["zenodo"]["doi"],
    "conceptdoi": artifact["zenodo"]["conceptdoi"],
    "record_url": artifact["zenodo"]["record_url"],
    "closed_object_count": len(artifact["closed_objects"]),
    "boundary_count": len(artifact["boundary"]),
    "next_admissible_object": artifact["next_admissible_object"]
}, indent=2, sort_keys=True))
