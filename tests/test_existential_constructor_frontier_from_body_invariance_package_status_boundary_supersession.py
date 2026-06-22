import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_existential_constructor_frontier_from_body_invariance_package_status_boundary_supersession():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_existential_constructor_frontier_from_body_invariance_package_status_boundary_supersession.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS_BOUNDARY_SUPERSESSION_OK" in result.stdout
