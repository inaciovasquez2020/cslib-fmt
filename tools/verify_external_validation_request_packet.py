import json
from pathlib import Path

artifact = Path("artifacts/cslib-fmt/external_validation_request_packet_2026_06_03.json")
doc = Path("docs/status/EXTERNAL_VALIDATION_REQUEST_PACKET_2026_06_03.md")

data = json.loads(artifact.read_text(encoding="utf-8"))
text = doc.read_text(encoding="utf-8")

assert data["status"] == "EXTERNAL_VALIDATION_REQUEST_PACKET_CREATED"
assert data["artifact"] == "finite_graph_diameter_public_release"
assert data["repository"] == "inaciovasquez2020/cslib-fmt"
assert data["zenodo_doi"] == "10.5281/zenodo.20518144"
assert data["claim_under_review"] == "finite graph diameter theorem stack is machine-checked and publicly citable"

for forbidden in [
    "external validation",
    "external acceptance",
    "field-wide adoption",
    "Clay problem solution",
]:
    assert forbidden in data["not_claimed"]

missing = data["missing_objects"]
assert missing["ExternalValidatorRecipient"] is None
assert missing["ExternalValidationRequestSent"] is False
assert missing["ExternalValidationExists"] is False
assert missing["ExternalValidatorAccepts"] is False

assert data["next_admissible_object"] == "SetExternalValidatorRecipient"
assert "Next admissible object: `SetExternalValidatorRecipient`" in text

print("EXTERNAL_VALIDATION_REQUEST_PACKET_OK")
print("NEXT_ADMISSIBLE_OBJECT=SetExternalValidatorRecipient")
