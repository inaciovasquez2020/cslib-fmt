from pathlib import Path

def test_status_distance_complete():
    status = Path("STATUS.md").read_text(encoding="utf-8")
    frontier = Path("FMT/Graph/FrontierStatus.txt").read_text(encoding="utf-8")
    assert "- distance layer: complete" in status
    assert "Distance Layer Mathematical Closure: complete" in frontier
    assert "Distance Layer Constructive Closure: complete" in frontier
    assert "Independent Live Frontier: none" in frontier
