import subprocess
from pathlib import Path

ROOT = Path(subprocess.check_output(["git", "rev-parse", "--show-toplevel"], text=True).strip())

def test_existential_constructor_definition_inspection_verifier():
    result = subprocess.run(
        ["python3", "-B", "tools/verify_existential_constructor_definition_inspection.py"],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=True,
    )
    assert "EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION_OK" in result.stdout
