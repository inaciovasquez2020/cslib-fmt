#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_target_shell_2026_06_20.json")
DOC = Path("docs/status/QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_TARGET_SHELL_2026_06_20.md")
CLASSIFICATION = Path("artifacts/cslib_fmt/formula_radius_construction_weakest_missing_branch_classification_2026_06_20.json")
ATOMIC = Path("artifacts/cslib_fmt/atomic_formula_radius_input_connection_status_2026_06_20.json")

def main() -> None:
    assert CLASSIFICATION.exists(), CLASSIFICATION
    assert ATOMIC.exists(), ATOMIC

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    classification = json.loads(CLASSIFICATION.read_text())

    assert classification["weakest_missing_branch"] == "quantified_formula_radius_constructor_branch"

    assert re.search(r"\bdef\s+quantified_formula_radius_constructor_target_shell\b", src)
    assert re.search(r"\btheorem\s+quantified_formula_radius_constructor_target_shell_closed\b", src)
    assert "atomic_formula_radius_input_connection_status" in src
    assert "atomic_formula_radius_input_connection_status_closed" in src

    assert data["artifact"] == "QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_TARGET_SHELL"
    assert data["status"] == "TARGET_SHELL_ONLY"
    assert data["target"] == "quantified_formula_radius_constructor_branch"
    assert data["boundary"] == "BOUNDARY := ¬ quantified_formula_radius_constructor"

    assert "STATUS := TARGET_SHELL_ONLY" in doc
    assert "TARGET := quantified_formula_radius_constructor_branch" in doc
    assert "BOUNDARY := ¬ quantified_formula_radius_constructor" in doc

    print("QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_TARGET_SHELL_OK")

if __name__ == "__main__":
    main()
