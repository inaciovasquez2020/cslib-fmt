#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "GENERAL_FMT_FRONTIER_FIRST_ATTACK_LEDGER_2026_06_20"
PUBLIC_ROOTS = [
    Path("lean/CSLIB"),
    Path("docs/status"),
    Path("artifacts/cslib_fmt"),
]
ARTIFACT = Path("artifacts/cslib_fmt/general_fmt_frontier_first_attack_ledger_2026_06_20.json")
DOC = Path("docs/status/GENERAL_FMT_FRONTIER_FIRST_ATTACK_LEDGER_2026_06_20.md")

REQUIRED_CURRENT_LOCKS = [
    "CURRENT_STRONGEST_CR2_INPUT_SURFACE_LOCK_2026_06_20",
    "CR2_REFLEXIVE_CONSTRUCTOR_2026_06_19",
    "RESTRICTED_GUARDED_LOCAL_TYPE_EQUIVALENT_TO_CR2_2026_06_20",
]

FORBIDDEN_POSITIVE_CLAIM_PATTERNS = [
    r"\bgeneral\s+FMT\s+frontier\s+(?:is\s+)?closed\b",
    r"\bgeneral\s+finite[- ]model[- ]theory\s+frontier\s+(?:is\s+)?closed\b",
    r"\bFagin(?:'s)?\s+theorem\s+(?:is\s+)?proved\b",
    r"\b0-1\s+Law\s+(?:is\s+)?proved\b",
    r"\bzero-one\s+law\s+(?:is\s+)?proved\b",
    r"\bunguarded\s+FO\s+locality\s+(?:is\s+)?proved\b",
    r"\bfull\s+Gaifman\s+locality\s+(?:is\s+)?proved\b",
]

NEGATIVE_CONTEXT = [
    "not ",
    "does not ",
    "no ",
    "¬ ",
    "open",
    "out of scope",
    "remain permanently open",
    "remains unproved",
    "boundary",
    "nonclaim",
    "nonclaims",
    "forbidden",
]

ATTACK_ORDER = [
    {
        "rank": 1,
        "target": "Unguarded FO syntax and semantics",
        "status": "missing-or-unlocked target surface",
        "reason": "Cr2 is restricted guarded-locality machinery; general FMT first needs an unguarded FO language layer.",
    },
    {
        "rank": 2,
        "target": "Gaifman graph and distance for arbitrary finite structures",
        "status": "missing-or-unlocked target surface",
        "reason": "Unguarded FO locality requires structure-level locality geometry, not only the restricted guarded surface.",
    },
    {
        "rank": 3,
        "target": "Unguarded FO locality",
        "status": "open",
        "reason": "This is the closest global frontier theorem to the current guarded-locality work.",
    },
    {
        "rank": 4,
        "target": "Fagin theorem",
        "status": "open",
        "reason": "Requires ESO/NP encoding and finite-structure complexity machinery.",
    },
    {
        "rank": 5,
        "target": "0-1 Law",
        "status": "open",
        "reason": "Requires random finite structure/probability asymptotic layer.",
    },
]

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

def iter_public_files():
    skipped = {ARTIFACT, DOC}
    for root in PUBLIC_ROOTS:
        if not root.exists():
            continue
        for p in root.rglob("*"):
            if p in skipped:
                continue
            if p.is_file() and p.suffix in {".lean", ".md", ".json"}:
                yield p

def read_public_text() -> str:
    chunks = []
    for p in iter_public_files():
        chunks.append(f"\n--- {p} ---\n")
        chunks.append(p.read_text(errors="ignore"))
    return "\n".join(chunks)

def positive_claim_found(text: str, pattern: str) -> bool:
    rx = re.compile(pattern, re.I)
    for m in rx.finditer(text):
        window = text[max(0, m.start() - 160):m.end() + 160].lower()
        if any(marker in window for marker in NEGATIVE_CONTEXT):
            continue
        return True
    return False

def build_payload() -> dict:
    text = read_public_text()
    lowered = text.lower()

    for lock in REQUIRED_CURRENT_LOCKS:
        if lock.lower() not in lowered:
            raise SystemExit(f"MISSING_CURRENT_LOCK := {lock}")

    for pattern in FORBIDDEN_POSITIVE_CLAIM_PATTERNS:
        if positive_claim_found(text, pattern):
            raise SystemExit(f"FORBIDDEN_POSITIVE_SOLVED_CLAIM_PATTERN := {pattern}")

    has_cr2_lock = "RestrictedEFGameLocalTypeInvariantInputSurface → Cr2" in text or "RestrictedEFGameLocalTypeInvariantInputSurface" in text
    has_unguarded_fo = bool(re.search(r"\b(Unguarded|FirstOrder|FO)\b", text))
    has_fagin_mentions = "Fagin" in text
    has_zero_one_mentions = bool(re.search(r"0-1|zero.?one", text, re.I))
    has_gaifman_mentions = "Gaifman" in text

    return {
        "id": CERT_ID,
        "status": "general FMT frontier attack ledger",
        "classification_stratum": "specification",
        "current_bounded_cr2_lock_retained": has_cr2_lock,
        "inspection": {
            "has_unguarded_or_first_order_mentions": has_unguarded_fo,
            "has_gaifman_mentions": has_gaifman_mentions,
            "has_fagin_mentions": has_fagin_mentions,
            "has_zero_one_law_mentions": has_zero_one_mentions,
        },
        "attack_order": ATTACK_ORDER,
        "first_admissible_target": "Unguarded FO syntax and semantics",
        "first_global_theorem_target_after_language": "Unguarded FO locality",
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

    order = "\n".join(
        f'{item["rank"]}. `{item["target"]}` — {item["status"]}. {item["reason"]}'
        for item in payload["attack_order"]
    )

    DOC.write_text(f"""# {CERT_ID}

## Status

This is the first attack ledger for the general FMT frontier.

It does not close the general frontier. It fixes the admissible order of attack
so bounded `Cr2` closure is not mislabeled as global finite model theory.

## Current retained bounded lock

`RestrictedEFGameLocalTypeInvariantInputSurface → Cr2`

## First admissible target

`{payload["first_admissible_target"]}`

## First global theorem target after language

`{payload["first_global_theorem_target_after_language"]}`

## Attack order

{order}

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
        raise SystemExit("general FMT frontier ledger id mismatch")
    if payload["classification_stratum"] != "specification":
        raise SystemExit("classification stratum mismatch")
    if payload["first_admissible_target"] != "Unguarded FO syntax and semantics":
        raise SystemExit("first admissible target mismatch")
    if payload["first_global_theorem_target_after_language"] != "Unguarded FO locality":
        raise SystemExit("first theorem target mismatch")
    if not payload["current_bounded_cr2_lock_retained"]:
        raise SystemExit("current bounded Cr2 lock not retained")
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
    print("GENERAL_FMT_FRONTIER_FIRST_ATTACK_LEDGER_OK")

if __name__ == "__main__":
    main()
