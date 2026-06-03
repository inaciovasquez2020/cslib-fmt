import subprocess
from pathlib import Path

def test_flagship_finite_graph_diameter_closure_v1_verifier():
    root = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        ["python3", "tools/verify_flagship_finite_graph_diameter_closure_v1.py"],
        cwd=root,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    assert result.returncode == 0, result.stdout + result.stderr
    assert "FLAGSHIP_FINITE_GRAPH_DIAMETER_CLOSURE_V1_OK" in result.stdout
