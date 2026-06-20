#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CR2_DISCHARGES_GUARDED_LOCALITY_INPUT_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_discharges_guarded_locality_input_2026_06_19.json")
DOC = Path("docs/status/CR2_DISCHARGES_GUARDED_LOCALITY_INPUT_2026_06_19.md")

REQUIRED_THEOREMS = [
    "cr2_discharges_guarded_locality_input",
    "cr2_restricted_guarded_formula_invariant",
]

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

FORBIDDEN_LEAN_TOKENS = ["axiom ", "opaque ", "sorry", "admit"]

def theorem_block(text: str, name: str) -> str:
    m = re.search(r"theorem\s+" + re.escape(name) + r"\b", text)
    if not m:
        raise SystemExit(f"MISSING_OBJECT := theorem {name}")
    next_theorem = re.search(r"\n(?:/--[\s\S]*?-/\n)?theorem\s+", text[m.end():])
    end_guarded = text.find("\nend GuardedLocality", m.start())
    if end_guarded == -1:
        raise SystemExit("MISSING_OBJECT := end GuardedLocality")
    if next_theorem:
        end = min(m.end() + next_theorem.start(), end_guarded)
    else:
        end = end_guarded
    return text[m.start():end]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()

    if "structure Cr2" not in text:
        raise SystemExit("MISSING_OBJECT := structure Cr2")

    blocks = {name: theorem_block(text, name) for name in REQUIRED_THEOREMS}

    for name, block in blocks.items():
        for token in FORBIDDEN_LEAN_TOKENS:
            if token in block:
                raise SystemExit(f"forbidden Lean token in {name} := {token.strip()}")

    if "exact h.input" not in blocks["cr2_discharges_guarded_locality_input"]:
        raise SystemExit("Cr2 input theorem must project h.input directly")

    if ".invariant φ" not in blocks["cr2_restricted_guarded_formula_invariant"]:
        raise SystemExit("Cr2 formula theorem must use existing invariant field")

    return {
        "id": CERT_ID,
        "status": "Cr2 discharges existing guarded-locality input conditionally",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "conditional theorem",
        "cr2_source": "structure Cr2",
        "discharged_surface": "RestrictedEFGameLocalTypeInvariantInputSurface",
        "verified_theorems": REQUIRED_THEOREMS,
        "conditional_boundary": "The discharge is conditional on a Cr2 witness; no arbitrary Cr2 constructor is claimed.",
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

`Cr2` conditionally discharges the existing guarded-locality input surface.

## Lean theorems

- `cr2_discharges_guarded_locality_input`
- `cr2_restricted_guarded_formula_invariant`

## Source file

`{payload["source_file"]}`

## Classification stratum

`conditional theorem`

## Discharged surface

`{payload["discharged_surface"]}`

## Conditional boundary

{payload["conditional_boundary"]}

## Nonclaims

- No arbitrary Cr2 witness is constructed.
- No unguarded FO locality theorem is claimed.
- No full Gaifman locality theorem is claimed.
- No Fagin theorem or 0-1 Law result is claimed.
- No global finite-model-theory final theorem is claimed.
- No external-validation result is claimed.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("Cr2 discharge id mismatch")
    if payload["classification_stratum"] != "conditional theorem":
        raise SystemExit("Cr2 discharge classification mismatch")
    if payload["discharged_surface"] != "RestrictedEFGameLocalTypeInvariantInputSurface":
        raise SystemExit("Cr2 discharge surface mismatch")
    if "conditional on a Cr2 witness" not in payload["conditional_boundary"]:
        raise SystemExit("Cr2 conditional boundary missing")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

    text = LEAN_FILE.read_text()
    for name in REQUIRED_THEOREMS:
        theorem_block(text, name)

def main() -> None:
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
    print("CR2_DISCHARGES_GUARDED_LOCALITY_INPUT_OK")

if __name__ == "__main__":
    main()
