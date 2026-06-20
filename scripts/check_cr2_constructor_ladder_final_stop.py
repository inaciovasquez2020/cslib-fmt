#!/usr/bin/env python3
import argparse
import json
import subprocess
from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/cr2_constructor_ladder_final_stop_2026_06_19.json")
DOC = Path("docs/status/CR2_CONSTRUCTOR_LADDER_FINAL_STOP_2026_06_19.md")

REQUIRED_THEOREMS = [
    "plain_induced_radius_ball_isomorphism_to_cr2",
    "pointed_radius_ball_equiv_to_cr2",
    "localIso_to_cr2",
]

REQUIRED_STATUS_LOCKS = [
    "artifacts/cslib_fmt/no_earlier_localiso_constructor_source_2026_06_19.json",
    "artifacts/cslib_fmt/no_external_below_localiso_constructor_source_2026_06_19.json",
]

def require(condition, message):
    if not condition:
        raise SystemExit(message)

def git_output(*args):
    return subprocess.check_output(["git", *args], text=True).strip()

def make_payload():
    require(LEAN.exists(), f"MISSING_OBJECT := {LEAN}")
    text = LEAN.read_text()

    for theorem in REQUIRED_THEOREMS:
        require(f"theorem {theorem}" in text, f"MISSING_OBJECT := {theorem}")

    require("theorem ballIso_to_cr2" not in text, "FORBIDDEN_OBJECT := theorem ballIso_to_cr2")
    require("theorem cr2_unconditional_constructor" not in text, "BOUNDARY := ¬ cr2_unconditional_constructor")

    for path in REQUIRED_STATUS_LOCKS:
        require(Path(path).exists(), f"MISSING_OBJECT := {path}")

    return {
        "id": "CR2_CONSTRUCTOR_LADDER_FINAL_STOP_2026_06_19",
        "repo": "cslib-fmt",
        "head_at_validation": git_output("rev-parse", "HEAD"),
        "closed_conditional_chain": [
            "PlainInducedRadiusBallIso → Cr2",
            "PointedRadiusBallEquiv → PlainInducedRadiusBallIso → Cr2",
            "LocalIso → BallIso → PointedRadiusBallEquiv → Cr2",
        ],
        "stopping_lock_inputs": REQUIRED_STATUS_LOCKS,
        "ladder_status": "bounded Cr2 constructor ladder stops at LocalIso",
        "patch_decision": "no_new_theorem",
        "forbidden_wrapper_not_added": "ballIso_to_cr2",
        "boundary": "BOUNDARY := ¬ cr2_unconditional_constructor",
    }

def write_outputs(payload):
    ARTIFACT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    DOC.write_text(
        "# Cr2 constructor ladder final stop\n\n"
        "STATUS := FINAL_BOUNDED_CR2_LADDER_STOP\n\n"
        "CLOSED_CONDITIONAL_CHAIN :=\n"
        "- `PlainInducedRadiusBallIso → Cr2`\n"
        "- `PointedRadiusBallEquiv → PlainInducedRadiusBallIso → Cr2`\n"
        "- `LocalIso → BallIso → PointedRadiusBallEquiv → Cr2`\n\n"
        "STOPPING_LOCKS :=\n"
        "- `NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19`\n"
        "- `NO_EXTERNAL_BELOW_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19`\n\n"
        "LADDER_STATUS := bounded Cr2 constructor ladder stops at `LocalIso`.\n\n"
        "PATCH_DECISION := no new theorem.\n\n"
        "FORBIDDEN_WRAPPER_NOT_ADDED := `ballIso_to_cr2`\n\n"
        "BOUNDARY := ¬ cr2_unconditional_constructor\n"
    )

def verify_payload(payload):
    current = make_payload()
    require(payload["id"] == current["id"], "BAD_ID")
    require(payload["repo"] == current["repo"], "BAD_REPO")
    require(payload["closed_conditional_chain"] == current["closed_conditional_chain"], "BAD_CHAIN")
    require(payload["stopping_lock_inputs"] == current["stopping_lock_inputs"], "BAD_STOPPING_LOCK_INPUTS")
    require(payload["ladder_status"] == current["ladder_status"], "BAD_LADDER_STATUS")
    require(payload["patch_decision"] == "no_new_theorem", "BAD_PATCH_DECISION")
    require(payload["forbidden_wrapper_not_added"] == "ballIso_to_cr2", "BAD_FORBIDDEN_WRAPPER")
    require(payload["boundary"] == "BOUNDARY := ¬ cr2_unconditional_constructor", "BAD_BOUNDARY")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-report", action="store_true")
    args = parser.parse_args()

    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)

    if args.write_report:
        write_outputs(make_payload())

    require(ARTIFACT.exists(), f"MISSING_OBJECT := {ARTIFACT}")
    require(DOC.exists(), f"MISSING_OBJECT := {DOC}")
    verify_payload(json.loads(ARTIFACT.read_text()))
    print("CR2_CONSTRUCTOR_LADDER_FINAL_STOP_OK")

if __name__ == "__main__":
    main()
