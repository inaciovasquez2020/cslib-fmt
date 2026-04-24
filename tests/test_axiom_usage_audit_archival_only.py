from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_distance_frontier_is_not_marked_partial_or_live_blocked():
    stale = [
        "distance layer: " + "partial (" + "triangle" + "/" + "symmetry" + " frontier)",
        "live blocker: " + "dist?_symm",
    ]
    checked = [
        ROOT / "AXIOM_USAGE_AUDIT.txt",
        ROOT / "SELECTOR_DEPENDENCY_AUDIT.txt",
        ROOT / "DOWNSTREAM_AXIOM_BLOCKERS.txt",
        ROOT / "POST_SELECTOR_FRONTIER.txt",
        ROOT / "AXIOM_FRONTIER_CONTEXT.txt",
    ]
    for path in checked:
        if path.exists():
            text = path.read_text()
            for marker in stale:
                assert marker not in text
