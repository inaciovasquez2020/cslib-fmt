import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_existential_body_same_witness_assignment_extension_invariance_boundary_supersession():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_existential_body_same_witness_assignment_extension_invariance_boundary_supersession.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE_BOUNDARY_SUPERSESSION_OK" in result.stdout
