#!/usr/bin/env python3
from pathlib import Path
import json
import re
import subprocess

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/atomic_formula_radius_input_connection_status_2026_06_20.json")
DOC = Path("docs/status/ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS_2026_06_20.md")

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    atomic_hits = subprocess.check_output(
        [
            "git",
            "grep",
            "-n",
            "atomic.*locality.*input\\|Atomic.*Locality.*Input\\|ATOMIC_LOCALITY_INPUT\\|atomic.*formula.*radius\\|Atomic.*Formula.*Radius",
            "--",
            "*.lean",
            "docs",
            "artifacts",
        ],
        text=True,
    )

    assert re.search(r"\bdef\s+atomic_formula_radius_input_connection_status\b", src)
    assert re.search(r"\btheorem\s+atomic_formula_radius_input_connection_status_closed\b", src)
    assert "formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate" in src
    assert "formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_closed" in src
    assert "atomic" in atomic_hits.lower()

    assert data["artifact"] == "ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS"
    assert data["status"] == "CONNECTION_STATUS_ONLY"
    assert data["boundary"] == "BOUNDARY := ¬ unguarded_fo_formula_radius_construction"

    assert "STATUS := CONNECTION_STATUS_ONLY" in doc
    assert "BOUNDARY := ¬ unguarded_fo_formula_radius_construction" in doc

    print("ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS_OK")

if __name__ == "__main__":
    main()
