from pathlib import Path

def test_axiom_usage_audit_archival_only():
    audit = Path("AXIOM_USAGE_AUDIT.txt").read_text(encoding="utf-8")
    frontier = Path("FMT/Graph/FrontierStatus.txt").read_text(encoding="utf-8")
    assert "LIVE AXIOM FRONTIER: none in FMT code." in audit
    assert "ARCHIVAL HISTORY ONLY:" in audit
    assert "Independent Live Frontier: none" in frontier
    assert "no live axiom/sorry/admit in FMT code" in frontier
