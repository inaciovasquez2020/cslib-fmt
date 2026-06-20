#!/usr/bin/env python3
import argparse
import json
import re
import subprocess
from pathlib import Path

LEAN_ROOT = Path("lean")
ARTIFACT = Path("artifacts/cslib_fmt/no_external_below_localiso_constructor_source_2026_06_19.json")
DOC = Path("docs/status/NO_EXTERNAL_BELOW_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19.md")
TARGET = "LocalIso"
PIPELINE = "lean/CSLIB/FMT/GuardedLocality/Pipeline.lean"

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
        ch = type_text[i]
        if ch in "([{":
            depth += 1
            i += 1
            continue
        if ch in ")]}":
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

def localiso_producers():
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

def direct_localiso_mentions():
    hits = []
    needles = ["LocalIso.mk", "{ toFun", "localIso_to_cr2", "ballIso_to_localIso"]
    for path in sorted(LEAN_ROOT.rglob("*.lean")):
        text = path.read_text()
        for i, line in enumerate(text.splitlines(), start=1):
            if any(n in line for n in needles):
                hits.append({"file": str(path), "line": i, "line_text": line.strip()})
    return hits

def external_or_below_candidates(hits):
    candidates = []
    for h in hits:
        if h["name"] in {"ballIso_to_localIso", "localIso_to_cr2"}:
            continue
        if h["file"] != PIPELINE:
            candidates.append(h)
            continue
        assumptions = set(h["assumption_surfaces"])
        if not ({"BallIso", "LocalIso", "Iso", "Equiv"} & assumptions):
            candidates.append(h)
    return candidates

def make_payload():
    hits = localiso_producers()
    candidates = external_or_below_candidates(hits)
    require(not candidates, "FOUND_EXTERNAL_OR_BELOW_LOCALISO_CONSTRUCTOR_SOURCE := " + json.dumps(candidates, ensure_ascii=False))
    return {
        "id": "NO_EXTERNAL_BELOW_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19",
        "repo": "cslib-fmt",
        "head_at_validation": git_output("rev-parse", "HEAD"),
        "search_scope": "lean/**/*.lean",
        "target": "LocalIso 𝒜 ℬ r a b",
        "all_localiso_producers": hits,
        "direct_localiso_mentions": direct_localiso_mentions(),
        "external_or_below_candidates": candidates,
        "result": "NO_EXTERNAL_OR_BELOW_LOCALISO_CONSTRUCTOR_SOURCE",
        "classification": "bounded_Cr2_ladder_stops_at_LocalIso",
        "patch_decision": "no_new_theorem",
        "boundary": "BOUNDARY := ¬ cr2_unconditional_constructor",
    }

def write_outputs(payload):
    ARTIFACT.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n")
    DOC.write_text(
        "# No external or below-LocalIso constructor source\n\n"
        "STATUS := NO_EXTERNAL_OR_BELOW_LOCALISO_CONSTRUCTOR_SOURCE\n\n"
        "TARGET := `LocalIso 𝒜 ℬ r a b`\n\n"
        "RESULT := no declaration in `lean/**/*.lean` produces `LocalIso` from a strictly earlier source.\n\n"
        "KNOWN_PRODUCER := `ballIso_to_localIso`, classified as a back-wrapper from `BallIso`.\n\n"
        "PATCH_DECISION := no new theorem.\n\n"
        "LADDER_STATUS := bounded Cr2 constructor ladder stops at `LocalIso`.\n\n"
        "BOUNDARY := ¬ cr2_unconditional_constructor\n"
    )

def verify_payload(payload):
    current = make_payload()
    require(payload["id"] == current["id"], "BAD_ID")
    require(payload["repo"] == current["repo"], "BAD_REPO")
    require(payload["target"] == current["target"], "BAD_TARGET")
    require(payload["external_or_below_candidates"] == [], "BAD_CANDIDATES")
    require(payload["result"] == "NO_EXTERNAL_OR_BELOW_LOCALISO_CONSTRUCTOR_SOURCE", "BAD_RESULT")
    require(payload["classification"] == "bounded_Cr2_ladder_stops_at_LocalIso", "BAD_CLASSIFICATION")
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
    print("NO_EXTERNAL_BELOW_LOCALISO_CONSTRUCTOR_SOURCE_OK")

if __name__ == "__main__":
    main()
