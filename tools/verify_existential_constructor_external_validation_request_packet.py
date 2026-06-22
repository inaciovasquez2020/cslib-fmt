from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_external_validation_request_packet_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_actual_downstream_theorem_use_status_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_VALIDATION_REQUEST_PACKET.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_VALIDATION_REQUEST_PACKET_ONLY"
OBJECT = "existential_constructor_external_validation_request_packet"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_ACTUAL_DOWNSTREAM_THEOREM_USE_STATUS_ONLY"
SOURCE_COMMIT = "cc60f9a"
NEXT = "external_validation_request_sent_or_independent_reviewer_response"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "external_independent_validation"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["request_scope"] == "independent_review_of_internal_Lean_verification_boundary"
    assert payload["weakest_next_boundary"] == NEXT

    review_claims = payload["claims_for_review"]
    assert "Lean_contains_actual_internal_downstream_status_edge" in review_claims
    assert "edge_uses_full_formula_radius_construction_status_closed" in review_claims
    assert "edge_uses_full_formula_radius_construction_closed" in review_claims
    assert "full_pytest_passed_at_source_commit" in review_claims

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "request_sent" in forbidden
    assert "reviewer_response" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    questions = payload["requested_validation_questions"]
    assert "Does_commit_cc60f9a_contain_a_real_internal_Lean_downstream_status_edge" in questions
    assert "Are_the_claims_bounded_to_internal_Lean_verification" in questions
    assert "Is_external_acceptance_explicitly_not_claimed" in questions
    assert "What_is_the_next_weakest_independent_validation_objection" in questions

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "request sent" in doc
    assert "external acceptance" in doc

    lean = LEAN.read_text()
    assert "existential_constructor_actual_downstream_theorem_use_status_closed" in lean
    assert "full_formula_radius_construction_status_closed" in lean
    assert "full_formula_radius_construction_closed" in lean

    print("EXISTENTIAL_CONSTRUCTOR_EXTERNAL_VALIDATION_REQUEST_PACKET_OK")


if __name__ == "__main__":
    main()
