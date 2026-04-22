import json
from pathlib import Path

def test_scoped_percentage_registry_formula():
    registry = json.loads(Path("docs/status/SCOPED_PERCENTAGE_REGISTRY.json").read_text())
    required = [s for s in registry["surfaces"] if s["required"]]
    complete = [s for s in required if s["status"] == "complete"]
    assert len(required) == 4
    assert len(complete) == 4
    assert int(round(100 * len(complete) / len(required))) == 100

def test_scoped_percentage_registry_surface_labels():
    registry = json.loads(Path("docs/status/SCOPED_PERCENTAGE_REGISTRY.json").read_text())
    labels = {s["id"]: s["status"] for s in registry["surfaces"] if s["required"]}
    assert labels == {
        "graph_distance": "complete",
        "bridge_frontier": "complete",
        "factorization_frontier": "complete",
        "public_factorization_api": "complete",
    }

def test_status_mentions_scoped_percentage():
    text = Path("STATUS.md").read_text()
    assert "docs/status/SCOPED_PERCENTAGE_REGISTRY.json" in text
    assert "- denominator: 4" in text
    assert "- scoped completion percentage: 100% (4/4)" in text
