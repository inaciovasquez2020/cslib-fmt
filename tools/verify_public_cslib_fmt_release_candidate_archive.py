#!/usr/bin/env python3
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts/cslib-fmt/public_cslib_fmt_release_candidate_archive_2026_06_02.json"
DOC = ROOT / "docs/status/PUBLIC_CSLIB_FMT_RELEASE_CANDIDATE_ARCHIVE_2026_06_02.md"
READINESS = ROOT / "artifacts/cslib-fmt/public_cslib_fmt_release_readiness_2026_06_02.json"

EXPECTED_STATUS = "PUBLIC_CSLIB_FMT_RELEASE_CANDIDATE_ARCHIVED"
EXPECTED_NEXT = "StopOrCreateTaggedPublicRelease"
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
    assert READINESS.exists(), f"missing readiness artifact: {READINESS}"

    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    readiness = json.loads(READINESS.read_text(encoding="utf-8"))
    doc = DOC.read_text(encoding="utf-8")

    head = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip()

    assert data["status"] == EXPECTED_STATUS
    assert data["repository"] == "cslib-fmt"
    assert data["archived_object"] == "CreatePublicCslibFmtReleaseOrArchiveReleaseCandidate"
    assert data["release_readiness_artifact"] == "artifacts/cslib-fmt/public_cslib_fmt_release_readiness_2026_06_02.json"
    assert data["next_admissible_object"] == EXPECTED_NEXT
    assert set(data["included_closed_objects"]) == EXPECTED_OBJECTS
    assert set(data["release_boundary"]) == EXPECTED_BOUNDARY
    assert readiness["status"] == "PUBLIC_CSLIB_FMT_RELEASE_PREPARED"
    assert data["base_main_commit"] == head or len(data["base_main_commit"]) == 40

    for token in [
        EXPECTED_STATUS,
        "CreatePublicCslibFmtReleaseOrArchiveReleaseCandidate",
        EXPECTED_NEXT,
        "finite graph diameter public convenience surface",
        "no infinite graph claim",
        "no weighted graph claim",
        "no full graph theory completion claim",
        "no cross-repository theorem claim",
    ]:
        assert token in doc, f"missing doc token: {token}"

    print("PUBLIC_CSLIB_FMT_RELEASE_CANDIDATE_ARCHIVE_OK")
    print(json.dumps({
        "status": data["status"],
        "closed_object_count": len(data["included_closed_objects"]),
        "boundary_count": len(data["release_boundary"]),
        "next_admissible_object": data["next_admissible_object"],
    }, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
