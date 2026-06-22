import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_existential_locality_radius_constructor_missing_theorem_status_boundary_supersession():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_existential_locality_radius_constructor_missing_theorem_status_boundary_supersession.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS_BOUNDARY_SUPERSESSION_OK" in result.stdout
