#!/usr/bin/env python3
import argparse
import json
from pathlib import Path

CERT_ID = "UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_TARGET_2026_06_20"
LEAN_FILE = Path("lean/CSLIB/FMT/UnguardedFO/FormulaRadiusConstructionTarget.lean")
PREVIOUS_LAYERS = [
    Path("lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean"),
    Path("lean/CSLIB/FMT/UnguardedFO/Gaifman.lean"),
    Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"),
]
ARTIFACT = Path("artifacts/cslib_fmt/unguarded_fo_formula_radius_construction_target_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_TARGET_2026_06_20.md")

REQUIRED_LEAN_TERMS = [
    "def FormulaQuantifierDepth",
    "structure BoundedSyntacticFragment",
    "structure FormulaRadiusConstructionTarget",
    "def formula_radius_construction_target_has_radius",
    "theorem formula_radius_construction_target_radius_le",
    "theorem formula_radius_construction_target_input",
]

FORBIDDEN_LEAN_TOKENS = ["axiom ", "opaque ", "sorry", "admit", "constant "]

FORBIDDEN_POSITIVE_CLAIMS = [
    "Fagin theorem proved",
    "0-1 Law proved",
    "unguarded FO locality proved",
    "full Gaifman locality proved",
    "general FMT frontier closed",
    "constructs radii for every bounded syntactic fragment",
]

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality theorem",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ formula-radius construction theorem",
    "BOUNDARY := ¬ external validation claim",
]

def build_payload() -> dict:
    for p in PREVIOUS_LAYERS:
        if not p.exists():
            raise SystemExit(f"MISSING_PREVIOUS_LAYER := {p}")
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()

    for term in REQUIRED_LEAN_TERMS:
        if term not in text:
            raise SystemExit(f"MISSING_OBJECT := {term}")

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in text:
            raise SystemExit(f"forbidden Lean token := {token.strip()}")

    for phrase in FORBIDDEN_POSITIVE_CLAIMS:
        if phrase in text:
            raise SystemExit(f"FORBIDDEN_POSITIVE_CLAIM := {phrase}")

    if "does not prove that such a target" not in text:
        raise SystemExit("missing construction-target nonclaim in Lean docstring")

    return {
        "id": CERT_ID,
        "status": "formula-radius construction target added for bounded syntactic fragments",
        "source_file": str(LEAN_FILE),
        "depends_on": [str(p) for p in PREVIOUS_LAYERS],
        "standalone_reason": (
            "Current package layout has no importable CSLIB module root; this frontier layer is direct-checked as a standalone module."
        ),
        "classification_stratum": "construction target surface with extraction lemmas",
        "definitions": [
            "FormulaQuantifierDepth",
            "BoundedSyntacticFragment",
            "FormulaRadiusConstructionTarget",
        ],
        "extraction_lemmas": [
            "formula_radius_construction_target_has_radius",
            "formula_radius_construction_target_radius_le",
            "formula_radius_construction_target_input",
        ],
        "next_target": "bounded-fragment atomic and Boolean radius constructors",
        "nonclaims": [
            "Does not claim general FMT closure.",
            "Does not claim Fagin theorem.",
            "Does not claim 0-1 Law.",
            "Does not claim full Gaifman locality.",
            "Does not claim unguarded FO locality theorem.",
            "Does not claim formula-radius construction theorem.",
            "Does not claim external validation.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    deps = "\n".join(f"- `{p}`" for p in payload["depends_on"])
    definitions = "\n".join(f"- `{name}`" for name in payload["definitions"])
    lemmas = "\n".join(f"- `{name}`" for name in payload["extraction_lemmas"])

    DOC.write_text(f"""# {CERT_ID}

## Status

The formula-radius construction target for bounded syntactic fragments is present.

This does not construct locality radii. It defines the target shape for a future
bounded-fragment radius construction.

## Source file

`{payload["source_file"]}`

## Depends on

{deps}

## Standalone reason

{payload["standalone_reason"]}

## Classification stratum

{payload["classification_stratum"]}

## Definitions

{definitions}

## Extraction lemmas

{lemmas}

## Next target

`{payload["next_target"]}`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality theorem.
- Does not claim formula-radius construction theorem.
- Does not claim external validation.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("formula-radius construction target id mismatch")
    if payload["status"] != "formula-radius construction target added for bounded syntactic fragments":
        raise SystemExit("status mismatch")
    if payload["source_file"] != str(LEAN_FILE):
        raise SystemExit("source file mismatch")
    if payload["next_target"] != "bounded-fragment atomic and Boolean radius constructors":
        raise SystemExit("next target mismatch")
    if "construction target surface" not in payload["classification_stratum"]:
        raise SystemExit("classification stratum mismatch")
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
    print("UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_TARGET_OK")

if __name__ == "__main__":
    main()
