from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_distance_path_has_constructive_dist_le_of_path():
    text = (ROOT / "FMT/Graph/DistancePath.lean").read_text()
    assert "theorem dist?_le_of_path" in text
    assert "dist?_some_of_shortest_path" in text
    assert "by_contra hmn" in text
    assert "axiom dist?_le_of_path" not in text
    assert "sorry" not in text

def test_distance_layer_build_surfaces_exist():
    for rel in [
        "FMT/Graph/DistancePath.lean",
        "FMT/Graph/DistanceTriangle.lean",
        "FMT/Graph/DistSymmViaReverse.lean",
        "FMT/Graph/DistSomeOfShortestPath.lean",
    ]:
        assert (ROOT / rel).exists()
