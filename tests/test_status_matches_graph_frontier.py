from pathlib import Path

def test_status_matches_graph_frontier():
    status = Path("STATUS.md").read_text(encoding="utf-8")
    frontier = Path("FMT/Graph/FrontierStatus.txt").read_text(encoding="utf-8")
    assert "Distance Layer Mathematical Closure: complete" in frontier
    assert "Distance Layer Constructive Closure: complete" in frontier
    assert "Independent Live Frontier: none" in frontier
    assert "- distance layer: complete" in status
    assert "graph-distance layer has no live blocker on main" in status
