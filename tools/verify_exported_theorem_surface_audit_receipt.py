#!/usr/bin/env python3
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "external_validation" / "exported_theorem_surface_audit_receipt_2026_07_05.json"

REQUIRED_BOUNDARIES = {
    "BOUNDARY := ¬ exported_theorem_audit_receipt_implies_global_FMT_closure",
    "BOUNDARY := ¬ exported_theorem_audit_receipt_implies_Fagin_theorem",
    "BOUNDARY := ¬ exported_theorem_audit_receipt_implies_zero_one_law",
    "BOUNDARY := ¬ exported_theorem_audit_receipt_implies_Pk1_route_closure",
    "BOUNDARY := ¬ exported_theorem_audit_receipt_implies_2vK_route_closure",
    "BOUNDARY := ¬ syntactic_declaration_audit_implies_external_acceptance",
}

REQUIRED_NON_CLAIMS = {
    "This receipt does not prove Fagin's theorem.",
    "This receipt does not prove the 0-1 Law.",
    "This receipt does not close the Pk1 route.",
    "This receipt does not close the 2vK route.",
    "This receipt does not prove global finite-model-theory closure.",
    "This receipt does not assert external acceptance.",
    "This receipt is a syntactic declaration-surface audit, not a semantic final-theorem proof.",
}

ALLOWED_CLASSIFICATIONS = {
    "definition_or_specification",
    "verified_lemma",
    "conditional_theorem_or_boundary",
    "scaffold_or_example",
    "forbidden_or_untrusted_declaration",
}

DECL_RE = re.compile(
    r"^\s*(?:@[^\n]+\s*)*(?:private\s+|protected\s+)?"
    r"(theorem|lemma|def|abbrev|structure|inductive|class|instance|axiom|opaque|example)\s+"
    r"([A-Za-z0-9_'.]+)?"
)

FORBIDDEN_POSITIVE_PHRASES = [
    "proves Fagin",
    "proves the 0-1 Law",
    "proves global finite-model-theory closure",
    "closes the Pk1 route",
    "closes the 2vK route",
    "external acceptance confirmed",
]

def fail(msg: str) -> None:
    raise SystemExit(f"EXPORTED_THEOREM_SURFACE_AUDIT_RECEIPT_FAIL := {msg}")

def scan_declarations():
    entries = []
    for path in sorted(ROOT.rglob("*.lean")):
        if ".lake" in path.parts or ".git" in path.parts:
            continue
        rel = path.relative_to(ROOT).as_posix()
        for idx, line in enumerate(path.read_text(errors="ignore").splitlines(), start=1):
            m = DECL_RE.match(line)
            if not m:
                continue
            kind, name = m.groups()
            if not name:
                name = f"anonymous_at_line_{idx}"
            entries.append((rel, idx, kind, name))
    return entries

data = json.loads(ARTIFACT.read_text())

if data.get("schema") != "exported_theorem_surface_audit_receipt.v1":
    fail("bad_schema")

if data.get("repository") != "inaciovasquez2020/cslib-fmt":
    fail("bad_repository")

if data.get("audit_scope") != "syntactic Lean declaration surface audit with theorem-closure nonclaim boundaries":
    fail("bad_audit_scope")

decls = data.get("declarations")
if not isinstance(decls, list):
    fail("declarations_not_list")

scanned = scan_declarations()
artifact_keys = {
    (d.get("file"), int(d.get("line")), d.get("kind"), d.get("name"))
    for d in decls
}
scan_keys = set(scanned)

missing_from_artifact = sorted(scan_keys - artifact_keys)[:20]
if missing_from_artifact:
    fail(f"missing_declarations_from_artifact={missing_from_artifact}")

extra_in_artifact = sorted(artifact_keys - scan_keys)[:20]
if extra_in_artifact:
    fail(f"artifact_decl_not_in_sources={extra_in_artifact}")

if data.get("declaration_count") != len(decls):
    fail("bad_declaration_count")

counts = {}
for d in decls:
    classification = d.get("classification")
    if classification not in ALLOWED_CLASSIFICATIONS:
        fail(f"bad_classification={classification}")
    counts[classification] = counts.get(classification, 0) + 1

if data.get("counts") != counts:
    fail("bad_counts")

boundaries = set(data.get("boundaries", []))
missing_boundaries = REQUIRED_BOUNDARIES - boundaries
if missing_boundaries:
    fail(f"missing_boundaries={sorted(missing_boundaries)}")

non_claims = set(data.get("non_claims", []))
missing_non_claims = REQUIRED_NON_CLAIMS - non_claims
if missing_non_claims:
    fail(f"missing_non_claims={sorted(missing_non_claims)}")

claim_text = json.dumps({
    "audit_scope": data.get("audit_scope"),
    "positive_receipt": data.get("positive_receipt"),
    "boundaries": data.get("boundaries")
}, sort_keys=True)

for phrase in FORBIDDEN_POSITIVE_PHRASES:
    if phrase in claim_text:
        fail(f"forbidden_positive_phrase={phrase}")

print("EXPORTED_THEOREM_SURFACE_AUDIT_RECEIPT_OK")
