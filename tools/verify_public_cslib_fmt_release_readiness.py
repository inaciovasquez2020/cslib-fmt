#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts/cslib-fmt/public_cslib_fmt_release_readiness_2026_06_02.json"
DOC = ROOT / "docs/status/PUBLIC_CSLIB_FMT_RELEASE_READINESS_2026_06_02.md"

EXPECTED_STATUS = "PUBLIC_CSLIB_FMT_RELEASE_PREPARED"
EXPECTED_NEXT = "CreatePublicCslibFmtReleaseOrArchiveReleaseCandidate"
EXPECTED_OBJECTS = {
    "finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable",
    "finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable",
    "finiteGraphDiameter_none_of_not_allPairDistancesReachable'",
    "finiteGraphDiameter_some_iff_allPairDistancesReachable",
    "finiteGraphDiameter_closed_option_nat_cases",
}
EXPECTED_BOUNDARY = {
    "finite graph diameter Option Nat layer only",
    "finite graphs only",
    "unweighted graph distance surface only",
    "no infinite graph claim",
    "no weighted graph claim",
    "no full graph theory completion claim",
    "no cross-repository theorem claim",
}

def main() -> None:
    assert ARTIFACT.exists(), f"missing artifact: {ARTIFACT}"
    assert DOC.exists(), f"missing doc: {DOC}"

    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    doc = DOC.read_text(encoding="utf-8")

    assert data["status"] == EXPECTED_STATUS
    assert data["repository"] == "cslib-fmt"
    assert data["prepared_object"] == "PreparePublicCslibFmtRelease"
    assert data["release_scope"] == "finite graph diameter public convenience surface"
    assert data["next_admissible_object"] == EXPECTED_NEXT
    assert set(data["included_closed_objects"]) == EXPECTED_OBJECTS
    assert set(data["required_public_boundary"]) == EXPECTED_BOUNDARY

    required_doc_tokens = [
        EXPECTED_STATUS,
        "PreparePublicCslibFmtRelease",
        EXPECTED_NEXT,
        "finite graph diameter public convenience surface",
        "no infinite graph claim",
        "no weighted graph claim",
        "no full graph theory completion claim",
        "no cross-repository theorem claim",
    ]
    for token in required_doc_tokens:
        assert token in doc, f"missing doc token: {token}"

    print("PUBLIC_CSLIB_FMT_RELEASE_READINESS_OK")
    print(json.dumps({
        "status": data["status"],
        "closed_object_count": len(data["included_closed_objects"]),
        "boundary_count": len(data["required_public_boundary"]),
        "next_admissible_object": data["next_admissible_object"],
    }, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
