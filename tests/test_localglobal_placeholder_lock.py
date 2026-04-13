from pathlib import Path

def test_localglobal_placeholder_replaced_by_typed_bridge():
    text = Path("FMT/Bridge/LocalGlobal.lean").read_text(encoding="utf-8")
    assert "structure LocalData where" in text
    assert "structure GlobalFactorization where" in text
    assert "def buildFactorization" in text
    assert "theorem localToGlobal (d : LocalData)" in text
    assert "∃ g : GlobalFactorization" in text
    assert "theorem localToGlobal : True := by" not in text
