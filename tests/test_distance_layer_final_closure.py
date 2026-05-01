from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

AUDIT = ROOT / "FMT" / "Graph" / "DistanceLayerFinalClosureAudit.lean"

REQUIRED = [
    "#check dist?",
    "#check dist?_le_of_path",
    "#check pathLength_reverse",
    "#check dist?_symm",
    "#check dist?_triangle",
    "#check dist?_refl",
    "#check dist?_some_iff_shortest",
]

FORBIDDEN = [
    "sorry",
    "admit",
    "axiom dist?_symm",
    "axiom dist?_triangle",
    "axiom dist?_le_of_path",
]


def test_distance_layer_final_closure_audit_exists():
    assert AUDIT.exists()


def test_distance_layer_final_closure_checks_all_targets():
    text = AUDIT.read_text()
    for token in REQUIRED:
        assert token in text


def test_distance_layer_final_closure_audit_has_no_frontier_placeholders():
    text = AUDIT.read_text()
    for token in FORBIDDEN:
        assert token not in text
