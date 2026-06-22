from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_ai_assisted_review_response_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_independent_review_response_pending_status_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_AI_ASSISTED_REVIEW_RESPONSE.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
OBJECT = "existential_constructor_ai_assisted_review_response"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_INDEPENDENT_REVIEW_RESPONSE_PENDING_STATUS_ONLY"
SOURCE_COMMIT = "c9e7be4"
TARGET_COMMIT = "cc60f9a"
NEXT = "explicit_no_sorry_or_no_admitted_placeholder_check_for_named_edge"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["claim"] == "independent_reviewer_response_not_yet_observed"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["reviewer_kind"] == "ai_assistant"
    assert payload["reviewer_name"] == "Claude"
    assert payload["artifact_access"] == "not_publicly_accessible_to_reviewer"
    assert payload["review_scope"] == "logical_structural_review_of_claim_as_stated_only"
    assert payload["weakest_next_boundary"] == NEXT

    answers = payload["answers"]
    assert answers["claim_matches_files"] == "unverifiable_without_file_access"
    assert answers["claim_bounded_to_internal_lean_verification"] == "yes_as_worded"
    assert answers["avoids_overclaiming"] == "yes_as_worded"
    assert answers["weakest_remaining_objection"] == "closed_not_explicitly_confirmed_as_sorry_free_Lean_proof_term"

    ranked = payload["ranked_objections"]
    assert ranked[0]["rank"] == 1
    assert ranked[0]["objection"] == "closed_not_explicitly_confirmed_as_sorry_free_Lean_proof_term"
    assert ranked[0]["boundary"] == NEXT
    assert ranked[1]["rank"] == 2
    assert ranked[1]["objection"] == "commit_gap_between_review_target_and_recorded_status_uncharacterized"
    assert ranked[1]["boundary"] == "linear_ancestry_and_no_intervening_Lean_change_check"

    forbidden = payload["does_not_claim"]
    assert "artifact_verified_review" in forbidden
    assert "independent_expert_validation" in forbidden
    assert "external_acceptance" in forbidden
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
    assert "REVIEWER_NAME := Claude" in doc
    assert "CLAIM_MATCHES_FILES := unverifiable_without_file_access" in doc
    assert "CLAIM_BOUNDED_TO_INTERNAL_LEAN_VERIFICATION := yes_as_worded" in doc
    assert "AVOIDS_OVERCLAIMING := yes_as_worded" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim artifact-verified review" in doc

    print("EXISTENTIAL_CONSTRUCTOR_AI_ASSISTED_REVIEW_RESPONSE_OK")


if __name__ == "__main__":
    main()
