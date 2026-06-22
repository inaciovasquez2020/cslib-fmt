from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_external_review_message_sent_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_external_review_message_draft_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_SENT.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_SENT_ONLY"
OBJECT = "existential_constructor_external_review_message_sent"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_DRAFT_ONLY"
SOURCE_COMMIT = "da3d0cb"
TARGET_COMMIT = "cc60f9a"
NEXT = "independent_reviewer_response"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["draft_only"] is True
    assert source["sent"] is False

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["channel_type"] == "github_issue"
    assert payload["channel"] == "inaciovasquez2020/cslib-fmt"
    assert payload["sent"] is True
    assert payload["claim"] == "external_review_request_message_sent_only"
    assert payload["weakest_next_boundary"] == NEXT
    assert payload["sent_url"].startswith("https://github.com/inaciovasquez2020/cslib-fmt/issues/")

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
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert "CHANNEL_TYPE := github_issue" in doc
    assert "CLAIM := external_review_request_message_sent_only" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim external acceptance" in doc
    assert "reviewer response" in doc

    print("EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_SENT_OK")


if __name__ == "__main__":
    main()
