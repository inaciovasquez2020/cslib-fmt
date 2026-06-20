#!/usr/bin/env python3
import argparse
import json
from pathlib import Path

CERT_ID = "UNGUARDED_FO_SYNTAX_SEMANTICS_2026_06_20"
LEAN_FILE = Path("lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean")
ARTIFACT = Path("artifacts/cslib_fmt/unguarded_fo_syntax_semantics_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_SYNTAX_SEMANTICS_2026_06_20.md")

REQUIRED_LEAN_TERMS = [
    "structure RelLanguage",
    "structure RelStructure",
    "inductive Formula",
    "abbrev Sentence",
    "def extendAssignment",
    "def emptyAssignment",
    "def Holds",
    "def Satisfies",
    "theorem holds_top",
    "theorem holds_bot",
    "theorem holds_eq",
    "theorem holds_conj",
    "theorem holds_disj",
    "theorem holds_ex",
]

FORBIDDEN_LEAN_TOKENS = ["axiom ", "opaque ", "sorry", "admit"]

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()

    for term in REQUIRED_LEAN_TERMS:
        if term not in text:
            raise SystemExit(f"MISSING_OBJECT := {term}")

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in text:
            raise SystemExit(f"forbidden Lean token := {token.strip()}")

    forbidden_positive = [
        "Fagin theorem proved",
        "0-1 Law proved",
        "unguarded FO locality proved",
        "full Gaifman locality proved",
        "general FMT frontier closed",
    ]
    for phrase in forbidden_positive:
        if phrase in text:
            raise SystemExit(f"FORBIDDEN_POSITIVE_CLAIM := {phrase}")

    return {
        "id": CERT_ID,
        "status": "unguarded FO syntax and semantics layer added",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "definition layer with basic verified simp lemmas",
        "definitions": [
            "RelLanguage",
            "RelStructure",
            "Formula",
            "Sentence",
            "extendAssignment",
            "emptyAssignment",
            "Holds",
            "Satisfies",
        ],
        "verified_lemmas": [
            "holds_top",
            "holds_bot",
            "holds_eq",
            "holds_conj",
            "holds_disj",
            "holds_ex",
        ],
        "next_target": "Gaifman graph and distance for arbitrary finite structures",
        "nonclaims": [
            "Does not claim general FMT closure.",
            "Does not claim Fagin theorem.",
            "Does not claim 0-1 Law.",
            "Does not claim full Gaifman locality.",
            "Does not claim unguarded FO locality.",
            "Does not claim external validation.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    definitions = "\n".join(f"- `{name}`" for name in payload["definitions"])
    lemmas = "\n".join(f"- `{name}`" for name in payload["verified_lemmas"])

    DOC.write_text(f"""# {CERT_ID}

## Status

The first general-FMT frontier layer is present: unguarded FO syntax and semantics.

## Source file

`{payload["source_file"]}`

## Classification stratum

{payload["classification_stratum"]}

## Definitions

{definitions}

## Verified lemmas

{lemmas}

## Next target

`{payload["next_target"]}`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality.
- Does not claim external validation.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("unguarded FO syntax semantics id mismatch")
    if payload["status"] != "unguarded FO syntax and semantics layer added":
        raise SystemExit("unguarded FO status mismatch")
    if payload["source_file"] != str(LEAN_FILE):
        raise SystemExit("source file mismatch")
    if payload["next_target"] != "Gaifman graph and distance for arbitrary finite structures":
        raise SystemExit("next target mismatch")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

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
    print("UNGUARDED_FO_SYNTAX_SEMANTICS_OK")

if __name__ == "__main__":
    main()
