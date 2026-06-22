from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_boundary_supersession_status_2026_06_22.json"
PREVIOUS = ROOT / "artifacts" / "existential_constructor_downstream_reuse_check_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_BOUNDARY_SUPERSESSION_STATUS.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_BOUNDARY_SUPERSESSION_STATUS_ONLY"
OBJECT = "existential_constructor_boundary_supersession_status"
SUPERSEDED = "existential_ex_body_to_quantified_radius_witness_constructor"
EVIDENCE_NAMES = [
    "existential_ex_body_to_quantified_radius_witness_constructor",
    "existential_body_witness_locality_transport_type_constructor",
    "existential_locality_radius_constructor",
    "unguarded_fo_formula_radius_construction",
    "full_formula_radius_construction_closed",
]


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    previous = json.loads(PREVIOUS.read_text())

    assert previous["weakest_missing_object"] == SUPERSEDED

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["superseded_boundary"] == SUPERSEDED
    assert payload["claim"] == "previous_downstream_reuse_missing_object_superseded_by_current_Lean_surface"
    assert payload["next_weakest_boundary"] == "external_independent_validation_or_new_downstream_theorem_use"

    for name in EVIDENCE_NAMES:
        assert name in payload["evidence_names"]

    forbidden = payload["does_not_claim"]
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "new_mathematical_theorem_beyond_current_Lean_surface" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SUPERSEDED_BOUNDARY := {SUPERSEDED}" in doc
    assert "NEXT_WEAKEST_BOUNDARY := external_independent_validation_or_new_downstream_theorem_use" in doc
    for name in EVIDENCE_NAMES:
        assert f"`{name}`" in doc

    lean = LEAN.read_text()
    for name in EVIDENCE_NAMES:
        assert name in lean

    print("EXISTENTIAL_CONSTRUCTOR_BOUNDARY_SUPERSESSION_STATUS_OK")


if __name__ == "__main__":
    main()
