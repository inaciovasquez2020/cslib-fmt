import json
from pathlib import Path

artifact = Path("artifacts/cslib-fmt/external_validator_recipient_2026_06_03.json")
doc = Path("docs/status/EXTERNAL_VALIDATOR_RECIPIENT_2026_06_03.md")

data = json.loads(artifact.read_text(encoding="utf-8"))
text = doc.read_text(encoding="utf-8")

assert data["status"] == "EXTERNAL_VALIDATOR_RECIPIENT_SET"
assert data["artifact"] == "finite_graph_diameter_public_release"
assert data["repository"] == "inaciovasquez2020/cslib-fmt"
assert data["zenodo_doi"] == "10.5281/zenodo.20518144"
assert data["external_validator_recipient"] == "vardi@rice.edu"
assert data["ExternalValidationRequestSent"] is False
assert data["ExternalValidationExists"] is False
assert data["ExternalValidatorAccepts"] is False
assert data["next_admissible_object"] == "CreateExternalValidationRequestMessage"
assert "Next admissible object: `CreateExternalValidationRequestMessage`" in text

print("EXTERNAL_VALIDATOR_RECIPIENT_OK")
print("NEXT_ADMISSIBLE_OBJECT=CreateExternalValidationRequestMessage")
