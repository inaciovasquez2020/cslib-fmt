import subprocess
import sys

def test_unguarded_fo_gaifman_graph_distance():
    subprocess.run(
        [sys.executable, "scripts/check_unguarded_fo_gaifman_graph_distance.py"],
        check=True,
    )
