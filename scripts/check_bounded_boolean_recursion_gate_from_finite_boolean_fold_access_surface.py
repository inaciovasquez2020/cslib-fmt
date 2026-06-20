#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_2026_06_20.json")
DOC = Path("docs/status/BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE_2026_06_20.md")

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert re.search(r"\bdef\s+bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface\b", src)
    assert re.search(r"\btheorem\s+bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_closed\b", src)
    assert "finite_boolean_disjunction_fold_access_surface" in src
    assert "finite_boolean_disjunction_fold_access_surface_closed" in src
    assert "unguarded_fo_conj_common_smaller_radius_constructor" in src
    assert "unguarded_fo_disj_common_smaller_radius_constructor" in src

    assert data["artifact"] == "BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE"
    assert data["status"] == "GATE_ONLY"
    assert data["boundary"] == "BOUNDARY := ¬ arbitrary_fo_boolean_or_quantifier_recursion"

    assert "STATUS := GATE_ONLY" in doc
    assert "BOUNDARY := ¬ arbitrary_fo_boolean_or_quantifier_recursion" in doc

    print("BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE_OK")

if __name__ == "__main__":
    main()
