from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_artifact_verified_ai_assisted_review_response_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_artifact_accessible_review_bundle_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_VERIFIED_AI_ASSISTED_REVIEW_RESPONSE.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_VERIFIED_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
OBJECT = "existential_constructor_artifact_verified_ai_assisted_review_response"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_ACCESSIBLE_REVIEW_BUNDLE_ONLY"
SOURCE_COMMIT = "0832baf"
TARGET_COMMIT = "cc60f9a"
NEXT = "raw_git_show_or_live_repository_access_independent_review"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "artifact_verified_independent_review_response"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["reviewer_kind"] == "ai_assistant"
    assert payload["reviewer_name"] == "Claude"
    assert payload["review_scope"] == "artifact_accessible_gist_bundle_review_only"
    assert payload["bundle_url"].startswith("https://gist.github.com/inaciovasquez2020/")
    assert payload["weakest_next_boundary"] == NEXT

    answers = payload["answers"]
    assert answers["lean_excerpt_contains_claimed_edge"] == "yes"
    assert answers["named_edge_avoids_forbidden_tokens_in_excerpt"] == "yes"
    assert answers["status_wording_bounded_to_internal_lean_verification"] == "yes"
    assert answers["weakest_remaining_objection"] == "gap_between_gist_excerpt_and_live_file_at_review_target_commit"

    verified = payload["verified_by_ai_against_accessible_artifacts"]
    assert "LEAN_NAMED_EDGE_EXCERPT_contains_named_def_and_theorem" in verified
    assert "excerpt_contains_no_sorry_admit_axiom_opaque_tokens" in verified
    assert "status_wording_stays_bounded_to_internal_Lean_verification" in verified

    not_verified = payload["not_verified_by_ai"]
    assert "live_LocalityInputSurface_lean_at_cc60f9a" in not_verified
    assert "independent_rerun_of_verifier_script" in not_verified
    assert "independent_git_ancestry_check" in not_verified

    response = payload["verbatim_response"]
    assert "Artifact-accessible AI-assisted review only" in response
    assert "not independent expert acceptance" in response
    assert "not a raw git show" in response
    assert "gap between the gist excerpt and the live file" in response

    forbidden = payload["does_not_claim"]
    assert "independent_expert_acceptance" in forbidden
    assert "mathematical_certification" in forbidden
    assert "external_acceptance" in forbidden
    assert "live_repository_verified_review" in forbidden
    assert "reviewer_reran_verifier" in forbidden
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
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert "REVIEWER_NAME := Claude" in doc
    assert "LEAN_EXCERPT_CONTAINS_CLAIMED_EDGE := yes" in doc
    assert "NAMED_EDGE_AVOIDS_FORBIDDEN_TOKENS_IN_EXCERPT := yes" in doc
    assert "STATUS_WORDING_BOUNDED_TO_INTERNAL_LEAN_VERIFICATION := yes" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc

    print("EXISTENTIAL_CONSTRUCTOR_ARTIFACT_VERIFIED_AI_ASSISTED_REVIEW_RESPONSE_OK")


if __name__ == "__main__":
    main()
