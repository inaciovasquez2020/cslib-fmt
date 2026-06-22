import subprocess
from pathlib import Path

PYTHON = "/opt/homebrew/Cellar/python@3.11/3.11.14_3/Frameworks/Python.framework/Versions/3.11/Resources/Python.app/Contents/MacOS/Python"

def test_existential_locality_radius_constructor_downstream_use():
    result = subprocess.run(
        [PYTHON, "-B", "tools/verify_existential_locality_radius_constructor_downstream_use.py"],
        cwd=Path(__file__).resolve().parents[1],
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_DOWNSTREAM_USE_OK" in result.stdout
