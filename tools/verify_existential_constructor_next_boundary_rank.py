from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_next_boundary_rank_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_boundary_supersession_status_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK_ONLY"
OBJECT = "existential_constructor_next_boundary_rank"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_BOUNDARY_SUPERSESSION_STATUS_ONLY"
FIRST = "new_downstream_theorem_use"
SECOND = "external_independent_validation"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["next_weakest_boundary"] == "external_independent_validation_or_new_downstream_theorem_use"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["weakest_next_boundary"] == FIRST

    ranked = payload["ranked_boundaries"]
    assert ranked[0]["rank"] == 1
    assert ranked[0]["boundary"] == FIRST
    assert ranked[0]["reason"] == "internal_and_executable_before_external_review"
    assert ranked[0]["bounded_next_step"] == "add_one_downstream_theorem_or_status_use_of_the_current_Lean_surface"

    assert ranked[1]["rank"] == 2
    assert ranked[1]["boundary"] == SECOND
    assert ranked[1]["reason"] == "depends_on_external_reviewer_or_public_acceptance_signal"

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "new_mathematical_theorem" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"`{FIRST}`" in doc
    assert f"`{SECOND}`" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {FIRST}" in doc

    print("EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK_OK")


if __name__ == "__main__":
    main()
