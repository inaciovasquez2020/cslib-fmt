from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_no_stale_distance_frontier_wording_in_status_surfaces():
    stale = [
        "live blocker: " + "dist?_symm",
        "distance layer: " + "partial (triangle/symmetry frontier)",
    ]
    surfaces = [
        ROOT / "AXIOM_USAGE_AUDIT.txt",
        ROOT / "FMT/Graph/FrontierStatus.txt",
        ROOT / "STATUS.md",
        ROOT / "README.md",
    ]
    for surface in surfaces:
        if surface.exists():
            text = surface.read_text()
            for marker in stale:
                assert marker not in text
