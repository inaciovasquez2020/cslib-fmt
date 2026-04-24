from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_dist_symm_is_not_trivial_placeholder():
    text = (ROOT / "FMT/Graph/DistSymm.lean").read_text()
    assert "theorem dist?_symm" in text
    assert "dist? (G:=G) u v = dist? (G:=G) v u" in text
    assert "pathLength_reverse" in text
    assert "dist?_le_of_path" in text
    assert "True := by" not in text
    assert "trivial" not in text
    assert "sorry" not in text
    assert "axiom dist?_symm" not in text
