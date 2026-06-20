#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CURRENT_STRONGEST_CR2_INPUT_SURFACE_LOCK_2026_06_20"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/current_strongest_cr2_input_surface_lock_2026_06_20.json")
DOC = Path("docs/status/CURRENT_STRONGEST_CR2_INPUT_SURFACE_LOCK_2026_06_20.md")

CURRENT_STRONGEST = "restricted_ef_game_local_type_invariant_input_surface_to_cr2"
CURRENT_INPUT = "RestrictedEFGameLocalTypeInvariantInputSurface"

KNOWN_ALLOWED_CR2_ROUTES = [
    "restricted_ef_game_local_type_invariant_input_surface_to_cr2",
    "restricted_guarded_local_type_equivalent_to_cr2",
    "plain_induced_radius_ball_isomorphism_to_cr2",
    "pointed_radius_ball_equiv_to_cr2",
    "localIso_to_cr2",
    "cr2_reflexive_constructor",
    "cr2_discharges_guarded_locality_input",
    "cr2_restricted_guarded_formula_invariant",
]

STRICTLY_STRONGER_INPUTS_THAN_CURRENT = [
    "RestrictedGuardedLocalTypeEquivalent",
    "PlainInducedRadiusBallIso",
    "PointedRadiusBallEquiv",
    "BallIso",
    "LocalIso",
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

DECL_RE = re.compile(r"^\s*(theorem|def|structure|inductive)\s+([A-Za-z0-9_'.]+)\b", re.M)

def theorem_blocks(text: str) -> dict[str, str]:
    matches = list(DECL_RE.finditer(text))
    blocks = {}
    for i, m in enumerate(matches):
        kind, name = m.group(1), m.group(2)
        if kind != "theorem":
            continue
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        blocks[name] = text[m.start():end]
    return blocks

def cr2_related_theorems(text: str) -> dict[str, str]:
    blocks = theorem_blocks(text)
    return {
        name: block for name, block in blocks.items()
        if "Cr2 " in block or name.endswith("_to_cr2") or name.startswith("cr2_")
    }

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")

    text = LEAN_FILE.read_text()

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in text:
            raise SystemExit(f"forbidden Lean token in guarded-locality pipeline := {token.strip()}")

    required = [
        "structure Cr2",
        "structure RestrictedEFGameLocalTypeInvariantInputSurface",
        "theorem restricted_ef_game_local_type_invariant_input_surface_to_cr2",
        "theorem restricted_guarded_local_type_equivalent_to_cr2",
    ]
    for item in required:
        if item not in text:
            raise SystemExit(f"MISSING_OBJECT := {item}")

    blocks = cr2_related_theorems(text)
    names = sorted(blocks)

    unknown = [
        name for name in names
        if name not in KNOWN_ALLOWED_CR2_ROUTES
    ]
    if unknown:
        raise SystemExit("POTENTIAL_UNCLASSIFIED_CR2_SURFACE := " + ", ".join(unknown))

    current_block = blocks.get(CURRENT_STRONGEST, "")
    if CURRENT_INPUT not in current_block:
        raise SystemExit("current strongest Cr2 constructor missing exact input surface")

    if "Cr2 𝒜 ℬ r a b" not in current_block:
        raise SystemExit("current strongest Cr2 constructor target mismatch")

    for name, block in blocks.items():
        if name in {
            CURRENT_STRONGEST,
            "cr2_reflexive_constructor",
            "cr2_discharges_guarded_locality_input",
            "cr2_restricted_guarded_formula_invariant",
        }:
            continue

        if "Cr2 " in block:
            if CURRENT_INPUT in block:
                raise SystemExit(f"DUPLICATE_CURRENT_STRONGEST_CR2_SURFACE := {name}")
            if not any(surface in block for surface in STRICTLY_STRONGER_INPUTS_THAN_CURRENT):
                raise SystemExit(f"POTENTIAL_WEAKER_THAN_INPUT_SURFACE_CR2_SURFACE := {name}")

    return {
        "id": CERT_ID,
        "status": "current strongest bounded Cr2 constructor lock",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "specification",
        "current_strongest_constructor": CURRENT_STRONGEST,
        "current_strongest_input_surface": CURRENT_INPUT,
        "strictly_stronger_constructor_inputs_already_classified": STRICTLY_STRONGER_INPUTS_THAN_CURRENT,
        "proved_reflexive_constructor": "cr2_reflexive_constructor",
        "inspected_cr2_theorem_surfaces": names,
        "result": (
            "The existing RestrictedEFGameLocalTypeInvariantInputSurface → Cr2 constructor is the current strongest bounded constructor found."
        ),
        "remaining_gap": (
            "No existing weaker-than-RestrictedEFGameLocalTypeInvariantInputSurface constructor to Cr2 was found; an arbitrary cross-structure Cr2 constructor remains unproved."
        ),
        "nonclaims": [
            "No arbitrary Cr2 witness is constructed.",
            "No weaker existing Cr2 input surface is claimed.",
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

    surfaces = "\n".join(f"- `{name}`" for name in payload["inspected_cr2_theorem_surfaces"])
    stronger = "\n".join(f"- `{name}`" for name in payload["strictly_stronger_constructor_inputs_already_classified"])

    DOC.write_text(f"""# {CERT_ID}

## Status

This locks the current strongest bounded `Cr2` constructor found in the existing surface ladder.

## Current strongest constructor

`{payload["current_strongest_constructor"]}`

## Current strongest input surface

`{payload["current_strongest_input_surface"]}`

## Strictly stronger constructor inputs already classified

{stronger}

## Proved reflexive constructor

`{payload["proved_reflexive_constructor"]}`

## Inspected `Cr2` theorem surfaces

{surfaces}

## Result

{payload["result"]}

## Remaining gap

{payload["remaining_gap"]}

## Nonclaims

- No arbitrary Cr2 witness is constructed.
- No weaker existing Cr2 input surface is claimed.
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
        raise SystemExit("current strongest Cr2 input surface lock id mismatch")
    if payload["classification_stratum"] != "specification":
        raise SystemExit("classification stratum mismatch")
    if payload["current_strongest_constructor"] != CURRENT_STRONGEST:
        raise SystemExit("current strongest constructor mismatch")
    if payload["current_strongest_input_surface"] != CURRENT_INPUT:
        raise SystemExit("current strongest input surface mismatch")
    if "No existing weaker-than-RestrictedEFGameLocalTypeInvariantInputSurface" not in payload["remaining_gap"]:
        raise SystemExit("missing no-weaker-than-input-surface result")
    if "guarded_locality_boundary_conditional_lemma" in payload["inspected_cr2_theorem_surfaces"]:
        raise SystemExit("parser regression := non-Cr2 theorem classified as Cr2 surface")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

    fresh = build_payload()
    if fresh["inspected_cr2_theorem_surfaces"] != payload["inspected_cr2_theorem_surfaces"]:
        raise SystemExit("inspected Cr2 theorem surfaces changed")

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
    print("CURRENT_STRONGEST_CR2_INPUT_SURFACE_LOCK_OK")

if __name__ == "__main__":
    main()
