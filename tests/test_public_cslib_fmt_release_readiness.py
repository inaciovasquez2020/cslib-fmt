import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts/cslib-fmt/public_cslib_fmt_release_readiness_2026_06_02.json"
DOC = ROOT / "docs/status/PUBLIC_CSLIB_FMT_RELEASE_READINESS_2026_06_02.md"
VERIFY = ROOT / "tools/verify_public_cslib_fmt_release_readiness.py"

def test_public_cslib_fmt_release_readiness_artifact_shape():
    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    assert data["status"] == "PUBLIC_CSLIB_FMT_RELEASE_PREPARED"
    assert data["prepared_object"] == "PreparePublicCslibFmtRelease"
    assert data["next_admissible_object"] == "CreatePublicCslibFmtReleaseOrArchiveReleaseCandidate"
    assert len(data["included_closed_objects"]) == 5
    assert len(data["required_public_boundary"]) == 7

def test_public_cslib_fmt_release_readiness_doc_boundary():
    text = DOC.read_text(encoding="utf-8")
    assert "finite graph diameter public convenience surface" in text
    assert "no infinite graph claim" in text
    assert "no weighted graph claim" in text
    assert "no full graph theory completion claim" in text
    assert "no cross-repository theorem claim" in text

def test_public_cslib_fmt_release_readiness_verifier_passes():
    result = subprocess.run(
        ["python3", str(VERIFY)],
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=True,
    )
    assert "PUBLIC_CSLIB_FMT_RELEASE_READINESS_OK" in result.stdout
