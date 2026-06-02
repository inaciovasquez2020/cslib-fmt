import json
from pathlib import Path

def test_finite_graph_diameter_artifact_status():
    data = json.loads(Path("artifacts/cslib-fmt/finite_graph_diameter_option_nat_definition_2026_06_02.json").read_text())
    assert data["status"] == "TARGET_IMPLEMENTED_PENDING_VERIFICATION"
    assert data["selected_target"] == "FiniteGraphDiameterLayer"
    assert data["registration_action"] == "RegisterFiniteGraphDiameterLayerTarget"

def test_finite_graph_diameter_lean_surface_tokens():
    text = Path("FMT/Graph/FiniteGraphDiameter.lean").read_text()
    for token in [
        "def ConnectedGraph",
        "def allVertexPairs",
        "def pairDistance?",
        "def allPairDistancesReachable",
        "def pairDistanceValues",
        "def finiteGraphDiameter?",
        "theorem connected_implies_all_pair_distances_reachable",
        "theorem finite_connected_graph_diameter_exists",
        "theorem distance_mem_pairDistanceValues",
        "theorem distance_le_diameter_of_finite_connected",
    ]:
        assert token in text

def test_finite_graph_diameter_boundary_nonclaims():
    text = Path("docs/status/FINITE_GRAPH_DIAMETER_OPTION_NAT_DEFINITION_2026_06_02.md").read_text()
    assert "arbitrary directed graph distance symmetry" in text
    assert "every graph is undirected" in text
    assert "removal of SymmAdj for directed graphs" in text
    assert "underlying directed Graph structure" in text
