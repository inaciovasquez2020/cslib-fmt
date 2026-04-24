from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_distle_triangle_is_not_baseline_placeholder():
    text = (ROOT / "FMT/Graph/DistanceTriangle.lean").read_text()
    assert "theorem distLE_triangle" in text
    assert "DistLE G u w (m + n)" in text
    assert "dist?_triangle" in text
    assert "Nat.add_le_add" in text
    assert "distanceTriangle_" + "exists_only_baseline" not in text
    assert "True := by" not in text
    assert "trivial" not in text
    assert "sorry" not in text
