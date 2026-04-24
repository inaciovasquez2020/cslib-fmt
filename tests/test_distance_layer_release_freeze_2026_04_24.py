from pathlib import Path

DOC = Path("docs/status/DISTANCE_LAYER_RELEASE_FREEZE_2026_04_24.md").read_text()

def test_distance_layer_release_freeze_is_precise():
    assert "Status: RELEASE FREEZE." in DOC
    assert "dist?_le_of_path" in DOC
    assert "dist?_symm" in DOC
    assert "dist?_triangle" in DOC
    assert "distLE_triangle" in DOC
    assert "cslib-fmt-distance-layer-closed-grep-clean-2026-04-23" in DOC
    assert "27 passed" in DOC
    assert "graph distance layer is theorem-level closed and release-frozen" in DOC
    assert "No claim is made about unrelated graph modules" in DOC
