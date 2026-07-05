#!/usr/bin/env python3
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts" / "external_validation" / "existential_constructor_downstream_review_receipt_2026_07_05.json"

REQUIRED_BOUNDARIES = {
    "BOUNDARY := ¬ existential_constructor_downstream_review_receipt_implies_global_FMT_closure",
    "BOUNDARY := ¬ existential_constructor_downstream_review_receipt_implies_Fagin_theorem",
    "BOUNDARY := ¬ existential_constructor_downstream_review_receipt_implies_zero_one_law",
    "BOUNDARY := ¬ existential_constructor_downstream_review_receipt_implies_Pk1_route_closure",
    "BOUNDARY := ¬ existential_constructor_downstream_review_receipt_implies_2vK_route_closure",
    "BOUNDARY := ¬ internal_status_edge_review_receipt_implies_external_acceptance",
}

REQUIRED_NON_CLAIMS = {
    "This receipt does not prove Fagin's theorem.",
    "This receipt does not prove the 0-1 Law.",
    "This receipt does not close the Pk1 route.",
    "This receipt does not close the 2vK route.",
    "This receipt does not prove global finite-model-theory closure.",
    "This receipt does not assert external acceptance.",
    "This receipt verifies only a bounded internal downstream status edge.",
}

FORBIDDEN_CLOSURE_PHRASES = [
    "proves Fagin",
    "proves the 0-1 Law",
    "proves global finite-model-theory closure",
    "closes the Pk1 route",
    "closes the 2vK route",
    "external acceptance confirmed",
]

def fail(msg: str) -> None:
    raise SystemExit(f"EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REVIEW_RECEIPT_FAIL := {msg}")

def git_grep(token: str) -> bool:
    proc = subprocess.run(
        ["git", "grep", "-F", "--", token],
        cwd=ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return proc.returncode == 0

data = json.loads(ARTIFACT.read_text())

if data.get("schema") != "existential_constructor_downstream_review_receipt.v1":
    fail("bad_schema")

if data.get("repository") != "inaciovasquez2020/cslib-fmt":
    fail("bad_repository")

if data.get("issue") != 171:
    fail("bad_issue")

if data.get("review_scope") != "bounded internal Lean/status edge review receipt":
    fail("bad_review_scope")

required_commit = data.get("required_commit")
if required_commit != "cc60f9a":
    fail("bad_required_commit")

commit_check = subprocess.run(
    ["git", "cat-file", "-e", f"{required_commit}^{{commit}}"],
    cwd=ROOT,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)
if commit_check.returncode != 0:
    fail(f"missing_required_commit={required_commit}")

required_edge = data.get("required_edge")
if required_edge != "existential_constructor_actual_downstream_theorem_use_status_closed":
    fail("bad_required_edge")

if not git_grep(required_edge):
    fail(f"missing_required_edge={required_edge}")

missing_dependencies = [
    token for token in data.get("required_dependency_edges", [])
    if not git_grep(token)
]
if missing_dependencies:
    fail(f"missing_dependency_edges={missing_dependencies}")

boundaries = set(data.get("boundaries", []))
missing_boundaries = REQUIRED_BOUNDARIES - boundaries
if missing_boundaries:
    fail(f"missing_boundaries={sorted(missing_boundaries)}")

non_claims = set(data.get("non_claims", []))
missing_non_claims = REQUIRED_NON_CLAIMS - non_claims
if missing_non_claims:
    fail(f"missing_non_claims={sorted(missing_non_claims)}")

claim_text = json.dumps({
    "review_scope": data.get("review_scope"),
    "positive_receipt": data.get("positive_receipt"),
    "boundaries": data.get("boundaries")
}, sort_keys=True)

for phrase in FORBIDDEN_CLOSURE_PHRASES:
    if phrase in claim_text:
        fail(f"forbidden_closure_phrase={phrase}")

print("EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REVIEW_RECEIPT_OK")
