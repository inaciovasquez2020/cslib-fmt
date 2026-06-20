import subprocess
import sys

def test_bounded_surface_verified_lemma_certificate():
    subprocess.run(
        [sys.executable, "scripts/check_bounded_surface_verified_lemma_certificate.py"],
        check=True,
    )
