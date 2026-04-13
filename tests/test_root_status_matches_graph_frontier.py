from pathlib import Path

def test_root_status_matches_graph_frontier():
    frontier = Path("FMT/Graph/FrontierStatus.txt").read_text(encoding="utf-8")
    status = Path("STATUS.md").read_text(encoding="utf-8")
    closure = Path("MATHEMATICAL_CLOSURE_ORDER.txt").read_text(encoding="utf-8")
    snapshot = Path("CLOSURE_FRONTIER_SNAPSHOT.txt").read_text(encoding="utf-8")
    canonical = Path("CANONICAL_FRONTIER_POINTER.md").read_text(encoding="utf-8")

    assert "Distance Layer Mathematical Closure: complete" in frontier
    assert "Distance Layer Constructive Closure: complete" in frontier
    assert "Independent Live Frontier: none" in frontier

    assert "Distance Layer Mathematical Closure: complete" in status
    assert "Distance Layer Constructive Closure: complete" in status
    assert "Independent Live Frontier: none" in status

    assert "No live graph-distance mathematical blockers remain on `main`." in closure
    assert "Distance layer: complete" in snapshot
    assert "Live independent frontier: none" in snapshot
    assert "FMT/Graph/FrontierStatus.txt" in canonical
