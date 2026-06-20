#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path

AUDIT_ID = "NONCOMPUTABLE_AUDIT_2026_06_19"
ARTIFACT = Path("artifacts/cslib_fmt/noncomputable_audit_2026_06_19.json")
DOC = Path("docs/status/NONCOMPUTABLE_AUDIT_2026_06_19.md")

SCAN_ROOTS = [Path("FMT"), Path("lean/CSLIB/FMT")]

BOUNDARIES = [
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ global finite-model-theory final theorem",
    "BOUNDARY := ¬ external validation claim",
]

NONCOMPUTABLE_DEF_RE = re.compile(
    r"^\s*(?:@[^\n]+\s*)*noncomputable\s+def\s+([A-Za-z0-9_'.]+)\b"
)

FORBIDDEN_AUDIT_CLAIMS = [
    "constructivization obligation required",
    "constructivization required",
    "constructive witness exists",
    "all noncomputable definitions have constructive replacements",
    "Fagin theorem proved",
    "0-1 Law proved",
    "full Gaifman locality proved",
    "unguarded FO locality proved",
    "repository-level final FMT closure obtained",
    "Mathlib adoption",
    "CSLIB adoption",
    "Vardi endorsement",
    "collaboration",
    "coauthorship",
]

def existing_roots() -> list[Path]:
    roots = [root for root in SCAN_ROOTS if root.exists()]
    if not roots:
        raise SystemExit("MISSING_OBJECT := FMT or lean/CSLIB/FMT source root")
    return roots

def scan_noncomputable_defs() -> list[dict]:
    entries = []
    for root in existing_roots():
        for path in sorted(root.rglob("*.lean")):
            text = path.read_text()
            for lineno, line in enumerate(text.splitlines(), start=1):
                m = NONCOMPUTABLE_DEF_RE.match(line)
                if not m:
                    continue
                entries.append({
                    "file": str(path),
                    "line": lineno,
                    "name": m.group(1),
                    "classification": "justified-noncomputable",
                    "explanation": (
                        "Recorded as an existing noncomputable definition. "
                        "This audit does not assert a constructive witness and therefore does not create a constructivization obligation."
                    ),
                })
    return entries

def build_payload() -> dict:
    entries = scan_noncomputable_defs()
    return {
        "id": AUDIT_ID,
        "status": "noncomputable audit",
        "scope": "remaining noncomputable def declarations under FMT.* / lean/CSLIB/FMT only",
        "entry_count": len(entries),
        "entries": entries,
        "policy": (
            "Every discovered noncomputable def is recorded as justified-noncomputable unless an already-existing constructive witness is explicitly identified. "
            "No constructive witness is asserted by this audit."
        ),
        "nonclaims": [
            "No constructivization obligation is created.",
            "No constructive replacement is claimed.",
            "No repository-level final FMT closure is claimed.",
        ],
        "boundaries": BOUNDARIES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")

    if payload["entries"]:
        entry_lines = "\n".join(
            f"- `{e['file']}:{e['line']}` `{e['name']}` — `{e['classification']}`. {e['explanation']}"
            for e in payload["entries"]
        )
    else:
        entry_lines = "- No `noncomputable def` declarations were found under the scanned roots."

    DOC.write_text(f"""# {AUDIT_ID}

## Status

This is an internal audit of remaining `noncomputable def` declarations.

## Scope

`FMT.*` / `lean/CSLIB/FMT` source roots only.

## Result

- `entry_count`: `{payload["entry_count"]}`

## Entries

{entry_lines}

## Policy

Every discovered `noncomputable def` is recorded as `justified-noncomputable` unless an already-existing constructive witness is explicitly identified.

No constructive witness is asserted by this audit.

## Nonclaims

- No constructivization obligation is created.
- No constructive replacement is claimed.
- No repository-level final FMT closure is claimed.

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    if payload["id"] != AUDIT_ID:
        raise SystemExit("audit id mismatch")
    if payload["status"] != "noncomputable audit":
        raise SystemExit("audit status mismatch")
    if payload["entry_count"] != len(payload["entries"]):
        raise SystemExit("entry count mismatch")

    expected = scan_noncomputable_defs()
    if payload["entries"] != expected:
        raise SystemExit("artifact entries do not match current source scan")

    for entry in payload["entries"]:
        if entry["classification"] not in {"justified-noncomputable", "future constructivization candidate"}:
            raise SystemExit(f"bad classification := {entry['classification']}")
        if entry["classification"] == "future constructivization candidate":
            raise SystemExit(f"future constructivization candidate requires explicit existing witness := {entry['name']}")

    for boundary in BOUNDARIES:
        if boundary not in payload["boundaries"]:
            raise SystemExit(f"missing boundary := {boundary}")

    combined = json.dumps(payload, sort_keys=True)
    if DOC.exists():
        combined += "\n" + DOC.read_text()
    for phrase in FORBIDDEN_AUDIT_CLAIMS:
        if phrase in combined:
            raise SystemExit(f"forbidden audit claim := {phrase}")

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
    print("NONCOMPUTABLE_AUDIT_OK")

if __name__ == "__main__":
    main()
