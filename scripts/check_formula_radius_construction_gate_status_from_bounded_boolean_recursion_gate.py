#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_2026_06_20.json")
DOC = Path("docs/status/FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE_2026_06_20.md")

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert re.search(r"\bdef\s+formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate\b", src)
    assert re.search(r"\btheorem\s+formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_closed\b", src)
    assert "bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface" in src
    assert "bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_closed" in src

    assert data["artifact"] == "FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE"
    assert data["status"] == "GATE_STATUS_ONLY"
    assert data["boundary"] == "BOUNDARY := ¬ unguarded_fo_formula_radius_construction"

    assert "STATUS := GATE_STATUS_ONLY" in doc
    assert "BOUNDARY := ¬ unguarded_fo_formula_radius_construction" in doc

    print("FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE_OK")

if __name__ == "__main__":
    main()
