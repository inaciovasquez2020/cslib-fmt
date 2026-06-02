import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def test_final_convenience_layer_artifact():
    data = json.loads((ROOT / "artifacts/cslib-fmt/finite_graph_diameter_final_convenience_layer_2026_06_02.json").read_text())
    assert data["status"] == "FINITE_GRAPH_DIAMETER_OPTION_NAT_LAYER_PUBLIC_CONVENIENCE_CLOSED"
    assert data["next_admissible_object"] == "PreparePublicCslibFmtRelease"
    assert "finiteGraphDiameter_closed_option_nat_cases" in data["closed_objects"]

def test_final_convenience_layer_lean_names_present():
    text = (ROOT / "FMT/Graph/FiniteGraphDiameter.lean").read_text()
    assert "finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable" in text
    assert "finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable" in text
    assert "finiteGraphDiameter_none_of_not_allPairDistancesReachable'" in text
    assert "finiteGraphDiameter_some_iff_allPairDistancesReachable" in text
    assert "finiteGraphDiameter_closed_option_nat_cases" in text
