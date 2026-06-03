from pathlib import Path
import json

artifact = sorted(Path("artifacts/cslib-fmt").glob("lean_zulip_validator_recommendation_request_posted_*.json"))[-1]
data = json.loads(artifact.read_text())

assert data["object"] == "LeanZulipValidatorRecommendationRequestPosted"
assert data["status"] == "POSTED_REQUEST_NOT_VALIDATION"
assert data["posted_url"].startswith("https://leanprover.zulipchat.com/#narrow/channel/287929-mathlib4/")
assert "<" not in data["posted_url"]
assert ">" not in data["posted_url"]
assert "..." not in data["posted_url"]
assert data["topic"] == "Finite graph diameter validation"
assert "external validation" in data["does_not_count_as"]
assert "validator recommendation received" in data["does_not_count_as"]
assert data["next_admissible_object"] == "ZulipValidatorRecommendationReplyOrSecondValidatorAfterWaitingWindow"

draft = Path(data["draft_path"])
assert draft.exists()
assert "finite graph diameter theorem stack only" in draft.read_text()

print("LEAN_ZULIP_VALIDATOR_RECOMMENDATION_REQUEST_POSTED_OK")
