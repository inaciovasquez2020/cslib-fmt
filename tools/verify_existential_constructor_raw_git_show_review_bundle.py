from __future__ import annotations

import hashlib
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_raw_git_show_review_bundle_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_gemini_artifact_accessible_ai_assisted_review_response_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_REVIEW_BUNDLE.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_REVIEW_BUNDLE_ONLY"
OBJECT = "existential_constructor_raw_git_show_review_bundle"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_GEMINI_ARTIFACT_ACCESSIBLE_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
SOURCE_COMMIT = "ae19608"
TARGET_COMMIT = "cc60f9a"
NEXT = "raw_git_show_artifact_verified_reviewer_response"
RAW_PATH = "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"


def git_show(path: str) -> bytes:
    return subprocess.check_output(["git", "show", f"{TARGET_COMMIT}:{path}"], cwd=ROOT)


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "external_independent_validation_or_live_repository_review"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["raw_git_show_command"] == f"git show {TARGET_COMMIT}:{RAW_PATH}"
    assert payload["raw_bundle_type"] == "public_gist"
    assert payload["raw_bundle_url"].startswith("https://gist.github.com/inaciovasquez2020/")
    assert payload["review_issue_url"].startswith("https://github.com/inaciovasquez2020/cslib-fmt/issues/")
    assert payload["review_request_comment_posted"] is True
    assert payload["claim"] == "raw_git_show_artifact_bundle_and_review_request_only"
    assert payload["weakest_next_boundary"] == NEXT

    raw = git_show(RAW_PATH)
    raw_hash = hashlib.sha256(raw).hexdigest()
    assert payload["raw_file_sha256"] == raw_hash

    text = raw.decode()
    start = text.index("def existential_constructor_actual_downstream_theorem_use_status : Prop :=")
    end = text.index("\nend ", start)
    edge = text[start:end].strip() + "\n"
    edge_hash = hashlib.sha256(edge.encode()).hexdigest()
    assert payload["named_edge_excerpt_sha256"] == edge_hash

    assert "existential_constructor_actual_downstream_theorem_use_status_closed" in edge
    for token in ["sorry", "admit", "axiom", "opaque"]:
        assert token not in edge.lower()

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "independent_expert_validation" in forbidden
    assert "reviewer_response" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "reviewer_reran_verifier" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "REVIEW_REQUEST_COMMENT_POSTED := true" in doc
    assert "does not claim external acceptance" in doc

    print("EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_REVIEW_BUNDLE_OK")


if __name__ == "__main__":
    main()
