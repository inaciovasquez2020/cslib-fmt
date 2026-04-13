from pathlib import Path

def test_localglobal_placeholder_lock():
    text = Path("FMT/Bridge/LocalGlobal.lean").read_text(encoding="utf-8")
    assert "theorem localToGlobal : True := by" in text
    assert "trivial" in text
