from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_internal_downstream_use_status_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_next_boundary_rank_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_INTERNAL_DOWNSTREAM_USE_STATUS.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_INTERNAL_DOWNSTREAM_USE_STATUS_ONLY"
OBJECT = "existential_constructor_internal_downstream_use_status"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK_ONLY"
SELECTED = "new_downstream_theorem_use"
NEXT = "actual_new_downstream_theorem_use"
EVIDENCE_NAMES = [
    "existential_ex_body_to_quantified_radius_witness_constructor",
    "existential_body_witness_locality_transport_type_constructor",
    "existential_locality_radius_constructor",
    "unguarded_fo_formula_radius_construction",
    "full_formula_radius_construction_closed",
]


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == SELECTED

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["selected_ranked_boundary"] == SELECTED
    assert payload["downstream_use_kind"] == "status_use"
    assert payload["claim"] == "internal_downstream_status_use_of_current_existential_constructor_Lean_surface"
    assert payload["weakest_next_boundary"] == NEXT

    for name in EVIDENCE_NAMES:
        assert name in payload["uses_current_lean_surface_names"]

    forbidden = payload["does_not_claim"]
    assert "new_mathematical_theorem" in forbidden
    assert "external_acceptance" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"SELECTED_RANKED_BOUNDARY := {SELECTED}" in doc
    assert "DOWNSTREAM_USE_KIND := status_use" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    for name in EVIDENCE_NAMES:
        assert f"`{name}`" in doc

    lean = LEAN.read_text()
    for name in EVIDENCE_NAMES:
        assert name in lean

    print("EXISTENTIAL_CONSTRUCTOR_INTERNAL_DOWNSTREAM_USE_STATUS_OK")


if __name__ == "__main__":
    main()
