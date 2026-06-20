#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/common_smaller_radius_disjunction_constructor_lock_2026_06_20.json")
DOC = Path("docs/status/COMMON_SMALLER_RADIUS_DISJUNCTION_CONSTRUCTOR_LOCK_2026_06_20.md")

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    decl = "unguarded_fo_disj_common_smaller_radius_constructor"

    assert re.search(rf"\btheorem\s+{decl}\b", src)
    assert "Formula.disj" in src
    assert "unguarded_fo_disj_same_radius_constructor" in src
    assert "unguarded_fo_locality_input_surface_weaken_radius" in src

    assert data["artifact"] == "COMMON_SMALLER_RADIUS_DISJUNCTION_CONSTRUCTOR_LOCK"
    assert data["required_declaration"] == f"theorem {decl}"
    assert data["boundary"] == "BOUNDARY := ¬ arbitrary_boolean_common_smaller_radius_constructor"

    assert "STATUS := LOCK_ONLY" in doc
    assert f"OBJECT := theorem {decl}" in doc
    assert "BOUNDARY := ¬ arbitrary_boolean_common_smaller_radius_constructor" in doc

    print("COMMON_SMALLER_RADIUS_DISJUNCTION_CONSTRUCTOR_LOCK_OK")

if __name__ == "__main__":
    main()
