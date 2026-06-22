from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_actual_downstream_theorem_use_status_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_internal_downstream_use_status_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_ACTUAL_DOWNSTREAM_THEOREM_USE_STATUS.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_ACTUAL_DOWNSTREAM_THEOREM_USE_STATUS_ONLY"
OBJECT = "existential_constructor_actual_downstream_theorem_use_status"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_INTERNAL_DOWNSTREAM_USE_STATUS_ONLY"
CLOSED = "existential_constructor_actual_downstream_theorem_use_status_closed"
USED = [
    "full_formula_radius_construction_status_closed",
    "full_formula_radius_construction_closed",
]
NEXT = "external_independent_validation"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "actual_new_downstream_theorem_use"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["claim"] == "actual_internal_downstream_Lean_status_edge_using_full_formula_radius_construction_closed"
    assert payload["weakest_next_boundary"] == NEXT

    assert OBJECT in payload["lean_declarations"]
    assert CLOSED in payload["lean_declarations"]
    for name in USED:
        assert name in payload["uses_lean_declarations"]

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"`{OBJECT}`" in doc
    assert f"`{CLOSED}`" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    for name in USED:
        assert f"`{name}`" in doc

    lean = LEAN.read_text()
    assert f"def {OBJECT} : Prop :=" in lean
    assert f"theorem {CLOSED} :" in lean
    for name in USED:
        assert name in lean

    print("EXISTENTIAL_CONSTRUCTOR_ACTUAL_DOWNSTREAM_THEOREM_USE_STATUS_OK")


if __name__ == "__main__":
    main()
