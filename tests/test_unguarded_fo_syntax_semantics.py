import subprocess
import sys

def test_unguarded_fo_syntax_semantics():
    subprocess.run(
        [sys.executable, "scripts/check_unguarded_fo_syntax_semantics.py"],
        check=True,
    )
