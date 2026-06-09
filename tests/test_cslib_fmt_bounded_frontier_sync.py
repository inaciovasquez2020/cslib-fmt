from pathlib import Path
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs/status/CSLIB_FMT_BOUNDED_FRONTIER_SYNC_2026_06_09.md"
ART = ROOT / "artifacts/status/cslib_fmt_bounded_frontier_sync_2026_06_09.json"
VERIFY = ROOT / "tools/verify_cslib_fmt_bounded_frontier_sync.py"

def test_cslib_fmt_bounded_frontier_sync_artifact():
    data = json.loads(ART.read_text())
    assert data["status"] == "CSLIB_FMT_BOUNDED_FRONTIER_SYNC_ONLY"
    assert data["next_admissible_object"] == "Stop"
    assert len(data["synced_objects"]) == 4
    assert "H1_locality_theorem_closure" in data["claims_not_made"]
    assert "Clay_problem_closure" in data["claims_not_made"]

def test_cslib_fmt_bounded_frontier_sync_doc():
    text = DOC.read_text()
    assert "CSLIB_FMT_BOUNDED_FRONTIER_SYNC_ONLY" in text
    assert "finite-model-theory infrastructure" in text
    assert "repository_native_bounded_status_certificate" in text
    assert "DFM_MKC_BOUNDED_REPO_SYNC_2026_06_09" in text
    assert "Claims not made" in text

def test_cslib_fmt_bounded_frontier_sync_verifier():
    result = subprocess.run(
        [sys.executable, str(VERIFY)],
        cwd=ROOT,
        check=True,
        capture_output=True,
        text=True,
    )
    assert "CSLIB_FMT_BOUNDED_FRONTIER_SYNC_OK" in result.stdout
