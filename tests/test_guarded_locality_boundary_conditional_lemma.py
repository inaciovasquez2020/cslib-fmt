import subprocess
import sys

def test_guarded_locality_boundary_conditional_lemma():
    subprocess.run(
        [sys.executable, "scripts/check_guarded_locality_boundary_conditional_lemma.py"],
        check=True,
    )
