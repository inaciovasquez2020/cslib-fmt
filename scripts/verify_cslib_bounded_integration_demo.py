#!/usr/bin/env python3
import json
from pathlib import Path

ARTIFACT = Path("artifacts/external_validation/cslib_bounded_integration_demo_2026_06_23.json")
EXPECTED = "CSLIB_BOUNDED_INTEGRATION_DEMO_OK"
ADAPTER = Path("artifacts/external_validation/cslib_finite_graph_certificate_adapter_2026_06_23.json")
ADAPTER_EXPECTED = "CSLIB_FINITE_GRAPH_CERTIFICATE_ADAPTER_OK"
OBJECT_RECORD = Path("artifacts/external_validation/cslib_downstream_library_object_reference_record_2026_06_23.json")
OBJECT_RECORD_EXPECTED = "CSLIB_DOWNSTREAM_LIBRARY_OBJECT_REFERENCE_RECORD_OK"


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

    object_record = json.loads(OBJECT_RECORD.read_text(encoding="utf-8"))
    assert object_record["artifact"] == "cslib_downstream_library_object_reference_record"
    assert object_record["status"] == "bounded_cslib_object_reference_record"
    assert object_record["outside_repo"] == "leanprover/cslib"
    assert object_record["strongest_evidence_commit"] == "785cf69"
    assert object_record["source_import"] == "CSLIB.FMT.UnguardedFO.DownstreamLibrary"
    assert object_record["referenced_object"] == "CSLIB.FMT.UnguardedFO.downstream_library_radius_zero_locality_input"
    assert object_record["lean_check_file"] == "lean/CSLIB/FMT/UnguardedFO/DownstreamLibraryObjectCheck.lean"
    assert object_record["ok_token"] == OBJECT_RECORD_EXPECTED
    assert "UnguardedFOLocalityInputSurface M φ 0" in object_record["referenced_type"]
    assert "No adoption is claimed." in object_record["non_claims"]

    print(EXPECTED)
    print(ADAPTER_EXPECTED)
    print(OBJECT_RECORD_EXPECTED)


if __name__ == "__main__":
    main()
