#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OBJECT = "CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_2026_06_13"
STATUS_TEXT = "Distance/Factorization Surface Closed; General FMT Frontier Open"

ARTIFACT = ROOT / "artifacts/status/cslib_fmt_distance_factorization_surface_status_2026_06_13.json"
STATUS_DOC = ROOT / "docs/status/CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_2026_06_13.md"
README = ROOT / "README.md"
EXPORTED_AUDIT = ROOT / "docs/status/CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_2026_06_11.md"

DISTANCE_OBJECTS = {
    "exists_min_pathLength",
    "pathLength_reverse",
    "pathLength_concat",
}

NONCLAIMS = {
    "No Fagin theorem closure claim.",
    "No 0-1 Law closure claim.",
    "No global finite-model-theory final theorem claim.",
    "No repository-level final solve claim.",
    "No broad CSLIB adoption claim.",
    "No direct Mathlib adoption claim.",
    "No Vardi endorsement, collaboration, or coauthorship claim.",
}


def fail(msg: str) -> None:
    raise SystemExit(f"CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_ERROR: {msg}")


def read(path: Path) -> str:
    if not path.exists():
        fail(f"missing {path.relative_to(ROOT)}")
    return path.read_text(encoding="utf-8")


def main() -> None:
    data = json.loads(read(ARTIFACT))
    status_doc = read(STATUS_DOC)
    readme = read(README)
    exported_audit = read(EXPORTED_AUDIT)

    if data.get("object") != OBJECT:
        fail("object mismatch")
    if data.get("status") != STATUS_TEXT:
        fail("status mismatch")
    if data.get("classification") != "distance_factorization_surface_closed_general_fmt_frontier_open":
        fail("classification mismatch")
    if data.get("depends_on_audit_lock") != "CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_2026_06_11":
        fail("audit-lock dependency mismatch")
    if data.get("general_fmt_frontier") != "open":
        fail("general FMT frontier must remain open")
    if set(data.get("live_closed_distance_objects", [])) != DISTANCE_OBJECTS:
        fail("distance-object set mismatch")
    if set(data.get("nonclaim_boundary", [])) != NONCLAIMS:
        fail("nonclaim boundary mismatch")

    for needle in [OBJECT, STATUS_TEXT, *DISTANCE_OBJECTS, *NONCLAIMS]:
        if needle not in status_doc:
            fail(f"status doc missing {needle!r}")

    for needle in [
        STATUS_TEXT,
        "No Fagin theorem",
        "0-1 Law",
        "global finite-model-theory final theorem",
    ]:
        if needle not in readme:
            fail(f"README missing {needle!r}")

    if "CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_2026_06_11" not in exported_audit:
        fail("exported audit lock marker missing")

    print("CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_OK")


if __name__ == "__main__":
    main()
