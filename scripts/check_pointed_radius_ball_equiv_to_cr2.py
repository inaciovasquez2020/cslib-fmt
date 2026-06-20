#!/usr/bin/env python3
import argparse
import json
import re
import subprocess
from pathlib import Path

LEAN = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
ARTIFACT = Path("artifacts/cslib_fmt/pointed_radius_ball_equiv_to_cr2_2026_06_19.json")
DOC = Path("docs/status/POINTED_RADIUS_BALL_EQUIV_TO_CR2_2026_06_19.md")

THEOREM = "pointed_radius_ball_equiv_to_cr2"
SOURCE = "pointed_radius_ball_equiv_to_plain_induced_radius_ball_isomorphism"
TARGET = "plain_induced_radius_ball_isomorphism_to_cr2"

def require(condition, message):
    if not condition:
        raise SystemExit(message)

def git_output(*args):
    return subprocess.check_output(["git", *args], text=True).strip()

def theorem_block(text):
    pattern = re.compile(
        rf"theorem\s+{THEOREM}\b(?P<body>.*?)(?=\n/--|\ntheorem\s|\nlemma\s|\ndef\s|\nabbrev\s|\Z)",
        re.S,
    )
    m = pattern.search(text)
    require(m is not None, f"MISSING_OBJECT := {THEOREM}")
    return m.group(0)

def make_payload():
    require(LEAN.exists(), f"MISSING_OBJECT := {LEAN}")
    text = LEAN.read_text()
    block = theorem_block(text)
    require(SOURCE in block, f"MISSING_OBJECT := {SOURCE}")
    require(TARGET in block, f"MISSING_OBJECT := {TARGET}")
    require("Cr2 𝒜 ℬ r a b" in block, "MISSING_TARGET := Cr2 𝒜 ℬ r a b")
    require("PointedRadiusBallEquiv 𝒜 ℬ r a b" in block, "MISSING_SOURCE := PointedRadiusBallEquiv 𝒜 ℬ r a b")
    require("ballIso_to_cr2" not in text, "FORBIDDEN_OBJECT := ballIso_to_cr2")

    return {
        "id": "POINTED_RADIUS_BALL_EQUIV_TO_CR2_2026_06_19",
        "repo": "cslib-fmt",
        "head": git_output("rev-parse", "HEAD"),
        "file": str(LEAN),
        "theorem": THEOREM,
        "statement": "PointedRadiusBallEquiv 𝒜 ℬ r a b → Cr2 𝒜 ℬ r a b",
        "proof_path": [
            "PointedRadiusBallEquiv 𝒜 ℬ r a b",
            "PlainInducedRadiusBallIso 𝒜 ℬ r a b",
            "Cr2 𝒜 ℬ r a b"
        ],
        "uses": [SOURCE, TARGET],
        "forbidden_wrapper_not_added": "ballIso_to_cr2",
        "boundary": "BOUNDARY := ¬ cr2_unconditional_constructor"
    }

def write_outputs(payload):
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    DOC.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    DOC.write_text(
        "# Pointed radius-ball equivalence to Cr2\n\n"
        "STATUS := CONDITIONAL_CONSTRUCTOR_SOURCE_TO_CR2\n\n"
        "THEOREM := `pointed_radius_ball_equiv_to_cr2`\n\n"
        "STATEMENT := `PointedRadiusBallEquiv 𝒜 ℬ r a b → Cr2 𝒜 ℬ r a b`\n\n"
        "PROOF_PATH := `PointedRadiusBallEquiv → PlainInducedRadiusBallIso → Cr2`\n\n"
        "USES :=\n"
        "- `pointed_radius_ball_equiv_to_plain_induced_radius_ball_isomorphism`\n"
        "- `plain_induced_radius_ball_isomorphism_to_cr2`\n\n"
        "FORBIDDEN_WRAPPER_NOT_ADDED := `ballIso_to_cr2`\n\n"
        "BOUNDARY := ¬ cr2_unconditional_constructor\n"
    )

def verify_payload(payload):
    current = make_payload()
    require(payload["id"] == current["id"], "BAD_ID")
    require(payload["repo"] == current["repo"], "BAD_REPO")
    require(payload["file"] == current["file"], "BAD_FILE")
    require(payload["theorem"] == current["theorem"], "BAD_THEOREM")
    require(payload["statement"] == current["statement"], "BAD_STATEMENT")
    require(payload["proof_path"] == current["proof_path"], "BAD_PROOF_PATH")
    require(payload["uses"] == current["uses"], "BAD_USES")
    require(payload["forbidden_wrapper_not_added"] == current["forbidden_wrapper_not_added"], "BAD_FORBIDDEN_WRAPPER")
    require(payload["boundary"] == "BOUNDARY := ¬ cr2_unconditional_constructor", "BAD_BOUNDARY")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-report", action="store_true")
    args = parser.parse_args()

    if args.write_report:
        write_outputs(make_payload())

    require(ARTIFACT.exists(), f"MISSING_OBJECT := {ARTIFACT}")
    require(DOC.exists(), f"MISSING_OBJECT := {DOC}")
    verify_payload(json.loads(ARTIFACT.read_text()))
    print("POINTED_RADIUS_BALL_EQUIV_TO_CR2_OK")

if __name__ == "__main__":
    main()
