from pathlib import Path

def test_axiom_usage_audit_archival_only():
    audit = Path("AXIOM_USAGE_AUDIT.txt").read_text(encoding="utf-8")
    assert "LIVE AXIOM FRONTIER: none in FMT code." in audit
    assert "ARCHIVAL HISTORY ONLY:" in audit
    banned = [
        "distance layer: partial (triangle/symmetry frontier)",
        "live blocker: shortest_path_selector",
        "live blocker: shortest_path_selector_complete",
        "live blocker: pathLength_concat",
        "live blocker: pathLength_reverse",
        "live blocker: dist?_symm",
    ]
    for s in banned:
        assert s not in audit
