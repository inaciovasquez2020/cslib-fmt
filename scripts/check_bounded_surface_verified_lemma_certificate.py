#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

CERT_ID = "BOUNDED_SURFACE_VERIFIED_LEMMA_CERTIFICATE_2026_06_19"
ARTIFACT = Path("artifacts/cslib_fmt/bounded_surface_verified_lemma_certificate_2026_06_19.json")
DOC = Path("docs/status/BOUNDED_SURFACE_VERIFIED_LEMMA_CERTIFICATE_2026_06_19.md")

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

CANDIDATE_FILES = [
    Path("FMT/Graph/GlobalDistanceTheorems.lean"),
    Path("lean/CSLIB/FMT/Graph/GlobalDistanceTheorems.lean"),
    Path("CSLIB/FMT/Graph/GlobalDistanceTheorems.lean"),
]

DECL_RE = re.compile(r"^\s*(theorem|lemma)\s+([A-Za-z0-9_'.]+)\b")
IMPORT_RE = re.compile(r"^\s*import\s+([A-Za-z0-9_'.]+)\s*$")

FORBIDDEN_CERT_PHRASES = [
    "STRONGEST_EXPORTED_THEOREM",
    "strongest exported theorem",
    "Fagin theorem proved",
    "0-1 Law proved",
    "full Gaifman locality proved",
    "unguarded FO locality proved",
    "external validation obtained",
    "Vardi endorsement",
    "CSLIB adoption",
    "Mathlib adoption",
    "coauthorship",
    "collaboration",
]

def find_source() -> Path:
    for path in CANDIDATE_FILES:
        if path.exists():
            return path
    raise SystemExit("MISSING_OBJECT := FMT.Graph.GlobalDistanceTheorems source file")

def module_to_possible_paths(module: str) -> list[str]:
    rel = Path(*module.split(".")).with_suffix(".lean")
    return [str(rel), str(Path("lean") / rel)]

def extract_source_record(source: Path) -> dict:
    text = source.read_text()
    declarations = []
    for line in text.splitlines():
        m = DECL_RE.match(line)
        if m:
            declarations.append({"kind": m.group(1), "name": m.group(2)})

    if not declarations:
        raise SystemExit(f"MISSING_OBJECT := verified lemma/theorem declaration in {source}")

    imports = []
    for line in text.splitlines():
        m = IMPORT_RE.match(line)
        if m:
            mod = m.group(1)
            imports.append({
                "module": mod,
                "possible_files": module_to_possible_paths(mod),
            })

    return {
        "source_file": str(source),
        "source_module": "FMT.Graph.GlobalDistanceTheorems",
        "declarations": declarations,
        "imports": imports,
    }

def build_payload() -> dict:
    source = find_source()
    record = extract_source_record(source)
    return {
        "id": CERT_ID,
        "status": "bounded surface verified lemma certificate",
        "scope": "scoped certificate for one bounded verified distance-theorem family only",
        "primary_audit": "THEOREM_SURFACE_AUDIT",
        "classification_stratum": "verified lemma",
        "source": record,
        "dependency_chain_policy": (
            "The dependency chain is the Lean import list of the certified source file; "
            "this certificate does not claim repository-level closure beyond the listed declarations."
        ),
        "conditional_hypotheses_policy": (
            "The certified hypotheses are exactly the parameters and assumptions appearing in each listed Lean declaration."
        ),
        "nonclaims": [
            "No general finite-model-theory closure is claimed.",
            "No unguarded FO locality theorem is claimed.",
            "No Fagin theorem or 0-1 Law result is claimed.",
            "No external validation or adoption claim is made.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)

    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    decl_lines = "\n".join(
        f"- `{d['kind']} {d['name']}`" for d in payload["source"]["declarations"]
    )
    import_lines = "\n".join(
        f"- `{i['module']}`" for i in payload["source"]["imports"]
    ) or "- none"

    DOC.write_text(f"""# {CERT_ID}

## Status

This is a scoped bounded-surface verified-lemma certificate.

It certifies only the listed Lean declarations in one bounded distance-theorem family.
It is subordinate to `THEOREM_SURFACE_AUDIT`.

## Certified source file

`{payload["source"]["source_file"]}`

## Classification stratum

`verified lemma`

## Certified declarations

{decl_lines}

## Dependency chain

{import_lines}

The dependency chain is read from the certified Lean source file imports.
This document does not claim closure beyond the listed declarations.

## Conditional hypotheses

The certified hypotheses are exactly the parameters and assumptions appearing in each listed Lean declaration.

## Nonclaims

- No general finite-model-theory closure is claimed.
- No unguarded FO locality theorem is claimed.
- No Fagin theorem or 0-1 Law result is claimed.
- No external validation or adoption claim is made.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["primary_audit"] != "THEOREM_SURFACE_AUDIT":
        raise SystemExit("primary audit mismatch")
    if payload["classification_stratum"] != "verified lemma":
        raise SystemExit("classification stratum mismatch")
    if not payload["source"]["declarations"]:
        raise SystemExit("missing certified declarations")

    source = Path(payload["source"]["source_file"])
    if not source.exists():
        raise SystemExit(f"MISSING_OBJECT := {source}")

    source_text = source.read_text()
    for decl in payload["source"]["declarations"]:
        if decl["name"] not in source_text:
            raise SystemExit(f"missing declaration in source := {decl['name']}")

    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

    combined = json.dumps(payload, sort_keys=True) + "\n"
    if DOC.exists():
        combined += DOC.read_text()
    for phrase in FORBIDDEN_CERT_PHRASES:
        if phrase in combined:
            raise SystemExit(f"forbidden certificate phrase := {phrase}")

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

    loaded = json.loads(ARTIFACT.read_text())
    verify_payload(loaded)
    print("BOUNDED_SURFACE_VERIFIED_LEMMA_CERTIFICATE_OK")

if __name__ == "__main__":
    main()
