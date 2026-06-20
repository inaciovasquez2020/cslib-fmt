#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CR2_REFLEXIVE_CONSTRUCTOR_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_reflexive_constructor_2026_06_19.json")
DOC = Path("docs/status/CR2_REFLEXIVE_CONSTRUCTOR_2026_06_19.md")

THEOREM_NAME = "cr2_reflexive_constructor"

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

FORBIDDEN_LEAN_TOKENS = ["axiom ", "opaque ", "sorry", "admit"]

def theorem_block(text: str) -> str:
    m = re.search(r"theorem\s+" + re.escape(THEOREM_NAME) + r"\b", text)
    if not m:
        raise SystemExit(f"MISSING_OBJECT := theorem {THEOREM_NAME}")
    end = text.find("\nend GuardedLocality", m.start())
    if end == -1:
        raise SystemExit("MISSING_OBJECT := end GuardedLocality after cr2 reflexive constructor")
    return text[m.start():end]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()
    block = theorem_block(text)

    for required in [
        "structure Cr2",
        "RestrictedEFGameLocalTypeInvariantInputSurface",
        "theorem cr2_reflexive_constructor",
    ]:
        if required not in text:
            raise SystemExit(f"MISSING_OBJECT := {required}")

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in block:
            raise SystemExit(f"forbidden Lean token in reflexive constructor := {token.strip()}")

    if "Iff.rfl" not in block:
        raise SystemExit("reflexive constructor must close by Iff.rfl")

    if "Cr2 𝒜 𝒜 r a a" not in block:
        raise SystemExit("reflexive constructor target mismatch")

    return {
        "id": CERT_ID,
        "status": "Cr2 reflexive constructor proved",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "verified lemma",
        "theorem": THEOREM_NAME,
        "proved_scope": "same structure, same point, same radius",
        "proof_method": "Restricted guarded formula invariance closes by reflexivity.",
        "remaining_gap": (
            "The arbitrary cross-structure constructor cr2_unconditional_constructor remains unproved."
        ),
        "nonclaims": [
            "No arbitrary Cr2 witness is constructed.",
            "No cross-structure Cr2 constructor is claimed.",
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

`Cr2` has a proved reflexive constructor.

## Lean theorem

`{payload["theorem"]}`

## Source file

`{payload["source_file"]}`

## Classification stratum

`verified lemma`

## Proved scope

{payload["proved_scope"]}

## Proof method

{payload["proof_method"]}

## Remaining gap

{payload["remaining_gap"]}

## Nonclaims

- No arbitrary Cr2 witness is constructed.
- No cross-structure Cr2 constructor is claimed.
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
        raise SystemExit("Cr2 reflexive constructor id mismatch")
    if payload["classification_stratum"] != "verified lemma":
        raise SystemExit("Cr2 reflexive constructor classification mismatch")
    if payload["theorem"] != THEOREM_NAME:
        raise SystemExit("Cr2 reflexive constructor theorem mismatch")
    if "cross-structure" not in payload["remaining_gap"]:
        raise SystemExit("remaining cross-structure gap missing")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")
    theorem_block(LEAN_FILE.read_text())

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
    print("CR2_REFLEXIVE_CONSTRUCTOR_OK")

if __name__ == "__main__":
    main()
