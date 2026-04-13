from pathlib import Path

def test_root_surface_consistency():
    status = Path("STATUS.md").read_text(encoding="utf-8")
    audit = Path("AXIOM_USAGE_AUDIT.txt").read_text(encoding="utf-8")
    factor = Path("FACTORIZATION_FRONTIER.md").read_text(encoding="utf-8")
    assert "- distance layer: complete" in status
    assert "- factorization layer: partial" in status
    assert "LIVE AXIOM FRONTIER: none in FMT code." in audit
    assert "Single weakest remaining theorem object:" in factor
    assert "factorization layer: partial" in factor
