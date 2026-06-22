from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_downstream_reuse_check_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REUSE_CHECK.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

EXPECTED_STATUS = "EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REUSE_CHECK_ONLY"
EXPECTED_OBJECT = "existential_constructor_downstream_reuse_check"
REQUIRED_NAMES = [
    "existential_locality_radius_constructor",
    "concrete_quantifier_locality_transport_named_interface",
    "existential_constructor_obligation_gap_package_status",
]
MISSING_OBJECT = "existential_ex_body_to_quantified_radius_witness_constructor"


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())

    assert payload["status"] == EXPECTED_STATUS
    assert payload["object"] == EXPECTED_OBJECT
    assert payload["claim"] == "downstream_reuse_check_only"
    assert payload["weakest_missing_object"] == MISSING_OBJECT

    upstream = payload["upstream_objects"]
    for name in REQUIRED_NAMES:
        assert name in upstream

    forbidden_claims = payload["does_not_claim"]
    assert MISSING_OBJECT in forbidden_claims
    assert "full_formula_radius_constructor" in forbidden_claims

    doc = DOC.read_text()
    assert f"STATUS := {EXPECTED_STATUS}" in doc
    assert f"OBJECT := {EXPECTED_OBJECT}" in doc
    assert f"MISSING_OBJECT := {MISSING_OBJECT}" in doc
    for name in REQUIRED_NAMES:
        assert f"`{name}`" in doc

    lean = LEAN.read_text()
    for name in REQUIRED_NAMES:
        assert name in lean

    print("EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REUSE_CHECK_OK")


if __name__ == "__main__":
    main()
