from pathlib import Path
import subprocess
import sys

def test_nonvacuous_formal_content_file_present():
    p = Path("CslibFmt/FormalContent/NonVacuousCore.lean")
    assert p.exists()
    text = p.read_text(encoding="utf-8")
    assert "theorem nat_add_comm_core" in text
    assert "theorem nat_add_assoc_core" in text
    assert "theorem nat_add_right_cancel_core" in text
    assert "axiom" not in text
    assert "sorry" not in text
    assert "admit" not in text
    assert ":= True" not in text

def test_nonvacuous_formal_content_verifier_passes():
    result = subprocess.run(
        [sys.executable, "scripts/verify_nonvacuous_formal_content.py"],
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    assert result.returncode == 0, result.stdout
