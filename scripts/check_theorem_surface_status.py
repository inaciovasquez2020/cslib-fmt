#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STATUS_DOC = ROOT / "docs/status/THEOREM_SURFACE_AUDIT_2026_04_27.md"

def main() -> int:
    if not STATUS_DOC.exists():
        print(f"missing status document: {STATUS_DOC.relative_to(ROOT)}")
        return 1

    text = STATUS_DOC.read_text(encoding="utf-8", errors="ignore")

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

    print({
        "status": "PASS",
        "classification": "Clean Formal Scaffold / Needs Theorem Audit",
        "status_doc": str(STATUS_DOC.relative_to(ROOT)),
    })
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
