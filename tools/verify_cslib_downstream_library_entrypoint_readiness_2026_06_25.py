#!/usr/bin/env python3
from __future__ import annotations

import json
import pathlib
import subprocess
import sys

TARGET_ID = "CSLIB_DOWNSTREAM_LIBRARY_ENTRYPOINT_READINESS_2026_06_25"
TARGET_LOWER = "cslib_downstream_library_entrypoint_readiness_2026_06_25"

ROOT = pathlib.Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "external_validation" / f"{TARGET_LOWER}.json"
DOC = ROOT / "docs" / "status" / f"{TARGET_ID}.md"
LEAN = ROOT / "lean" / "CSLIB" / "FMT" / "UnguardedFO" / "DownstreamLibraryEntrypointReadiness.lean"

REQUIRED_BOUNDARIES = [
    "BOUNDARY := not full_CSLIB_downstream_theorem_solved",
    "BOUNDARY := not universal_FO_locality_framework_closed",
    "BOUNDARY := not downstream_adoption_completed",
]

FORBIDDEN_TOKENS = ["sorry", "admit", "axiom", "opaque"]


def fail(message: str) -> None:
    print(f"{TARGET_ID}_FAILED: {message}", file=sys.stderr)
    sys.exit(1)


def read(path: pathlib.Path) -> str:
    if not path.exists():
        fail(f"missing required file: {path.relative_to(ROOT)}")
    return path.read_text(encoding="utf-8")


def git_is_available() -> bool:
    try:
        subprocess.run(
            ["git", "rev-parse", "--is-inside-work-tree"],
            cwd=ROOT,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        return True
    except Exception:
        return False


def main() -> None:
    artifact_text = read(ARTIFACT)
    doc_text = read(DOC)

    try:
        artifact = json.loads(artifact_text)
    except json.JSONDecodeError as exc:
        fail(f"artifact is not valid json: {exc}")

    if artifact.get("target_id") != TARGET_ID:
        fail("artifact target_id mismatch")

    status = artifact.get("status")
    if status not in {"constructed", "missing_object_recorded"}:
        fail("artifact status must be constructed or missing_object_recorded")

    for boundary in REQUIRED_BOUNDARIES:
        if boundary not in artifact_text:
            fail(f"artifact missing boundary: {boundary}")
        if boundary not in doc_text:
            fail(f"doc missing boundary: {boundary}")

    if "full CSLib closure" not in doc_text and "full CSLIB" not in doc_text:
        fail("doc must explicitly avoid full CSLib closure")

    if "universal theorem closure" not in doc_text:
        fail("doc must explicitly avoid universal theorem closure")

    if status == "constructed":
        lean_text = read(LEAN)
        required_lean_tokens = [
            "import CSLIB.FMT.UnguardedFO.DownstreamLibrary",
            "downstream_library_entrypoint_readiness_statement",
            "downstream_library_radius_zero_locality_input_ready",
            "downstream_library_full_formula_radius_status_ready",
            "downstream_library_entrypoint_current_wall",
            "#check downstream_library_radius_zero_locality_input",
            "#check downstream_library_full_formula_radius_status",
        ]
        for token in required_lean_tokens:
            if token not in lean_text:
                fail(f"Lean file missing token: {token}")

        lowered = lean_text.lower()
        for token in FORBIDDEN_TOKENS:
            if token in lowered:
                fail(f"forbidden Lean token present: {token}")

    if status == "missing_object_recorded":
        if not artifact.get("weakest_missing_object"):
            fail("missing-object artifact must record weakest_missing_object")

    if git_is_available():
        subprocess.run(
            ["git", "merge-base", "--is-ancestor", "HEAD", "HEAD"],
            cwd=ROOT,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )

    print(f"{TARGET_ID}_OK")


if __name__ == "__main__":
    main()
