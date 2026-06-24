import subprocess
import sys


def test_cslib_bounded_integration_demo_verifier():
    result = subprocess.run(
        [sys.executable, "scripts/verify_cslib_bounded_integration_demo.py"],
        check=True,
        text=True,
        capture_output=True,
    )
    assert result.stdout.strip().splitlines() == [
        "CSLIB_BOUNDED_INTEGRATION_DEMO_OK",
        "CSLIB_FINITE_GRAPH_CERTIFICATE_ADAPTER_OK",
    ]
