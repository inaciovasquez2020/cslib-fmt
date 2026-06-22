from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_external_review_message_draft_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_external_validation_request_packet_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_DRAFT.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_DRAFT_ONLY"
OBJECT = "existential_constructor_external_review_message_draft"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_EXTERNAL_VALIDATION_REQUEST_PACKET_ONLY"
SOURCE_COMMIT = "a3c0f91"
TARGET_COMMIT = "cc60f9a"
NEXT = "external_review_message_sent"
REQUIRED_NAMES = [
    "existential_constructor_actual_downstream_theorem_use_status_closed",
    "full_formula_radius_construction_status_closed",
    "full_formula_radius_construction_closed",
]


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "external_validation_request_sent_or_independent_reviewer_response"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["draft_only"] is True
    assert payload["sent"] is False
    assert payload["weakest_next_boundary"] == NEXT

    body = "\n".join(payload["message_body"])
    assert TARGET_COMMIT in body
    assert "bounded independent review" in body
    assert "claimed only as an internal downstream Lean use" in body
    assert "does not claim external acceptance" in body
    for name in REQUIRED_NAMES:
        assert name in body

    lowered = body.lower()
    for forbidden in payload["must_not_contain"]:
        assert forbidden.lower() not in lowered

    forbidden_claims = payload["does_not_claim"]
    assert "external_acceptance" in forbidden_claims
    assert "request_sent" in forbidden_claims
    assert "reviewer_response" in forbidden_claims
    assert "Fagin_theorem" in forbidden_claims
    assert "zero_one_law" in forbidden_claims
    assert "Pk1_route_closed" in forbidden_claims
    assert "TwoVK_route_closed" in forbidden_claims
    assert "new_external_mathematical_acceptance" in forbidden_claims

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert "DRAFT_ONLY := true" in doc
    assert "SENT := false" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "does not claim external acceptance" in doc
    assert "request sent" in doc
    assert "reviewer response" in doc
    for name in REQUIRED_NAMES:
        assert f"`{name}`" in doc

    lean = LEAN.read_text()
    for name in REQUIRED_NAMES:
        assert name in lean

    print("EXISTENTIAL_CONSTRUCTOR_EXTERNAL_REVIEW_MESSAGE_DRAFT_OK")


if __name__ == "__main__":
    main()
