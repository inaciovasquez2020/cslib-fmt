from pathlib import Path
import json

artifact = sorted(Path("artifacts/cslib-fmt").glob("vardi_directional_referral_*.json"))[-1]
data = json.loads(artifact.read_text())

assert data["object"] == "VardiDirectionalReferral"
assert data["status"] == "DIRECTIONAL_REFERRAL_RECEIVED_NOT_INDEPENDENT_VALIDATION"
assert "independent validation" in data["does_not_count_as"]
assert "endors" in " ".join(data["does_not_count_as"])
assert data["next_admissible_object"] == "IdentifyMathlibModelTheoryContributorOrAskMathlibZulipForNarrowValidatorRecommendation"

print("VARDI_DIRECTIONAL_REFERRAL_OK")
