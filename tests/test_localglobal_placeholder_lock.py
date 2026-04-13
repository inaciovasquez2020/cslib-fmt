from pathlib import Path

def test_localglobal_bridge_uses_real_interfaces():
    text = Path("FMT/Bridge/LocalGlobal.lean").read_text(encoding="utf-8")
    assert "import FMT.Types.LocalType" in text
    assert "import FMT.Types.Factorization" in text
    assert "def localProjection : LocalType → LocalType := id" in text
    assert "def globalLift : LocalType → Nat := evalLocal" in text
    assert "def localToGlobal :" in text
    assert "FactorsThrough evalLocal localProjection" in text
    assert "theorem localToGlobal : True := by" not in text
