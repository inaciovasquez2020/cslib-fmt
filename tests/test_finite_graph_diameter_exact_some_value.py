import json
from pathlib import Path

ARTIFACT = Path("artifacts/cslib-fmt/finite_graph_diameter_exact_some_value_2026_06_02.json")
LEAN = Path("FMT/Graph/FiniteGraphDiameter.lean")
DOC = Path("docs/status/FINITE_GRAPH_DIAMETER_EXACT_SOME_VALUE_2026_06_02.md")

def test_exact_some_value_artifact():
    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    assert data["status"] == "TARGET_IMPLEMENTED_PENDING_VERIFICATION"
    assert "finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable" in data["implemented_objects"]

def test_exact_some_value_lean_token():
    text = LEAN.read_text(encoding="utf-8")
    assert "theorem finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable" in text
    assert "finiteGraphDiameter? G = some (natListMax (pairDistanceValues G).toList)" in text

def test_exact_some_value_boundary():
    text = DOC.read_text(encoding="utf-8")
    assert "directed distance symmetry" in text
    assert "new connectedness closure" in text
    assert "any change to Graph" in text
    assert "new diameter computation algorithm" in text
