import json
from pathlib import Path


def test_cslib_fmt_zenodo_public_release_artifact():
    artifact = json.loads(Path(
        "artifacts/cslib-fmt/cslib_fmt_zenodo_public_release_2026_06_02.json"
    ).read_text(encoding="utf-8"))

    assert artifact["status"] == "CSLIB_FMT_ZENODO_PUBLIC_RELEASE_PUBLISHED"
    assert artifact["repository"] == "inaciovasquez2020/cslib-fmt"
    assert artifact["zenodo"]["deposition_id"] == 20518144
    assert artifact["zenodo"]["doi"] == "10.5281/zenodo.20518144"
    assert artifact["zenodo"]["conceptdoi"] == "10.5281/zenodo.20518143"
    assert artifact["zenodo"]["record_url"] == "https://zenodo.org/records/20518144"
    assert artifact["next_admissible_object"] == "Stop"


def test_cslib_fmt_zenodo_public_release_boundary():
    artifact = json.loads(Path(
        "artifacts/cslib-fmt/cslib_fmt_zenodo_public_release_2026_06_02.json"
    ).read_text(encoding="utf-8"))

    boundary = set(artifact["boundary"])
    assert "Public finite graph diameter release only" in boundary
    assert "No infinite graph claim" in boundary
    assert "No weighted graph claim" in boundary
    assert "No full graph theory completion claim" in boundary
    assert "No cross-repository theorem closure claim" in boundary


def test_cslib_fmt_zenodo_public_release_doc_tokens():
    doc = Path(
        "docs/status/CSLIB_FMT_ZENODO_PUBLIC_RELEASE_2026_06_02.md"
    ).read_text(encoding="utf-8")

    for token in [
        "CSLIB_FMT_ZENODO_PUBLIC_RELEASE_PUBLISHED",
        "10.5281/zenodo.20518144",
        "10.5281/zenodo.20518143",
        "https://zenodo.org/records/20518144",
        "Stop",
    ]:
        assert token in doc
