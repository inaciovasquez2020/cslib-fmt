from pathlib import Path

def test_status_surface_current():
    status = Path("STATUS.md").read_text(encoding="utf-8")
    assert "- distance layer: complete" in status.lower()
    assert "remaining live frontier" in status.lower()
    assert "none" in status.lower()
