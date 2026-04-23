import json
from pathlib import Path

def test_closure_snapshot_sync():
    snapshot = json.loads(Path("artifacts/closure/cslib_fmt_closure_snapshot.json").read_text())
    scope_text = Path("docs/status/CLOSURE_SCOPE.md").read_text()
    cert_text = Path("docs/status/CLOSURE_CERTIFICATE.md").read_text()

    assert snapshot["repo"] == "cslib-fmt"
    assert snapshot["snapshot_kind"] == "repository_scoped_closure"
    assert snapshot["scope"] == "denominator_scoped_only"
    assert snapshot["scoped_denominator"] == 4
    assert snapshot["scoped_completed"] == 4
    assert snapshot["scoped_percentage"] == 100
    assert snapshot["scoped_status"] == "COMPLETE"
    assert snapshot["claims_beyond_scope"] is False

    for text in (scope_text, cert_text):
        assert f"Scoped denominator: {snapshot['scoped_denominator']}" in text
        assert f"Scoped completion: {snapshot['scoped_completed']}/{snapshot['scoped_denominator']}" in text
        assert f"Scoped percentage: {snapshot['scoped_percentage']}%" in text
        assert f"Scoped closure status: {snapshot['scoped_status']}" in text
