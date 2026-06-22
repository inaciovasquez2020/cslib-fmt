from __future__ import annotations

import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "existential_constructor_machine_grep_raw_git_show_identifier_visibility_resolution_2026_06_22.json"
SOURCE = ROOT / "artifacts" / "existential_constructor_raw_git_show_ai_review_conflict_2026_06_22.json"
DOC = ROOT / "docs" / "status" / "EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION.md"

STATUS = "EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION_ONLY"
SOURCE_STATUS = "EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT_ONLY"
SOURCE_COMMIT = "6954d09"
TARGET_COMMIT = "cc60f9a"
RAW_PATH = "lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean"
NEXT = "independent_live_repository_or_human_review"
ID_DEF = "existential_constructor_actual_downstream_theorem_use_status"
ID_CLOSED = "existential_constructor_actual_downstream_theorem_use_status_closed"


def raw_text() -> str:
    return subprocess.check_output(
        ["git", "show", f"{TARGET_COMMIT}:{RAW_PATH}"],
        cwd=ROOT,
        text=True,
    )


def line_numbers(text: str, identifier: str) -> list[int]:
    return [i + 1 for i, line in enumerate(text.splitlines()) if identifier in line]


def main() -> None:
    payload = json.loads(ARTIFACT.read_text())
    source = json.loads(SOURCE.read_text())

    assert source["status"] == SOURCE_STATUS
    assert source["weakest_next_boundary"] == "machine_grep_raw_git_show_identifier_visibility_resolution"

    assert payload["status"] == STATUS
    assert payload["source_commit"] == SOURCE_COMMIT
    assert payload["review_target_commit"] == TARGET_COMMIT
    assert payload["source_status"] == SOURCE_STATUS
    assert payload["raw_git_show_command"] == f"git show {TARGET_COMMIT}:{RAW_PATH}"
    assert payload["claim"] == "machine_grep_resolves_ai_visibility_conflict_to_identifier_present_in_raw_git_show_output"
    assert payload["weakest_next_boundary"] == NEXT

    text = raw_text()
    expected_def_lines = line_numbers(text, ID_DEF)
    expected_closed_lines = line_numbers(text, ID_CLOSED)

    assert expected_def_lines
    assert expected_closed_lines

    grep = payload["machine_grep_identifiers"]
    assert grep[ID_DEF]["found"] is True
    assert grep[ID_DEF]["line_numbers"] == expected_def_lines
    assert grep[ID_CLOSED]["found"] is True
    assert grep[ID_CLOSED]["line_numbers"] == expected_closed_lines

    start = text.index("def existential_constructor_actual_downstream_theorem_use_status : Prop :=")
    end = text.index("\nend ", start)
    edge = text[start:end].lower()

    for token in ["sorry", "admit", "axiom", "opaque"]:
        assert token not in edge
        assert token in payload["named_edge_forbidden_tokens_absent"]

    resolution = payload["conflict_resolution"]
    assert resolution["conflict_field"] == "claimed_edge_visible_in_raw_git_show_artifact"
    assert resolution["machine_resolution"] == "identifier_present_in_raw_git_show_output"
    assert resolution["claude_review_status"] == "not_supported_by_machine_grep_except_render_truncation_caveat"
    assert resolution["gemini_review_status"] == "supported_by_machine_grep"

    forbidden = payload["does_not_claim"]
    assert "external_acceptance" in forbidden
    assert "independent_expert_validation" in forbidden
    assert "mathematical_certification" in forbidden
    assert "reviewer_confirmation" in forbidden
    assert "human_review" in forbidden
    assert "Fagin_theorem" in forbidden
    assert "zero_one_law" in forbidden
    assert "Pk1_route_closed" in forbidden
    assert "TwoVK_route_closed" in forbidden
    assert "new_external_mathematical_acceptance" in forbidden

    doc = DOC.read_text()
    assert f"STATUS := {STATUS}" in doc
    assert f"SOURCE_COMMIT := {SOURCE_COMMIT}" in doc
    assert f"REVIEW_TARGET_COMMIT := {TARGET_COMMIT}" in doc
    assert "MACHINE_GREP_RESULT := identifier_present_in_raw_git_show_output" in doc
    assert "CLAUDE_REVIEW_STATUS := not_supported_by_machine_grep_except_render_truncation_caveat" in doc
    assert "GEMINI_REVIEW_STATUS := supported_by_machine_grep" in doc
    assert f"WEAKEST_NEXT_BOUNDARY := {NEXT}" in doc

    print("EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION_OK")


if __name__ == "__main__":
    main()
