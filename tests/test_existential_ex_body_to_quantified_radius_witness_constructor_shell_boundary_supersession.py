import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_existential_ex_body_to_quantified_radius_witness_constructor_shell_boundary_supersession():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_existential_ex_body_to_quantified_radius_witness_constructor_shell_boundary_supersession.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL_BOUNDARY_SUPERSESSION_OK" in result.stdout
