import json
from pathlib import Path

ROOT = Path(".")
LEAN = ROOT / "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
ART = ROOT / "artifacts/existential_body_witness_transport_inhabitance_failure_lock_2026_06_21.json"
DOC = ROOT / "docs/status/EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK.md"

for path in (LEAN, ART, DOC):
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path}")

lean = LEAN.read_text()
art = json.loads(ART.read_text())
doc = DOC.read_text()

for forbidden in (
    "theorem existential_body_witness_locality_transport",
    "def existential_body_witness_locality_transport :=",
    "axiom existential_body_witness_locality_transport",
    "opaque existential_body_witness_locality_transport",
    "sorry",
    "admit",
):
    if forbidden in lean:
        raise SystemExit(f"MISSING_OBJECT := reverted failed proof marker absence {forbidden}")

for marker in (
    "def existential_body_witness_locality_transport_type : Type 1 :=",
    "theorem existential_body_same_witness_assignment_extension_invariance",
    "theorem existential_body_distinct_witness_assignment_extension_invariance",
):
    if marker not in lean:
        raise SystemExit(f"MISSING_OBJECT := {marker}")

if art.get("status") != "EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK_ONLY":
    raise SystemExit("MISSING_OBJECT := original transport-inhabitance failure lock status")

if art.get("weakest_missing_object") != "existential_ex_body_to_quantified_radius_witness_constructor":
    raise SystemExit("MISSING_OBJECT := weakest missing constructor lock")

components = art.get("proved_weaker_components")
if not isinstance(components, list):
    raise SystemExit("MISSING_OBJECT := proved weaker components list")

for component in (
    "existential_body_same_witness_assignment_extension_invariance",
    "existential_body_distinct_witness_assignment_extension_invariance",
):
    if component not in components:
        raise SystemExit(f"MISSING_OBJECT := proved weaker component {component}")

if art.get("remaining_transport_gap") != "existential_body_witness_locality_transport":
    raise SystemExit("MISSING_OBJECT := remaining transport gap recorded in lock artifact")

if art.get("remaining_constructor_gap") != "existential_ex_body_to_quantified_radius_witness_constructor":
    raise SystemExit("MISSING_OBJECT := remaining constructor gap recorded in lock artifact")

for boundary in [
    "not existential_body_witness_locality_transport",
    "not existential_ex_body_to_quantified_radius_witness_constructor",
    "not existential_locality_radius_constructor",
    "not full_quantifier_locality_transport",
    "not full_formula_radius_construction",
    "not Pk1",
    "not 2vK",
    "not full_unguarded_fo_locality",
]:
    if boundary not in json.dumps(art):
        raise SystemExit(f"MISSING_OBJECT := boundary {boundary}")

for marker in [
    "EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK_ONLY",
    "PROVED_WEAKER_COMPONENT := existential_body_same_witness_assignment_extension_invariance",
    "PROVED_WEAKER_COMPONENT := existential_body_distinct_witness_assignment_extension_invariance",
    "BOUNDARY := ¬ existential_body_witness_locality_transport",
    "BOUNDARY := ¬ existential_ex_body_to_quantified_radius_witness_constructor",
    "MISSING_OBJECT := existential_body_witness_locality_transport",
    "MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor",
]:
    if marker not in doc:
        raise SystemExit(f"MISSING_OBJECT := doc marker {marker}")

print("EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK_OK")
