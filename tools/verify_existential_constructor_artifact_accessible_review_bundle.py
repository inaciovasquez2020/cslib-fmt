from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_artifact_accessible_review_bundle_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_named_edge_no_placeholder_check_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_ACCESSIBLE_REVIEW_BUNDLE.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_ACCESSIBLE_REVIEW_BUNDLE_ONLY"
OBJECT = "existential_constructor_artifact_accessible_review_bundle"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_NAMED_EDGE_NO_PLACEHOLDER_CHECK_ONLY"
SOURCE_COMMIT = "fc8fc99"
TARGET_COMMIT = "cc60f9a"
NEXT = "artifact_verified_independent_review_response"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "artifact_accessible_independent_review"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["bundle_type"] == "public_gist"
    assert payload["bundle_url"].startswith("https://gist.github.com/")
    assert payload["claim"] == "artifact_accessible_review_bundle_only"
    assert payload["weakest_next_boundary"] == NEXT

    included = payload["included_artifacts"]
    assert "LEAN_NAMED_EDGE_EXCERPT.lean" in included
    assert "existential_constructor_actual_downstream_theorem_use_status_2026_06_22.json" in included
    assert "existential_constructor_named_edge_no_placeholder_check_2026_06_22.json" in included
    assert "verify_existential_constructor_named_edge_no_placeholder_check.py" in included
    assert "test_existential_constructor_named_edge_no_placeholder_check.py" in included

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "reviewer_response" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "artifact_verified_by_reviewer" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert "BUNDLE_TYPE := public_gist" in doc
    assert "BUNDLE_URL := https://gist.github.com/" in doc
    assert "CLAIM := artifact_accessible_review_bundle_only" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim external acceptance" in doc
    assert "artifact verification by reviewer" in doc

    print("EXISTENTIAL_CONSTRUCTOR_ARTIFACT_ACCESSIBLE_REVIEW_BUNDLE_OK")


if __name__ == "__main__":
    main()
