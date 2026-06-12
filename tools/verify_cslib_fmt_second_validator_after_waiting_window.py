#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STAMP = "2026_06_11"
OBJECT = f"CSLIB_FMT_SECOND_VALIDATOR_AFTER_WAITING_WINDOW_{STAMP}"
ARTIFACT = ROOT / "artifacts" / "status" / f"cslib_fmt_second_validator_after_waiting_window_{STAMP}.json"
STATUS_DOC = ROOT / "docs" / "status" / f"CSLIB_FMT_SECOND_VALIDATOR_AFTER_WAITING_WINDOW_{STAMP}.md"

REQUIRED_NONCLAIMS = {
    "No external validation acceptance is asserted.",
    "No repository-level final theorem claim is asserted.",
    "No internal theorem target is promoted.",
    "This object only records that the waiting-window branch of the external-validation disjunction is admissible.",
}


def fail(message: str) -> None:
    raise SystemExit(f"CSLIB_FMT_SECOND_VALIDATOR_AFTER_WAITING_WINDOW_ERROR: {message}")


def main() -> None:
    if not ARTIFACT.exists():
        fail(f"missing artifact {ARTIFACT.relative_to(ROOT)}")
    if not STATUS_DOC.exists():
        fail(f"missing status {STATUS_DOC.relative_to(ROOT)}")

    data = json.loads(ARTIFACT.read_text(encoding="utf-8"))
    text = STATUS_DOC.read_text(encoding="utf-8")

    if data.get("object") != OBJECT:
        fail("object mismatch")
    if data.get("repository") != "inaciovasquez2020/cslib-fmt":
        fail("repository mismatch")
    if data.get("classification") != "external_validation_waiting_window_elapsed":
        fail("classification mismatch")
    if data.get("closed_missing_object") != "ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow":
        fail("closed object mismatch")
    if data.get("first_validator_request_date") != "2026-06-03":
        fail("first validator request date mismatch")
    if data.get("first_validator_reply_status") != "absent_or_pending":
        fail("first validator reply status mismatch")
    if data.get("waiting_window_elapsed") is not True:
        fail("waiting window must be elapsed")
    if data.get("second_validator_action_authorized") is not True:
        fail("second validator action must be authorized")
    if data.get("internal_theorem_target_promoted") is not False:
        fail("internal theorem target must not be promoted")
    if data.get("theorem_level_closure_claim") is not False:
        fail("theorem-level closure claim must remain false")
    if data.get("next_admissible_object") != "SendSecondValidatorRequestOrRecordFirstValidatorReply":
        fail("next admissible object mismatch")
    if set(data.get("nonclaim_boundary", [])) != REQUIRED_NONCLAIMS:
        fail("nonclaim boundary mismatch")

    required_text = [
        OBJECT,
        "ExternalValidatorReplyOrSecondValidatorAfterWaitingWindow",
        "2026-06-03",
        "absent_or_pending",
        "Waiting window elapsed: `true`",
        "SendSecondValidatorRequestOrRecordFirstValidatorReply",
        "No external validation acceptance is asserted.",
        "No internal theorem target is promoted.",
    ]
    missing = [needle for needle in required_text if needle not in text]
    if missing:
        fail("status missing required text: " + ", ".join(missing))

    print("CSLIB_FMT_SECOND_VALIDATOR_AFTER_WAITING_WINDOW_OK")


if __name__ == "__main__":
    main()
