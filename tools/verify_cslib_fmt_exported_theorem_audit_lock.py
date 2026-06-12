#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STAMP = "2026_06_11"
OBJECT = f"CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_{STAMP}"
ARTIFACT = ROOT / "artifacts" / "status" / f"cslib_fmt_exported_theorem_audit_lock_{STAMP}.json"
STATUS = ROOT / "docs" / "status" / f"CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_{STAMP}.md"

REQUIRED_POLICY = {
    "definitions_are_not_theorems": True,
    "prop_specifications_are_not_proofs": True,
    "target_statements_are_not_proofs": True,
    "placeholder_witnesses_are_not_final_closure": True,
    "build_success_is_not_theorem_level_closure": True,
    "final_theorem_claim_requires_file_theorem_dependency_chain_and_proof_status": True,
}

REQUIRED_NONCLAIMS = {
    "No repository-level final-solve claim is asserted.",
    "No universal library-completeness claim is asserted.",
    "No peer-reviewed acceptance claim is asserted unless separately documented.",
    "No internal Lean theorem target is promoted by this audit lock.",
}


def fail(message: str) -> None:
    raise SystemExit(f"CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_ERROR: {message}")


def main() -> None:
    if not ARTIFACT.exists():
        fail(f"missing artifact {ARTIFACT.relative_to(ROOT)}")
    if not STATUS.exists():
        fail(f"missing status {STATUS.relative_to(ROOT)}")

    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    text = STATUS.read_text(encoding="utf-8")

    if data.get("object") != OBJECT:
        fail("object mismatch")
    if data.get("repository") != "inaciovasquez2020/cslib-fmt":
        fail("repository mismatch")
    if data.get("classification") != "exported_theorem_audit_lock":
        fail("classification mismatch")
    if data.get("internal_live_frontier") != "none":
        fail("internal frontier must remain none")
    if data.get("theorem_level_closure_claim") is not False:
        fail("theorem-level closure claim must remain false")
    if data.get("strongest_verified_theorem_at_repository_level") != "not_asserted":
        fail("strongest repository-level theorem must remain not asserted")
    if data.get("admissible_next_object") != "ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow":
        fail("next admissible object mismatch")
    if data.get("audit_policy") != REQUIRED_POLICY:
        fail("audit policy mismatch")
    if set(data.get("nonclaim_boundary", [])) != REQUIRED_NONCLAIMS:
        fail("nonclaim boundary mismatch")

    required_text = [
        OBJECT,
        "Internal theorem frontier",
        "None.",
        "ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow",
        "No repository-level final-solve claim is asserted.",
        "No internal Lean theorem target is promoted by this audit lock.",
    ]
    missing = [needle for needle in required_text if needle not in text]
    if missing:
        fail("status missing required text: " + ", ".join(missing))

    print("CSLIB_FMT_EXPORTED_THEOREM_AUDIT_LOCK_OK")


if __name__ == "__main__":
    main()
