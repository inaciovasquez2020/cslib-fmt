#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STATUS_DOC = ROOT / "docs/status/THEOREM_SURFACE_AUDIT_2026_04_27.md"
FORMAL_DOC = ROOT / "docs/status/FORMAL_STATUS_2026_04_27.md"

def main() -> int:
    if not STATUS_DOC.exists():
        print(f"missing status document: {STATUS_DOC.relative_to(ROOT)}")
        return 1

    if not FORMAL_DOC.exists():
        print(f"missing formal status document: {FORMAL_DOC.relative_to(ROOT)}")
        return 1

    text = STATUS_DOC.read_text(encoding="utf-8", errors="ignore")
    formal_text = FORMAL_DOC.read_text(encoding="utf-8", errors="ignore")

    required = [
        "Status: Clean Formal Scaffold / Needs Theorem Audit",
        "A `Prop` specification is not a proof.",
        "Final-solve status: not asserted at repository level",
        "Substantive final theorem verified: not asserted until exported theorem surface is audited",
        "Do not describe this repository as containing a final solve unless the exported final theorem is identified by file name, theorem name, dependency chain, and proof status.",
    ]

    missing = [s for s in required if s not in text]
    if missing:
        print("theorem surface status check failed")
        for s in missing:
            print(f"missing: {s}")
        return 1

    formal_required = [
        "Status: Clean Formal Scaffold / Needs Theorem Audit",
        "The repository builds, but build success is not final theorem verification.",
        "A `Prop` specification is not a proof.",
        "No final-solve claim is asserted at repository level.",
        "Do not describe this repository as containing a final solve until the exported final theorem surface has been audited and identified by exact theorem name.",
    ]
    formal_missing = [s for s in formal_required if s not in formal_text]
    if formal_missing:
        print("theorem-surface formal boundary check failed")
        for s in formal_missing:
            print(f"missing: {s}")
        return 1

    print({
        "status": "PASS",
        "classification": "Clean Formal Scaffold / Needs Theorem Audit",
        "status_doc": str(STATUS_DOC.relative_to(ROOT)),
        "formal_status_doc": str(FORMAL_DOC.relative_to(ROOT)),
    })
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
