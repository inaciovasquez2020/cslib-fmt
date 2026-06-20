#!/usr/bin/env python3
import argparse
import json
from pathlib import Path

CERT_ID = "UNGUARDED_FO_GAIFMAN_GRAPH_DISTANCE_2026_06_20"
LEAN_FILE = Path("lean/CSLIB/FMT/UnguardedFO/Gaifman.lean")
PREVIOUS_LAYER = Path("lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean")
ARTIFACT = Path("artifacts/cslib_fmt/unguarded_fo_gaifman_graph_distance_2026_06_20.json")
DOC = Path("docs/status/UNGUARDED_FO_GAIFMAN_GRAPH_DISTANCE_2026_06_20.md")

REQUIRED_LEAN_TERMS = [
    "def RelationTupleContains",
    "def SameRelationTuple",
    "theorem same_relation_tuple_symmetric",
    "def GaifmanAdjacent",
    "theorem gaifman_adjacent_symmetric",
    "inductive GaifmanWalk",
    "def GaifmanDistanceLe",
    "def GaifmanConnected",
    "theorem gaifman_distanceLe_refl",
    "theorem gaifman_connected_refl",
    "structure FiniteRelStructure",
    "def FiniteRelStructure.gaifmanAdjacent",
    "def FiniteRelStructure.gaifmanDistanceLe",
    "theorem finite_gaifman_distanceLe_refl",
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
    if not PREVIOUS_LAYER.exists():
        raise SystemExit(f"MISSING_PREVIOUS_LAYER := {PREVIOUS_LAYER}")
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
        "status": "Gaifman graph and distance layer added",
        "source_file": str(LEAN_FILE),
        "depends_on": str(PREVIOUS_LAYER),
        "standalone_reason": "Current package has no importable CSLIB module root; Gaifman layer is direct-checked as a standalone frontier module while retaining the same namespace.",
        "classification_stratum": "definition layer with basic verified lemmas",
        "definitions": [
            "RelationTupleContains",
            "SameRelationTuple",
            "GaifmanAdjacent",
            "GaifmanWalk",
            "GaifmanDistanceLe",
            "GaifmanConnected",
            "FiniteRelStructure",
            "FiniteRelStructure.gaifmanAdjacent",
            "FiniteRelStructure.gaifmanDistanceLe",
        ],
        "verified_lemmas": [
            "same_relation_tuple_symmetric",
            "gaifman_adjacent_symmetric",
            "gaifman_distanceLe_refl",
            "gaifman_connected_refl",
            "finite_gaifman_distanceLe_refl",
        ],
        "next_target": "unguarded FO locality input surface",
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

The second general-FMT frontier layer is present: Gaifman graph and bounded distance
for arbitrary finite relational structures.

## Source file

`{payload["source_file"]}`

## Depends on

`{payload["depends_on"]}`

## Standalone reason

{payload["standalone_reason"]}

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
        raise SystemExit("Gaifman graph distance id mismatch")
    if payload["status"] != "Gaifman graph and distance layer added":
        raise SystemExit("Gaifman graph distance status mismatch")
    if payload["source_file"] != str(LEAN_FILE):
        raise SystemExit("source file mismatch")
    if payload["depends_on"] != str(PREVIOUS_LAYER):
        raise SystemExit("previous layer mismatch")
    if payload["next_target"] != "unguarded FO locality input surface":
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
    print("UNGUARDED_FO_GAIFMAN_GRAPH_DISTANCE_OK")

if __name__ == "__main__":
    main()
