#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs/status/CSLIB_FMT_BOUNDED_FRONTIER_SYNC_2026_06_09.md"
ART = ROOT / "artifacts/status/cslib_fmt_bounded_frontier_sync_2026_06_09.json"

REQUIRED_OBJECTS = {
    "repository_native_bounded_status_certificate",
    "concreteAnalyticPackageNextBuildStopLockCertificate",
    "URF_TEXTBOOK_BOUNDED_STATUS_SYNC_2026_06_09",
    "DFM_MKC_BOUNDED_REPO_SYNC_2026_06_09",
}

REQUIRED_NONCLAIMS = {
    "final_finite_model_theory_theorem_closure",
    "H1_locality_theorem_closure",
    "H4_FGL_closure",
    "Chronos_RR_closure",
    "P_vs_NP",
    "Clay_problem_closure",
    "build_success_as_theorem_closure",
    "ci_success_as_theorem_closure",
    "examples_ledgers_placeholders_admits_or_sorry_as_theorem_closure",
}

def main() -> int:
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert data["status"] == "CSLIB_FMT_BOUNDED_FRONTIER_SYNC_ONLY"
    assert data["next_admissible_object"] == "Stop"

    objects = {entry["closed_object"] for entry in data["synced_objects"]}
    assert REQUIRED_OBJECTS <= objects

    nonclaims = set(data["claims_not_made"])
    assert REQUIRED_NONCLAIMS <= nonclaims

    assert "CSLIB_FMT_BOUNDED_FRONTIER_SYNC_ONLY" in doc
    assert "Lean 4 finite-model-theory infrastructure" in doc
    assert "Claims not made" in doc
    assert "P vs NP" in doc
    assert "any Clay-problem closure" in doc

    print("CSLIB_FMT_BOUNDED_FRONTIER_SYNC_OK")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
