from pathlib import Path
import json

artifact = sorted(Path("artifacts/cslib-fmt").glob("lean_zulip_validator_recommendation_request_draft_*.json"))[-1]
data = json.loads(artifact.read_text())

assert data["object"] == "LeanZulipValidatorRecommendationRequestDraft"
assert data["status"] == "DRAFT_CREATED_NOT_POSTED"
assert data["topic"] == "Narrow validator recommendation for finite graph diameter Lean release"
assert "posted request" in data["does_not_count_as"]
assert "external validation" in data["does_not_count_as"]
assert data["next_admissible_object"] == "PostInAppropriateLeanZulipStream"

draft = Path(data["draft_path"])
text = draft.read_text()
assert "inaciovasquez2020/cslib-fmt" in text
assert "10.5281/zenodo.20518144" in text
assert "finite graph diameter theorem stack only" in text
assert "not a request for a broad research review or endorsement" in text

print("LEAN_ZULIP_VALIDATOR_RECOMMENDATION_REQUEST_DRAFT_OK")
