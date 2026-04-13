from pathlib import Path

def test_factorization_frontier_lock():
    text = Path("FACTORIZATION_FRONTIER.md").read_text(encoding="utf-8")
    assert "- factorization layer: partial" in text
    assert "Single weakest remaining theorem object:" in text
    assert "Graph-distance closure is already complete on main." in text
