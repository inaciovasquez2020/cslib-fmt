from pathlib import Path

def test_bridge_frontier_lock():
    text = Path("BRIDGE_FRONTIER.md").read_text(encoding="utf-8")
    assert "resolved" in text.lower()
    assert "placeholder theorem has been removed" in text.lower()
