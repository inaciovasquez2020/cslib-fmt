#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CR2_UNCONDITIONAL_CONSTRUCTOR_GAP_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_unconditional_constructor_gap_2026_06_19.json")
DOC = Path("docs/status/CR2_UNCONDITIONAL_CONSTRUCTOR_GAP_2026_06_19.md")

MISSING_LEMMA = """theorem cr2_unconditional_constructor
    {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    (r : Nat) (a : α) (b : β) :
    Cr2 𝒜 ℬ r a b"""

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

def require_current_cr2_surface(text: str) -> None:
    required = [
        "structure Cr2",
        "RestrictedEFGameLocalTypeInvariantInputSurface",
        "theorem cr2_discharges_guarded_locality_input",
        "theorem cr2_restricted_guarded_formula_invariant",
    ]
    for item in required:
        if item not in text:
            raise SystemExit(f"MISSING_OBJECT := {item}")

def constructor_present(text: str) -> bool:
    return re.search(r"^\s*theorem\s+cr2_unconditional_constructor\b", text, re.M) is not None

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()
    require_current_cr2_surface(text)

    if constructor_present(text):
        raise SystemExit("BOUNDARY_STALE := cr2_unconditional_constructor already exists; gap certificate must be replaced by theorem validation")

    return {
        "id": CERT_ID,
        "status": "Cr2 unconditional constructor gap",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "specification",
        "weakest_missing_lemma": MISSING_LEMMA,
        "reason": (
            "Cr2 currently projects the existing restricted guarded-locality input surface, "
            "but no theorem constructs Cr2 for arbitrary structures, radius, and points without new hypotheses."
        ),
        "bounded_result_retained": (
            "Cr2 conditionally discharges the bounded/restricted guarded-locality input surface."
        ),
        "unconditional_closure_blocker": (
            "An internal proof of cr2_unconditional_constructor is required before Cr2 can be used as an unconditional closure input."
        ),
        "nonclaims": [
            "No arbitrary Cr2 witness is constructed.",
            "No unguarded FO locality theorem is claimed.",
            "No full Gaifman locality theorem is claimed.",
            "No Fagin theorem or 0-1 Law result is claimed.",
            "No global finite-model-theory final theorem is claimed.",
            "No external-validation result is claimed.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.write_text(f"""# {CERT_ID}

## Status

`Cr2` is not yet an unconditional closure input.

## Weakest missing lemma

```lean
{payload["weakest_missing_lemma"]}
Reason
{payload["reason"]}
Retained bounded result
{payload["bounded_result_retained"]}
Unconditional closure blocker
{payload["unconditional_closure_blocker"]}
Nonclaims
No arbitrary Cr2 witness is constructed.
No unguarded FO locality theorem is claimed.
No full Gaifman locality theorem is claimed.
No Fagin theorem or 0-1 Law result is claimed.
No global finite-model-theory final theorem is claimed.
No external-validation result is claimed.
Boundary locks
{chr(10).join(f"- {b}" for b in payload["boundaries"])}
""")
def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("Cr2 constructor gap id mismatch")
    if payload["classification_stratum"] != "specification":
        raise SystemExit("Cr2 constructor gap classification mismatch")
    if "cr2_unconditional_constructor" not in payload["weakest_missing_lemma"]:
        raise SystemExit("missing exact constructor lemma")
    if "without new hypotheses" not in payload["reason"]:
        raise SystemExit("missing no-new-hypotheses boundary")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")
    text = LEAN_FILE.read_text()
    require_current_cr2_surface(text)
    if constructor_present(text):
        raise SystemExit("BOUNDARY_STALE := cr2_unconditional_constructor already exists")
def main() -> None:
    pass
parser = argparse.ArgumentParser()
parser.add_argument("--write-report", action="store_true")
args = parser.parse_args()
payload = build_payload()
if args.write_report:
    write_outputs(payload)

if not ARTIFACT.exists():
    raise SystemExit(f"MISSING_OBJECT := {ARTIFACT}")
if not DOC.exists():
    raise SystemExit(f"MISSING_OBJECT := {DOC}")

verify_payload(json.loads(ARTIFACT.read_text()))
print("CR2_UNCONDITIONAL_CONSTRUCTOR_GAP_OK")
if __name__ == "__main__":
    main()
