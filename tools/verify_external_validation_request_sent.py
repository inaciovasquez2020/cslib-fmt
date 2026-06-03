import json
from pathlib import Path

artifact = Path("artifacts/cslib-fmt/external_validation_request_sent_2026_06_03.json")
doc = Path("docs/status/EXTERNAL_VALIDATION_REQUEST_SENT_2026_06_03.md")

data = json.loads(artifact.read_text(encoding="utf-8"))
text = doc.read_text(encoding="utf-8")

assert data["status"] == "EXTERNAL_VALIDATION_REQUEST_SENT_RECORDED"
assert data["artifact"] == "finite_graph_diameter_public_release"
assert data["repository"] == "inaciovasquez2020/cslib-fmt"
assert data["zenodo_doi"] == "10.5281/zenodo.20518144"
assert data["external_validator_recipient"] == "vardi@rice.edu"
assert data["request_sent"] is True
assert data["sent_date"] == "2026-06-03"
assert data["ExternalValidationExists"] is False
assert data["ExternalValidatorAccepts"] is False
assert data["next_admissible_object"] == "ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow"
assert "Next admissible object: `ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow`" in text

print("EXTERNAL_VALIDATION_REQUEST_SENT_OK")
print("NEXT_ADMISSIBLE_OBJECT=ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow")
