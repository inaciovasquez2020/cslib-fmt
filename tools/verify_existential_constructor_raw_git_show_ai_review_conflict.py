from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_raw_git_show_ai_review_conflict_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_raw_git_show_review_bundle_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT_ONLY"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_REVIEW_BUNDLE_ONLY"
NEXT = "machine_grep_raw_git_show_identifier_visibility_resolution"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert payload["status"] == STATUS
    assert payload["source_commit"] == "f29ed59"
    assert payload["review_target_commit"] == "cc60f9a"
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["conflict"]["exists"] is True
    assert payload["conflict"]["field"] == "claimed_edge_visible_in_raw_git_show_artifact"
    assert payload["conflict"]["claude"] == "no_or_not_visible_due_to_rendered_fetch_truncation"
    assert payload["conflict"]["gemini"] == "yes"
    assert payload["weakest_next_boundary"] == NEXT

    responses = {item["reviewer_name"]: item for item in payload["reviewer_responses"]}
    assert responses["Claude"]["claimed_edge_visible"] == "no_or_not_visible_due_to_rendered_fetch_truncation"
    assert responses["Gemini"]["claimed_edge_visible"] == "yes"

    forbidden = payload["does_not_claim"]
    assert "conflict_resolved" in forbidden
    assert "external_acceptance" in forbidden
    assert "independent_expert_validation" in forbidden
    assert "mathematical_certification" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "human_review" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert "CLAUDE_REVIEW := no_or_not_visible_due_to_rendered_fetch_truncation" in doc
    assert "GEMINI_REVIEW := yes" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not resolve the conflict" in doc

    print("EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT_OK")


if __name__ == "__main__":
    main()
