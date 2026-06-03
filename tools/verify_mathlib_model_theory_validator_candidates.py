from pathlib import Path
import json

artifact = sorted(Path("artifacts/cslib-fmt").glob("mathlib_model_theory_validator_candidates_*.json"))[-1]
data = json.loads(artifact.read_text())

assert data["object"] == "MathlibModelTheoryValidatorCandidates"
assert data["status"] == "CANDIDATES_SELECTED_NOT_CONTACTED_NOT_VALIDATION"
names = [c["name"] for c in data["selected_candidates"]]
assert names[:5] == [
    "Kim Morrison",
    "Aaron Anderson",
    "damiano",
    "Ruben Van de Velde",
    "Chris Hughes",
]
assert "external validation" in data["does_not_count_as"]
assert "contact attempt" in data["does_not_count_as"]
assert data["next_admissible_object"] == "AskMathlibZulipForNarrowValidatorRecommendation"

print("MATHLIB_MODEL_THEORY_VALIDATOR_CANDIDATES_OK")
