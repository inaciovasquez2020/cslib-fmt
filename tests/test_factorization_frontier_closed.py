from pathlib import Path

def test_factorization_frontier_closed():
    text = Path("FACTORIZATION_FRONTIER.md").read_text(encoding="utf-8")
    status = Path("STATUS.md").read_text(encoding="utf-8")
    assert "- factorization layer: complete" in text
    assert "useLocalFactorization" in text
    assert "- factorization layer: complete" in status
    assert "## Remaining Live Frontier\n- none" in status
