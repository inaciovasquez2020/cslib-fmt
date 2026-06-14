import subprocess


def test_cslib_fmt_bounded_closure_proof_pattern_sync_verifier():
    out = subprocess.check_output(
        ["python3", "tools/verify_cslib_fmt_bounded_closure_proof_pattern_sync.py"],
        text=True,
    )
    assert "CSLIB_FMT_BOUNDED_CLOSURE_PROOF_PATTERN_SYNC_OK" in out
