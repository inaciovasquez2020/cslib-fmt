#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "CR2_EXACT_TARGET_SURFACE_2026_06_19"
LEAN_FILE = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_exact_target_surface_2026_06_19.json")
DOC = Path("docs/status/CR2_EXACT_TARGET_SURFACE_2026_06_19.md")

FINAL_BOUNDED_STATUS = (
    "Distance/factorization surface closed constructively; guarded locality pipeline closed in the bounded/restricted sense "
    "with explicit conditional hypotheses; directed symmetry treated as archival-only; noncomputable surface documented without "
    "constructivization obligation; unguarded frontier boundary witnessed by negative test object only; general FMT frontier, "
    "unguarded FO locality, Fagin, 0-1 Law, and all external validation remain permanently open and out of scope."
)

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

FORBIDDEN_LEAN_TOKENS = ["axiom ", "opaque ", "sorry", "admit"]

def cr2_block(text: str) -> str:
    m = re.search(r"structure\s+Cr2\b", text)
    if not m:
        raise SystemExit("MISSING_OBJECT := structure Cr2")
    end = text.find("\nend GuardedLocality", m.start())
    if end == -1:
        raise SystemExit("MISSING_OBJECT := end GuardedLocality after Cr2")
    return text[m.start():end]

def build_payload() -> dict:
    if not LEAN_FILE.exists():
        raise SystemExit(f"MISSING_OBJECT := {LEAN_FILE}")
    text = LEAN_FILE.read_text()
    block = cr2_block(text)

    for token in FORBIDDEN_LEAN_TOKENS:
        if token in block:
            raise SystemExit(f"forbidden Lean token in Cr2 block := {token.strip()}")

    required = [
        "structure Cr2",
        "RestrictedEFGameLocalTypeInvariantInputSurface",
        "input :",
    ]
    for item in required:
        if item not in block:
            raise SystemExit(f"MISSING_OBJECT := {item}")

    return {
        "id": CERT_ID,
        "status": "Cr2 exact bounded target surface",
        "source_file": str(LEAN_FILE),
        "classification_stratum": "specification",
        "cr2_attaches_to": "RestrictedEFGameLocalTypeInvariantInputSurface",
        "conditionality": "Cr2 is a target/input surface until its input field is constructed without new hypotheses.",
        "final_bounded_status_phrase": FINAL_BOUNDED_STATUS,
        "nonclaims": [
            "Cr2 does not by itself prove unguarded FO locality.",
            "Cr2 does not by itself prove full Gaifman locality.",
            "Cr2 does not by itself prove Fagin theorem or 0-1 Law.",
            "Cr2 does not by itself prove repository-level final FMT closure.",
            "Cr2 does not assert external validation.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.write_text(f"""# {CERT_ID}

## Status

`Cr2` is the exact bounded target/input surface for the restricted guarded-locality closure attempt.

## Lean object

`structure Cr2`

## Source file

`{payload["source_file"]}`

## Attaches to

`{payload["cr2_attaches_to"]}`

## Conditionality

{payload["conditionality"]}

## Final bounded status phrase

{payload["final_bounded_status_phrase"]}

## Nonclaims

- Cr2 does not by itself prove unguarded FO locality.
- Cr2 does not by itself prove full Gaifman locality.
- Cr2 does not by itself prove Fagin theorem or 0-1 Law.
- Cr2 does not by itself prove repository-level final FMT closure.
- Cr2 does not assert external validation.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != CERT_ID:
        raise SystemExit("Cr2 certificate id mismatch")
    if payload["classification_stratum"] != "specification":
        raise SystemExit("Cr2 classification stratum mismatch")
    if payload["cr2_attaches_to"] != "RestrictedEFGameLocalTypeInvariantInputSurface":
        raise SystemExit("Cr2 target mismatch")
    if "without new hypotheses" not in payload["conditionality"]:
        raise SystemExit("Cr2 conditionality boundary missing")
    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")
    cr2_block(LEAN_FILE.read_text())

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
    print("CR2_EXACT_TARGET_SURFACE_OK")

if __name__ == "__main__":
    main()
