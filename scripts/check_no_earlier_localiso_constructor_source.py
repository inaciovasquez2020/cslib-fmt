#!/usr/bin/env python3
import argparse
import json
import re
import subprocess
from pathlib import Path

LEAN_ROOT = Path("lean")
ARTIFACT = Path("artifacts/cslib_fmt/no_earlier_localiso_constructor_source_2026_06_19.json")
DOC = Path("docs/status/NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19.md")
TARGET = "LocalIso"

def require(condition, message):
    if not condition:
        raise SystemExit(message)

def git_output(*args):
    return subprocess.check_output(["git", *args], text=True).strip()

def top_level_return_type(header: str) -> str:
    depth = 0
    idx = -1
    for i, ch in enumerate(header):
        if ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth = max(0, depth - 1)
        elif ch == ":" and depth == 0:
            idx = i
    return header[idx + 1:].strip() if idx >= 0 else ""

def final_codomain(type_text: str) -> str:
    depth = 0
    last = 0
    i = 0
    while i < len(type_text):
        if type_text[i] in "([{":
            depth += 1
            i += 1
            continue
        if type_text[i] in ")]}":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and type_text.startswith("↔", i):
            return ""
        if depth == 0 and type_text.startswith("→", i):
            last = i + 1
            i += 1
            continue
        if depth == 0 and type_text.startswith("->", i):
            last = i + 2
            i += 2
            continue
        i += 1
    return " ".join(type_text[last:].split())

def producers():
    require(LEAN_ROOT.exists(), "MISSING_OBJECT := lean")
    decl_re = re.compile(
        r"(?ms)^[ \t]*(?:(?:@[^\n]*\n)[ \t]*)*"
        r"(?:(?:noncomputable|private|protected)\s+)*"
        r"(theorem|lemma|def|abbrev)\s+([A-Za-z_][A-Za-z0-9_'.]*)\b"
        r"(?P<header>.*?)(?=:=|\n[ \t]*where\b)"
    )
    tracked = [
        "OrdinaryPointedRadiusBallBijection",
        "PointedRadiusBallEquiv",
        "PlainInducedRadiusBallIso",
        "BallIso",
        "LocalIso",
        "Iso",
        "Equiv",
    ]
    hits = []
    for path in sorted(LEAN_ROOT.rglob("*.lean")):
        text = path.read_text()
        for m in decl_re.finditer(text):
            kind, name = m.group(1), m.group(2)
            header = m.group("header")
            codomain = final_codomain(top_level_return_type(header))
            if re.match(rf"^{TARGET}\b", codomain):
                hits.append({
                    "file": str(path),
                    "line": text.count("\n", 0, m.start()) + 1,
                    "kind": kind,
                    "name": name,
                    "codomain": codomain,
                    "assumption_surfaces": [s for s in tracked if s in header],
                })
    return hits

def earlier_constructor_sources(hits):
    return [
        h for h in hits
        if h["name"] != "ballIso_to_localIso"
        and h["name"] != "localIso_to_cr2"
        and not (
            "BallIso" in h["assumption_surfaces"]
            or "LocalIso" in h["assumption_surfaces"]
        )
    ]

def make_payload():
    hits = producers()
    earlier = earlier_constructor_sources(hits)
    require(not earlier, "FOUND_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE := " + json.dumps(earlier, ensure_ascii=False))
    return {
        "id": "NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19",
        "repo": "cslib-fmt",
        "head_at_validation": git_output("rev-parse", "HEAD"),
        "search_scope": "lean/**/*.lean",
        "target": "LocalIso 𝒜 ℬ r a b",
        "all_localiso_producers": hits,
        "weakest_existing_producer": "ballIso_to_localIso",
        "classification": "back_wrapper_not_strictly_earlier_constructor_source",
        "result": "NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE",
        "patch_decision": "no_new_theorem",
        "boundary": "BOUNDARY := ¬ cr2_unconditional_constructor",
    }

def write_outputs(payload):
    ARTIFACT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    DOC.write_text(
        "# No earlier LocalIso constructor source\n\n"
        "STATUS := NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE\n\n"
        "TARGET := `LocalIso 𝒜 ℬ r a b`\n\n"
        "WEAKEST_EXISTING_PRODUCER := `ballIso_to_localIso`\n\n"
        "CLASSIFICATION := back-wrapper from `BallIso`, not a strictly earlier constructor source.\n\n"
        "PATCH_DECISION := no new theorem.\n\n"
        "BOUNDARY := ¬ cr2_unconditional_constructor\n"
    )

def verify_payload(payload):
    current = make_payload()
    require(payload["id"] == current["id"], "BAD_ID")
    require(payload["repo"] == current["repo"], "BAD_REPO")
    require(payload["target"] == current["target"], "BAD_TARGET")
    require(payload["weakest_existing_producer"] == "ballIso_to_localIso", "BAD_WEAKEST_PRODUCER")
    require(payload["classification"] == "back_wrapper_not_strictly_earlier_constructor_source", "BAD_CLASSIFICATION")
    require(payload["result"] == "NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE", "BAD_RESULT")
    require(payload["patch_decision"] == "no_new_theorem", "BAD_PATCH_DECISION")
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
    print("NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE_OK")

if __name__ == "__main__":
    main()
