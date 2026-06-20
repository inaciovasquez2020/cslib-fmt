#!/usr/bin/env python3
from pathlib import Path
import json
import re

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/quantifier_locality_input_transport_target_shell_2026_06_20.json")
DOC = Path("docs/status/QUANTIFIER_LOCALITY_INPUT_TRANSPORT_TARGET_SHELL_2026_06_20.md")
LEDGER = Path("artifacts/cslib_fmt/quantified_constructor_dependency_ledger_2026_06_20.json")
TARGET = Path("artifacts/cslib_fmt/quantified_formula_radius_constructor_target_shell_2026_06_20.json")

def main() -> None:
    assert LEDGER.exists(), LEDGER
    assert TARGET.exists(), TARGET

    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()
    ledger = json.loads(LEDGER.read_text())

    assert ledger["weakest_next_dependency"] == "quantifier_locality_input_transport"

    assert re.search(r"\bdef\s+quantifier_locality_input_transport_target_shell\b", src)
    assert re.search(r"\btheorem\s+quantifier_locality_input_transport_target_shell_closed\b", src)
    assert "quantified_formula_radius_constructor_target_shell" in src
    assert "quantified_formula_radius_constructor_target_shell_closed" in src

    assert data["artifact"] == "QUANTIFIER_LOCALITY_INPUT_TRANSPORT_TARGET_SHELL"
    assert data["status"] == "TARGET_SHELL_ONLY"
    assert data["target"] == "quantifier_locality_input_transport"
    assert data["boundary"] == "BOUNDARY := ¬ quantifier_locality_input_transport"

    assert "STATUS := TARGET_SHELL_ONLY" in doc
    assert "TARGET := quantifier_locality_input_transport" in doc
    assert "BOUNDARY := ¬ quantifier_locality_input_transport" in doc

    print("QUANTIFIER_LOCALITY_INPUT_TRANSPORT_TARGET_SHELL_OK")

if __name__ == "__main__":
    main()
