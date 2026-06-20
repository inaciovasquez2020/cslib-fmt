#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CR2_RESTRICTED_CONSTRUCTOR_TARGET_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_restricted_constructor_target_2026_06_19.json")
DOC = Path("docs/status/CR2_RESTRICTED_CONSTRUCTOR_TARGET_2026_06_19.md")

THEOREM_NAME = "restricted_ef_game_local_type_invariant_input_surface_to_cr2"
BOUNDARIES = [
    "BOUNDARY := ¬ cr2_unconditional_constructor",
    "BOUNDARY := ¬ arbitrary Cr2 witness",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ repository-level final FMT closure",
]

FORBIDDEN = [
    "cr2_unconditional_constructor proved",
    "arbitrary Cr2 witness constructed",
    "unconditional closure input",
    "unguarded FO locality proved",
    "full Gaifman locality proved",
    "Fagin theorem proved",
    "0-1 Law proved",
    "repository-level final FMT closure proved",
]

def require_theorem(text: str) -> str:
    m = re.search(
        r"theorem\s+restricted_ef_game_local_type_invariant_input_surface_to_cr2\b(?P<body>.*?)(?=\n/--|\ntheorem\s+|\nend\s+GuardedLocality)",
        text,
        re.S,
    )
    if not m:
        raise SystemExit(f"MISSING_OBJECT := theorem {THEOREM_NAME}")
    body = m.group("body")
    required = [
        "RestrictedEFGameLocalTypeInvariantInputSurface",
        "Cr2",
        "exact ⟨h⟩",
    ]
    for token in required:
        if token not in body:
            raise SystemExit(f"MISSING_OBJECT := {token}")
    for token in ["axiom", "opaque", "sorry", "admit"]:
        if re.search(rf"\b{token}\b", body):
            raise SystemExit(f"forbidden Lean token in restricted Cr2 constructor target := {token}")
    return body

def make_payload() -> dict:
    text = LEAN_FILE.read_text()
    require_theorem(text)
    return {
        "id": CERT_ID,
        "status": "restricted constructor target weaker than cr2_unconditional_constructor",
        "classification_stratum": "restricted_theorem_target",
        "theorem": THEOREM_NAME,
        "source_surface": "RestrictedEFGameLocalTypeInvariantInputSurface",
        "target_surface": "Cr2",
        "proof_shape": "packages an existing restricted input witness as Cr2 via exact ⟨h⟩",
        "strictly_weaker_than": "cr2_unconditional_constructor",
        "boundary": "This theorem does not construct Cr2 for arbitrary structures, radius, and points without a restricted input witness.",
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.parent.mkdir(parents=True, exist_ok=True)
    DOC.write_text(f"""# {CERT_ID}

## Status

Restricted constructor target weaker than `cr2_unconditional_constructor`.

## Lean theorem

`{THEOREM_NAME}`

## Source surface

`RestrictedEFGameLocalTypeInvariantInputSurface`

## Target surface

`Cr2`

## Proof shape

The theorem packages an existing restricted input witness as `Cr2` via `exact ⟨h⟩`.

## Boundary

This theorem does not construct `Cr2` for arbitrary structures, radius, and points without a restricted input witness.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("Cr2 restricted constructor target id mismatch")
    if payload["classification_stratum"] != "restricted_theorem_target":
        raise SystemExit("Cr2 restricted constructor classification mismatch")
    if payload["theorem"] != THEOREM_NAME:
        raise SystemExit("Cr2 restricted constructor theorem mismatch")
    if payload["source_surface"] != "RestrictedEFGameLocalTypeInvariantInputSurface":
        raise SystemExit("Cr2 restricted constructor source mismatch")
    if payload["target_surface"] != "Cr2":
        raise SystemExit("Cr2 restricted constructor target mismatch")
    if "without a restricted input witness" not in payload["boundary"]:
        raise SystemExit("Cr2 restricted constructor boundary missing")
    joined = json.dumps(payload)
    for forbidden in FORBIDDEN:
        if forbidden in joined:
            raise SystemExit(f"forbidden overclaim := {forbidden}")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")
    require_theorem(LEAN_FILE.read_text())

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-report", action="store_true")
    args = parser.parse_args()

    if args.write_report:
        write_outputs(make_payload())

    if not ARTIFACT.exists():
        raise SystemExit(f"MISSING_OBJECT := {ARTIFACT}")
    if not DOC.exists():
        raise SystemExit(f"MISSING_OBJECT := {DOC}")

    verify_payload(json.loads(ARTIFACT.read_text()))
    print("CR2_RESTRICTED_CONSTRUCTOR_TARGET_OK")

if __name__ == "__main__":
    main()
