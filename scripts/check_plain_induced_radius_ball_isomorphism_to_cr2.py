#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "PLAIN_INDUCED_RADIUS_BALL_ISOMORPHISM_TO_CR2_2026_06_19"
THEOREM = "plain_induced_radius_ball_isomorphism_to_cr2"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/plain_induced_radius_ball_isomorphism_to_cr2_2026_06_19.json")
DOC = Path("docs/status/PLAIN_INDUCED_RADIUS_BALL_ISOMORPHISM_TO_CR2_2026_06_19.md")

BOUNDARIES = [
    "BOUNDARY := ¬ cr2_unconditional_constructor",
    "BOUNDARY := ¬ arbitrary Cr2 witness",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ repository-level final FMT closure",
]

def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(message)

def theorem_body(text: str) -> str:
    m = re.search(
        rf"theorem\s+{THEOREM}\b(?P<body>.*?)(?=\n/--|\ntheorem\s+|\nend\s+GuardedLocality)",
        text,
        re.S,
    )
    require(m is not None, f"MISSING_OBJECT := theorem {THEOREM}")
    return m.group("body")

def verify_lean_surface() -> None:
    text = LEAN_FILE.read_text()
    body = theorem_body(text)

    required = [
        "PlainInducedRadiusBallIso",
        "Cr2",
        "restricted_ef_game_local_type_invariant_input_surface_to_cr2",
        "plain_induced_radius_ball_isomorphism_to_restricted_ef_game_local_type_invariant_input_surface",
    ]
    for token in required:
        require(token in body, f"MISSING_OBJECT := {token}")

    for forbidden in ["axiom", "opaque", "sorry", "admit"]:
        require(not re.search(rf"\b{forbidden}\b", body), f"forbidden Lean token := {forbidden}")

    require(
        not re.search(r"^\s*theorem\s+cr2_unconditional_constructor\b", text, re.M),
        "BOUNDARY_STALE := cr2_unconditional_constructor already exists",
    )

def make_payload() -> dict:
    verify_lean_surface()
    return {
        "id": CERT_ID,
        "status": "intermediate Cr2 theorem target",
        "classification_stratum": "conditional_constructor_theorem",
        "theorem": THEOREM,
        "source_surface": "PlainInducedRadiusBallIso",
        "target_surface": "Cr2",
        "proof_path": [
            "PlainInducedRadiusBallIso",
            "RestrictedEFGameLocalTypeInvariantInputSurface",
            "Cr2",
        ],
        "strictly_weaker_than": "cr2_unconditional_constructor",
        "strictly_stronger_than": "restricted_ef_game_local_type_invariant_input_surface_to_cr2",
        "reason": "The theorem starts from a concrete plain induced radius-ball isomorphism rather than an already-packaged restricted input witness, but it still requires that concrete hypothesis and does not construct Cr2 unconditionally.",
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.parent.mkdir(parents=True, exist_ok=True)
    DOC.write_text(f"""# {CERT_ID}

## Status

Intermediate Cr2 theorem target.

## Lean theorem

`{THEOREM}`

## Source surface

`PlainInducedRadiusBallIso`

## Target surface

`Cr2`

## Proof path

`PlainInducedRadiusBallIso → RestrictedEFGameLocalTypeInvariantInputSurface → Cr2`

## Rank

Strictly weaker than `cr2_unconditional_constructor`.

Strictly stronger than `restricted_ef_game_local_type_invariant_input_surface_to_cr2`.

## Boundary

This theorem still requires a concrete plain induced radius-ball isomorphism hypothesis. It does not construct `Cr2` unconditionally.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    require(payload["id"] == CERT_ID, "certificate id mismatch")
    require(payload["theorem"] == THEOREM, "theorem mismatch")
    require(payload["source_surface"] == "PlainInducedRadiusBallIso", "source surface mismatch")
    require(payload["target_surface"] == "Cr2", "target surface mismatch")
    require(payload["strictly_weaker_than"] == "cr2_unconditional_constructor", "weaker-than target mismatch")
    require(
        payload["strictly_stronger_than"] == "restricted_ef_game_local_type_invariant_input_surface_to_cr2",
        "stronger-than target mismatch",
    )
    for boundary in BOUNDARIES:
        require(boundary in payload["boundaries"], f"missing boundary := {boundary}")
    verify_lean_surface()

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-report", action="store_true")
    args = parser.parse_args()

    if args.write_report:
        write_outputs(make_payload())

    require(ARTIFACT.exists(), f"MISSING_OBJECT := {ARTIFACT}")
    require(DOC.exists(), f"MISSING_OBJECT := {DOC}")
    verify_payload(json.loads(ARTIFACT.read_text()))
    print("PLAIN_INDUCED_RADIUS_BALL_ISOMORPHISM_TO_CR2_OK")

if __name__ == "__main__":
    main()
