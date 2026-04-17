from pathlib import Path

def test_factorization_frontier_lock():
    text = Path("FACTORIZATION_FRONTIER.md").read_text(encoding="utf-8")
    assert "- factorization layer: complete" in text.lower()
