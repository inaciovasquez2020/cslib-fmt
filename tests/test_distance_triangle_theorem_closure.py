from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_dist_triangle_is_not_trivial_placeholder():
    text = (ROOT / "FMT/Graph/DistTriangle.lean").read_text()
    assert "theorem dist?_triangle" in text
    assert "dist? (G:=G) u w = some d ∧ d ≤ m + n" in text
    assert "pathLength_concat" in text
    assert "dist?_le_of_path" in text
    assert "True := by" not in text
    assert "trivial" not in text
    assert "sorry" not in text
    assert "axiom dist?_triangle" not in text
