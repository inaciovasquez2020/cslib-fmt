from pathlib import Path

def test_status_graph_factorization_surface():
    status = Path("STATUS.md").read_text(encoding="utf-8")
    frontier = Path("FMT/Graph/FrontierStatus.txt").read_text(encoding="utf-8")
    factor = Path("FACTORIZATION_FRONTIER.md").read_text(encoding="utf-8")

    assert "Distance Layer Mathematical Closure: complete" in frontier
    assert "Distance Layer Constructive Closure: complete" in frontier
    assert "Independent Live Frontier: none" in frontier

    assert "- distance layer: complete" in status
    assert "- factorization layer: partial" in status
    assert "Single weakest remaining theorem object:" in status

    assert "- factorization layer: partial" in factor
    assert "Single weakest remaining theorem object:" in factor
    assert "Graph-distance closure is already complete on main." in factor
