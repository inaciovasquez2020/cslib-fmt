#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "GUARDED_LOCALITY_BOUNDARY_CONDITIONAL_LEMMA_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/guarded_locality_boundary_conditional_lemma_2026_06_19.json")
DOC = Path("docs/status/GUARDED_LOCALITY_BOUNDARY_CONDITIONAL_LEMMA_2026_06_19.md")

THEOREM_NAME = "guarded_locality_boundary_conditional_lemma"

REQUIRED_SUPPORT = [
    "RestrictedEFGameLocalTypeInvariantInputSurface",
    "RestrictedGuardedLocalTypeEquivalent",
    "RestrictedGuardedFO",
    "restrictedSat",
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

def theorem_block(text: str) -> str:
    m = re.search(r"theorem\s+" + re.escape(THEOREM_NAME) + r"\b", text)
    if not m:
        raise SystemExit(f"MISSING_OBJECT := theorem {THEOREM_NAME}")
    end = text.find("\nend GuardedLocality", m.start())
    if end == -1:
        raise SystemExit("MISSING_OBJECT := end GuardedLocality after guarded boundary lemma")
    return text[m.start():end]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()
    block = theorem_block(text)

    missing = [item for item in REQUIRED_SUPPORT if item not in text]
    if missing:
        raise SystemExit("MISSING_OBJECT := " + ", ".join(missing))

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in block:
            raise SystemExit(f"forbidden Lean token in lemma block := {token.strip()}")

    if "h.invariant φ" not in block:
        raise SystemExit("missing explicit use of existing invariant hypothesis")

    return {
        "id": CERT_ID,
        "status": "guarded locality boundary conditional lemma",
        "source_file": str(LEAN_FILE),
        "theorem": THEOREM_NAME,
        "classification_stratum": "conditional theorem",
        "hypothesis_surface": "RestrictedEFGameLocalTypeInvariantInputSurface",
        "formula_scope": "RestrictedGuardedFO r",
        "semantic_scope": "restrictedSat invariance only",
        "supporting_existing_symbols": REQUIRED_SUPPORT,
        "nonclaims": [
            "No unguarded FO locality theorem is claimed.",
            "No full Gaifman locality theorem is claimed.",
            "No Fagin theorem or 0-1 Law result is claimed.",
            "No repository-level final FMT closure is claimed.",
            "No external validation claim is made.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.write_text(f"""# {CERT_ID}

## Status

This is a bounded guarded-locality boundary conditional lemma.

## Lean theorem

`{payload["theorem"]}`

## Source file

`{payload["source_file"]}`

## Classification stratum

`conditional theorem`

## Hypothesis surface

`{payload["hypothesis_surface"]}`

## Formula scope

`{payload["formula_scope"]}`

## Semantic scope

`{payload["semantic_scope"]}`

## Nonclaims

- No unguarded FO locality theorem is claimed.
- No full Gaifman locality theorem is claimed.
- No Fagin theorem or 0-1 Law result is claimed.
- No repository-level final FMT closure is claimed.
- No external validation claim is made.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("certificate id mismatch")
    if payload["classification_stratum"] != "conditional theorem":
        raise SystemExit("classification stratum mismatch")
    if payload["theorem"] != THEOREM_NAME:
        raise SystemExit("theorem name mismatch")
    if payload["hypothesis_surface"] != "RestrictedEFGameLocalTypeInvariantInputSurface":
        raise SystemExit("hypothesis surface mismatch")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

    text = LEAN_FILE.read_text()
    theorem_block(text)

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
    print("GUARDED_LOCALITY_BOUNDARY_CONDITIONAL_LEMMA_OK")

if __name__ == "__main__":
    main()
