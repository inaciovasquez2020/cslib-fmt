#!/usr/bin/env python3
import json
from pathlib import Path

ARTIFACT = Path("artifacts/external_validation/cslib_bounded_integration_demo_2026_06_23.json")
EXPECTED = "CSLIB_BOUNDED_INTEGRATION_DEMO_OK"
ADAPTER = Path("artifacts/external_validation/cslib_finite_graph_certificate_adapter_2026_06_23.json")
ADAPTER_EXPECTED = "CSLIB_FINITE_GRAPH_CERTIFICATE_ADAPTER_OK"


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

    adapter = json.loads(ADAPTER.read_text(encoding="utf-8"))
    assert adapter["artifact"] == "cslib_finite_graph_certificate_adapter"
    assert adapter["status"] == "bounded_cslib_facing_compatibility_object"
    assert adapter["outside_repo"] == "leanprover/cslib"
    assert adapter["base_evidence_commit"] == "006adf9"
    assert adapter["object_kind"] == "finite_graph_certificate_adapter_schema"
    assert adapter["ok_token"] == ADAPTER_EXPECTED
    assert "vertices" in adapter["adapter_fields"]
    assert "edges" in adapter["adapter_fields"]
    assert "certificate" in adapter["adapter_fields"]

    print(EXPECTED)
    print(ADAPTER_EXPECTED)


if __name__ == "__main__":
    main()
