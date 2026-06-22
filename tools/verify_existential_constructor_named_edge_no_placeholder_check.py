from __future__ import annotations

import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_named_edge_no_placeholder_check_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_ai_assisted_review_response_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_NAMED_EDGE_NO_PLACEHOLDER_CHECK.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "LocalityInputSurface.lean"

STATUS = "EXISTENTIAL_CONSTRUCTOR_NAMED_EDGE_NO_PLACEHOLDER_CHECK_ONLY"
OBJECT = "existential_constructor_named_edge_no_placeholder_check"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_AI_ASSISTED_REVIEW_RESPONSE_ONLY"
SOURCE_COMMIT = "dd45328"
TARGET_COMMIT = "cc60f9a"
NEXT = "artifact_accessible_independent_review"
DECLARATIONS = [
    "existential_constructor_actual_downstream_theorem_use_status",
    "existential_constructor_actual_downstream_theorem_use_status_closed",
]
FORBIDDEN = ["sorry", "admit", "axiom", "opaque"]


def git(*args: str) -> str:
    return subprocess.check_output(["git", *args], cwd=ROOT, text=True).strip()


def extract_named_edge(text: str) -> str:
    start = text.index("def existential_constructor_actual_downstream_theorem_use_status : Prop :=")
    end_marker = "\nend "
    end = text.index(end_marker, start)
    return text[start:end]


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "explicit_no_sorry_or_no_admitted_placeholder_check_for_named_edge"

    assert payload["status"] == STATUS
    assert payload["object"] == OBJECT
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["checked_lean_file"] == "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
    assert payload["claim"] == "named_edge_contains_no_placeholder_or_opaque_token_and_target_commit_is_on_current_ancestry"
    assert payload["weakest_next_boundary"] == NEXT

    for name in DECLARATIONS:
        assert name in payload["checked_declarations"]
    for token in FORBIDDEN:
        assert token in payload["forbidden_tokens_absent_from_named_edge"]

    subprocess.check_call(["git", "merge-base", "--is-ancestor", TARGET_COMMIT, "HEAD"], cwd=ROOT)
    assert git("diff", "--name-only", f"{TARGET_COMMIT}..HEAD", "--", str(LEAN.relative_to(ROOT))) == ""

    lean = LEAN.read_text()
    edge = extract_named_edge(lean)
    for name in DECLARATIONS:
        assert name in edge
    lowered = edge.lower()
    for token in FORBIDDEN:
        assert token not in lowered

    forbidden_claims = payload["does_not_claim"]
    assert "artifact_verified_external_review" in forbidden_claims
    assert "independent_expert_validation" in forbidden_claims
    assert "external_acceptance" in forbidden_claims
    assert "Fagin_theorem" in forbidden_claims
    assert "zero_one_law" in forbidden_claims
    assert "Pk1_route_closed" in forbidden_claims
    assert "TwoVK_route_closed" in forbidden_claims
    assert "new_external_mathematical_acceptance" in forbidden_claims

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"OBJECT := {OBJECT}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert f"SOURCE_STATUS := {SOURCE_STATUS}" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc
    assert "ANCESTRY_CHECK := cc60f9a_is_ancestor_of_HEAD" in doc
    assert "POST_TARGET_LEAN_CHANGE_CHECK := no_LocalityInputSurface_lean_change_between_cc60f9a_and_HEAD" in doc
    for name in DECLARATIONS:
        assert f"`{name}`" in doc
    for token in FORBIDDEN:
        assert f"`{token}`" in doc

    print("EXISTENTIAL_CONSTRUCTOR_NAMED_EDGE_NO_PLACEHOLDER_CHECK_OK")


if __name__ == "__main__":
    main()
