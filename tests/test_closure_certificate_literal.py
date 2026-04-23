from pathlib import Path

def test_closure_certificate_literal():
    text = Path("docs/status/CLOSURE_CERTIFICATE.md").read_text()
    assert "Certified object: repository-scoped closure certificate for cslib-fmt." in text
    assert "Certified scope: denominator-scoped only." in text
    assert "Scoped denominator: 4" in text
    assert "Scoped completion: 4/4" in text
    assert "Scoped percentage: 100%" in text
    assert "Scoped closure status: COMPLETE" in text
    assert "No claim is made beyond the counted scoped denominator." in text
    assert "The current repository-scoped counted denominator is closed." in text
