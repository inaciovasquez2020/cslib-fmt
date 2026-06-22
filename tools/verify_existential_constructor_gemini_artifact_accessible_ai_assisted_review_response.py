from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_gemini_artifact_accessible_ai_assisted_review_response_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_artifact_verified_ai_assisted_review_response_2026_06_22.json"
BUNDLE = ROOT / "artifacts" / "existential_constructor_artifact_accessible_review_bundle_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_GEMINI_ARTIFACT_ACCESSIBLE_AI_ASSISTED_REVIEW_RESPONSE.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_GEMINI_ARTIFACT_ACCESSIBLE_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
OBJECT = "existential_constructor_gemini_artifact_accessible_ai_assisted_review_response"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_VERIFIED_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
BUNDLE_STATUS = "EXISTENTIAL_CONSTRUCTOR_ARTIFACT_ACCESSIBLE_REVIEW_BUNDLE_ONLY"
SOURCE_COMMIT = "c3ca85e"
BUNDLE_COMMIT = "0832baf"
BUNDLE_SOURCE_COMMIT = "fc8fc99"
TARGET_COMMIT = "cc60f9a"
NEXT = "external_independent_validation_or_live_repository_review"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())
    bundle = json.loads(BUNDLE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["source_commit"] == BUNDLE_COMMIT
    assert bundle["status"] == BUNDLE_STATUS
    assert bundle["source_commit"] == BUNDLE_SOURCE_COMMIT

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["bundle_commit"] == BUNDLE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["bundle_status"] == BUNDLE_STATUS
    assert payload["reviewer_kind"] == "ai_assistant"
    assert payload["reviewer_name"] == "Gemini"
    assert payload["review_scope"] == "artifact_accessible_gist_bundle_review_only"
    assert payload["bundle_url"].startswith("https://gist.github.com/inaciovasquez2020/")
    assert payload["weakest_next_boundary"] == NEXT

    answers = payload["answers"]
    assert answers["lean_excerpt_contains_claimed_edge"] == "yes"
    assert answers["named_edge_avoids_forbidden_tokens_in_excerpt"] == "yes"
    assert answers["status_wording_bounded_to_internal_lean_verification"] == "yes"
    assert answers["weakest_remaining_boundary_reported_by_reviewer"] == "artifact_accessible_independent_review_and_external_independent_validation"

    verified = payload["verified_by_ai_against_accessible_artifacts"]
    assert "Lean_excerpt_contains_named_proposition_and_closed_theorem" in verified
    assert "excerpt_uses_constructor_and_exact" in verified
    assert "excerpt_avoids_sorry_admit_axiom_opaque" in verified
    assert "artifact_metadata_bounds_claim_to_internal_Lean_verification" in verified

    not_verified = payload["not_verified_by_ai"]
    assert "independent_expert_acceptance" in not_verified
    assert "mathematical_certification" in not_verified
    assert "live_repository_verified_review" in not_verified
    assert "reviewer_reran_verifier" in not_verified
    assert "external_independent_validation" in not_verified

    response = payload["verbatim_response"]
    assert "Gemini response" in response
    assert "artifact-accessible AI-assisted review only" in response
    assert "does not constitute independent expert acceptance" in response
    assert "mathematical certification" in response

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
    assert f"BUNDLE_COMMIT := {BUNDLE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"BUNDLE_STATUS := {BUNDLE_STATUS}" in doc
    assert "REVIEWER_NAME := Gemini" in doc
    assert "LEAN_EXCERPT_CONTAINS_CLAIMED_EDGE := yes" in doc
    assert "NAMED_EDGE_AVOIDS_FORBIDDEN_TOKENS_IN_EXCERPT := yes" in doc
    assert "STATUS_WORDING_BOUNDED_TO_INTERNAL_LEAN_VERIFICATION := yes" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc

    print("EXISTENTIAL_CONSTRUCTOR_GEMINI_ARTIFACT_ACCESSIBLE_AI_ASSISTED_REVIEW_RESPONSE_OK")


if __name__ == "__main__":
    main()
