#!/usr/bin/env python3
import json
from pathlib import Path

ARTIFACT = Path("artifacts/external_validation/cslib_bounded_integration_demo_2026_06_23.json")
EXPECTED = "CSLIB_BOUNDED_INTEGRATION_DEMO_OK"


def main() -> None:
    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))

    assert data["artifact"] == "cslib_bounded_integration_demo"
    assert data["status"] == "bounded_non_merged_integration_evidence"
    assert data["outside_repo"] == "leanprover/cslib"
    assert data["ok_token"] == EXPECTED

    non_claims = data["non_claims"]
    required = [
        "No upstream acceptance is claimed.",
        "No maintainer review is claimed.",
        "No peer review is claimed.",
        "No adoption is claimed.",
        "No URF theorem closure is claimed."
    ]
    for item in required:
        assert item in non_claims

    print(EXPECTED)


if __name__ == "__main__":
    main()
