from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_live_repo_review_request_after_machine_grep_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_machine_grep_raw_git_show_identifier_visibility_resolution_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_LIVE_REPO_REVIEW_REQUEST_AFTER_MACHINE_GREP.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_LIVE_REPO_REVIEW_REQUEST_AFTER_MACHINE_GREP_ONLY"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION_ONLY"
NEXT = "live_repository_or_human_reviewer_response"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "independent_live_repository_or_human_review"

    assert payload["status"] == STATUS
    assert payload["source_commit"] == "0c5018d"
    assert payload["review_target_commit"] == "cc60f9a"
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["request_channel"] == "local_record_only"
    assert payload["review_request_comment_posted"] is False
    assert payload["claim"] == "live_repository_or_human_review_request_prepared_after_machine_grep_only"
    assert payload["weakest_next_boundary"] == NEXT

    result = payload["machine_grep_result"]
    assert result["existential_constructor_actual_downstream_theorem_use_status"]["found"] is True
    assert result["existential_constructor_actual_downstream_theorem_use_status"]["line_numbers"] == [1607]
    assert result["existential_constructor_actual_downstream_theorem_use_status_closed"]["found"] is True
    assert result["existential_constructor_actual_downstream_theorem_use_status_closed"]["line_numbers"] == [1610, 1611]

    forbidden = payload["does_not_claim"]
    assert "github_comment_posted" in forbidden
    assert "external_acceptance" in forbidden
    assert "independent_expert_validation" in forbidden
    assert "mathematical_certification" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "human_review_completed" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert "SOURCE_COMMIT := 0c5018d" in doc
    assert "REQUEST_CHANNEL := local_record_only" in doc
    assert "REVIEW_REQUEST_COMMENT_POSTED := false" in doc
    assert "line 1607" in doc
    assert "lines 1610-1611" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim GitHub comment posted" in doc

    print("EXISTENTIAL_CONSTRUCTOR_LIVE_REPO_REVIEW_REQUEST_AFTER_MACHINE_GREP_OK")


if __name__ == "__main__":
    main()
