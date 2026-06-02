import json
from pathlib import Path

def test_finite_graph_diameter_none_theorem_artifact():
    data = json.loads(Path("artifacts/cslib-fmt/finite_graph_diameter_none_theorem_2026_06_02.json").read_text())
    assert data["status"] == "TARGET_IMPLEMENTED_PENDING_VERIFICATION"
    assert "finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable" in data["implemented_objects"]

def test_finite_graph_diameter_none_theorem_lean_token():
    text = Path("FMT/Graph/FiniteGraphDiameter.lean").read_text()
    assert "theorem finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable" in text
    assert "finiteGraphDiameter? G = none" in text

def test_finite_graph_diameter_none_theorem_boundaries():
    text = Path("docs/status/FINITE_GRAPH_DIAMETER_NONE_THEOREM_2026_06_02.md").read_text()
    assert "directed distance symmetry" in text
    assert "new connectedness closure" in text
    assert "any change to Graph" in text
    assert "new diameter computation algorithm" in text
