import subprocess
from pathlib import Path

def test_guarded_locality_pipeline_verifier():
    out = subprocess.check_output(
        ["python3", "tools/verify_guarded_locality_pipeline.py"],
        text=True,
    )
    assert "CSLIB_FMT_GUARDED_LOCALITY_PIPELINE_OK" in out

def test_guarded_locality_pipeline_no_placeholders():
    text = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean").read_text()
    for token in ["sorry", "admit", "axiom", "opaque"]:
        assert token not in text
