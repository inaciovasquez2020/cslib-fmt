from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

TARGETS = [
    ROOT / "FMT" / "Graph" / "ExistsMinPath.lean",
    ROOT / "FMT" / "Graph" / "DistancePathBound.lean",
    ROOT / "FMT" / "Graph" / "DistanceSymmetry.lean",
    ROOT / "FMT" / "Invariants" / "NonFactorization.lean",
]


def test_no_vacuous_true_theorem_shells_remain():
    for path in TARGETS:
        text = path.read_text()
        assert "True := by" not in text
        assert "\n  trivial" not in text


def test_graph_placeholders_replaced_by_existing_distance_or_shortest_path_theorems():
    assert "exists_shortest_path_length" in (ROOT / "FMT" / "Graph" / "ExistsMinPath.lean").read_text()
    assert "dist?_le_of_path" in (ROOT / "FMT" / "Graph" / "DistancePathBound.lean").read_text()
    assert "dist?_symm" in (ROOT / "FMT" / "Graph" / "DistanceSymmetry.lean").read_text()


def test_nonfactorization_is_status_object_not_theorem_shell():
    text = (ROOT / "FMT" / "Invariants" / "NonFactorization.lean").read_text()
    assert "inductive NonFactorizationFrontierStatus" in text
    assert "theorem badF_factorsThrough" not in text
    assert "theorem nonFactorization_placeholder" not in text
