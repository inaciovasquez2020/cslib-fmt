from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_independent_review_response_pending_status_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_external_review_message_sent_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_INDEPENDENT_REVIEW_RESPONSE_PENDING_STATUS.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_INDEPENDENT_REVIEW_RESPONSE_PENDING_STATUS_ONLY"
OBJECT = "existential_constructor_independent_review_response_pending_status"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_SENT_ONLY"
SOURCE_COMMIT = "ac04608"
NEXT = "independent_reviewer_response"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == NEXT

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["claim"] == "independent_reviewer_response_not_yet_observed"
    assert payload["observed_comment_count"] == 0
    assert payload["weakest_next_boundary"] == NEXT
    assert payload["review_issue_url"].startswith("https://github.com/inaciovasquez2020/cslib-fmt/issues/")

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "reviewer_response" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert "CLAIM := independent_reviewer_response_not_yet_observed" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim external acceptance" in doc

    print("EXISTENTIAL_CONSTRUCTOR_INDEPENDENT_REVIEW_RESPONSE_PENDING_STATUS_OK")


if __name__ == "__main__":
    main()
