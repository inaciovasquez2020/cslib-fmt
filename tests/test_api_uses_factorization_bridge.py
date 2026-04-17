from pathlib import Path

def test_api_uses_factorization_bridge():
    text = Path("FMT/API.lean").read_text(encoding="utf-8")
    assert "import FMT.Types.Factorization" in text
    assert "import FMT.Bridge.LocalGlobal" in text
    assert "def useLocalFactorization" in text
    assert "FactorsThrough evalLocal FMT.Bridge.localProjection" in text
    assert "FMT.Bridge.localToGlobal" in text
