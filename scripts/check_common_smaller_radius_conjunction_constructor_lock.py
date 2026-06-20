#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path

ARTIFACT = Path("artifacts/cslib_fmt/common_smaller_radius_conjunction_constructor_lock_2026_06_20.json")
DOC = Path("docs/status/COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK_2026_06_20.md")
LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

def main() -> None:
    data = json.loads(ARTIFACT.read_text())
    doc = DOC.read_text()
    lean = LEAN.read_text()

    assert data["artifact"] == "COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK"
    assert data["status"] == "COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK_OK"
    assert data["base_commit"] == "b5231f7"
    assert data["lean_source"] == str(LEAN)
    assert data["locked_declaration"] == "unguarded_fo_conj_common_smaller_radius_constructor"
    assert data["predecessor_declaration"] == "unguarded_fo_conj_same_radius_constructor"

    assert LEAN.is_file()
    assert DOC.is_file()

    assert re.search(
        r"\btheorem\s+unguarded_fo_conj_common_smaller_radius_constructor\b",
        lean,
    )
    assert re.search(
        r"\btheorem\s+unguarded_fo_conj_same_radius_constructor\b",
        lean,
    )

    assert "unguarded_fo_conj_common_smaller_radius_constructor" in doc
    assert "unguarded_fo_conj_same_radius_constructor" in doc
    assert str(ARTIFACT) in doc
    assert str(LEAN) in doc
    assert "Status: `COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK_OK`" in doc

    blocked = set(data["does_not_prove"])
    assert "common smaller-radius disjunction constructor" in blocked
    assert "negation constructor" in blocked
    assert "quantifier recursion gate admissibility" in blocked
    assert "Boolean recursion gate completion" in blocked
    assert "full unguarded FO locality" in blocked
    assert "general finite model theorem" in blocked

    assert data["boundary"] == "BOUNDARY := ¬ common_smaller_radius_disjunction_constructor"
    assert "BOUNDARY := ¬ common_smaller_radius_disjunction_constructor" in doc

    print("COMMON_SMALLER_RADIUS_CONJUNCTION_CONSTRUCTOR_LOCK_OK")

if __name__ == "__main__":
    main()
