import json
from pathlib import Path

def test_finite_graph_diameter_some_iff_reachable_artifact():
    data = json.loads(Path("artifacts/cslib-fmt/finite_graph_diameter_some_iff_reachable_2026_06_02.json").read_text())
    assert data["status"] == "TARGET_IMPLEMENTED_PENDING_VERIFICATION"
    assert "finiteGraphDiameter_exists_of_allPairDistancesReachable" in data["implemented_objects"]
    assert "finiteGraphDiameter_exists_iff_allPairDistancesReachable" in data["implemented_objects"]

def test_finite_graph_diameter_some_iff_reachable_lean_token():
    text = Path("FMT/Graph/FiniteGraphDiameter.lean").read_text()
    assert "theorem finiteGraphDiameter_exists_of_allPairDistancesReachable" in text
    assert "theorem finiteGraphDiameter_exists_iff_allPairDistancesReachable" in text
    assert "(∃ d : Nat, finiteGraphDiameter? G = some d) ↔ allPairDistancesReachable G" in text

def test_finite_graph_diameter_some_iff_reachable_boundaries():
    text = Path("docs/status/FINITE_GRAPH_DIAMETER_SOME_IFF_REACHABLE_2026_06_02.md").read_text()
    assert "directed distance symmetry" in text
    assert "new connectedness closure" in text
    assert "any change to Graph" in text
    assert "new diameter computation algorithm" in text
