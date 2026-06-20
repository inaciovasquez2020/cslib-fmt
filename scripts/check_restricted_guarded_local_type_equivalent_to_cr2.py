#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "RESTRICTED_GUARDED_LOCAL_TYPE_EQUIVALENT_TO_CR2_2026_06_20"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/restricted_guarded_local_type_equivalent_to_cr2_2026_06_20.json")
DOC = Path("docs/status/RESTRICTED_GUARDED_LOCAL_TYPE_EQUIVALENT_TO_CR2_2026_06_20.md")

THEOREM_NAME = "restricted_guarded_local_type_equivalent_to_cr2"

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
        raise SystemExit("MISSING_OBJECT := end GuardedLocality after restricted guarded constructor")
    return text[m.start():end]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()
    block = theorem_block(text)

    required = [
        "structure Cr2",
        "def RestrictedGuardedLocalTypeEquivalent",
        "structure RestrictedEFGameLocalTypeInvariantInputSurface",
        "theorem restricted_guarded_local_type_equivalent_to_restricted_ef_game_local_type_invariant_input_surface",
        "theorem restricted_guarded_local_type_equivalent_to_cr2",
    ]
    for item in required:
        if item not in text:
            raise SystemExit(f"MISSING_OBJECT := {item}")

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in block:
            raise SystemExit(f"forbidden Lean token in constructor := {token.strip()}")

    if "RestrictedGuardedLocalTypeEquivalent 𝒜 ℬ r a b" not in block:
        raise SystemExit("missing exact restricted guarded local-type equivalence hypothesis")

    if "restricted_guarded_local_type_equivalent_to_restricted_ef_game_local_type_invariant_input_surface" not in block:
        raise SystemExit("constructor must use existing restricted EF-game input-surface bridge")

    return {
        "id": CERT_ID,
        "status": "restricted guarded local-type equivalence to Cr2 constructor",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "conditional theorem",
        "theorem": THEOREM_NAME,
        "input_surface": "RestrictedGuardedLocalTypeEquivalent",
        "output_surface": "Cr2",
        "proof_route": "RestrictedGuardedLocalTypeEquivalent → RestrictedEFGameLocalTypeInvariantInputSurface → Cr2",
        "remaining_gap": "An arbitrary cross-structure Cr2 constructor without a restricted guarded local-type equivalence hypothesis remains unproved.",
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

A constructor from restricted guarded local-type equivalence to `Cr2` is proved.

## Lean theorem

`{payload["theorem"]}`

## Source file

`{payload["source_file"]}`

## Classification stratum

`conditional theorem`

## Proof route

{payload["proof_route"]}

## Remaining gap

{payload["remaining_gap"]}

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
        raise SystemExit("restricted guarded local-type equivalence to Cr2 id mismatch")
    if payload["classification_stratum"] != "conditional theorem":
        raise SystemExit("classification stratum mismatch")
    if payload["theorem"] != THEOREM_NAME:
        raise SystemExit("theorem name mismatch")
    if payload["input_surface"] != "RestrictedGuardedLocalTypeEquivalent":
        raise SystemExit("input surface mismatch")
    if payload["output_surface"] != "Cr2":
        raise SystemExit("output surface mismatch")
    if "without a restricted guarded local-type equivalence hypothesis" not in payload["remaining_gap"]:
        raise SystemExit("remaining arbitrary constructor gap missing")
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
    print("RESTRICTED_GUARDED_LOCAL_TYPE_EQUIVALENT_TO_CR2_OK")

if __name__ == "__main__":
    main()
