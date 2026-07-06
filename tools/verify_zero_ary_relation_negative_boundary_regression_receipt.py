#!/usr/bin/env python3
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RECEIPT = ROOT / "artifacts/status/zero_ary_relation_negative_boundary_regression_receipt_2026_07_06.json"
INPUT_RECEIPT = ROOT / "artifacts/status/zero_one_law_zero_ary_relation_negative_boundary_receipt_2026_07_05.json"

EXPECTED_BOUNDARY = {
    "arity(P) = 0",
    "phi = P",
    "Pr[A_n models P] = 1/2 for every n",
    "limit is 1/2 not in {0,1}",
    "positive arity is necessary unless 0-ary relation symbols are excluded or deterministic",
}

EXPECTED_FORBIDDEN = {
    "ZERO_ARY_RELATION_POSITIVE_CLOSURE",
    "RANDOM_ZERO_ARY_RELATION_ZERO_ONE_LAW",
    "GLOBAL_VOCABULARY_CLOSURE",
    "UNRESTRICTED_FMT_CLOSURE",
    "FAGIN_THEOREM",
    "LEAN_FORMAL_COUNTEREXAMPLE_THEOREM",
}


def fail(message: str) -> None:
    raise SystemExit(f"ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_REGRESSION_RECEIPT_FAIL: {message}")


def load_json(path: Path) -> dict:
    if not path.exists():
        fail(f"missing {path.relative_to(ROOT)}")
    try:
        return json.loads(path.read_text())
    except json.JSONDecodeError as exc:
        fail(f"invalid json in {path.relative_to(ROOT)}: {exc}")


def require(condition: bool, message: str) -> None:
    if not condition:
        fail(message)


def main() -> None:
    receipt = load_json(RECEIPT)
    input_receipt = load_json(INPUT_RECEIPT)

    require(
        input_receipt.get("status") == "ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_RECORDED",
        "input zero-ary negative boundary receipt status changed",
    )

    counterexample = input_receipt.get("counterexample", {})
    require(counterexample.get("arity") == "arity(P) = 0", "input arity witness changed")
    require(counterexample.get("sentence") == "phi = P", "input sentence witness changed")
    require(
        counterexample.get("probability") == "Pr[A_n models P] = 1/2 for every n",
        "input probability witness changed",
    )
    require(
        counterexample.get("limit") == "lim_n Pr[A_n models P] = 1/2 not in {0,1}",
        "input limit witness changed",
    )

    require(
        receipt.get("artifact") == "zero_ary_relation_negative_boundary_regression_receipt_2026_07_06",
        "unexpected artifact name",
    )
    require(receipt.get("repository") == "cslib-fmt", "unexpected repository")
    require(
        receipt.get("status") == "ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_REGRESSION_RECEIPT_RECORDED",
        "unexpected status",
    )
    require(
        receipt.get("input_receipt")
        == "artifacts/status/zero_one_law_zero_ary_relation_negative_boundary_receipt_2026_07_05.json",
        "unexpected input receipt pointer",
    )

    guard_statement = receipt.get("guard_statement", "")
    for fragment in (
        "random 0-ary relation symbol P",
        "Pr[A_n models P] = 1/2 for every n",
        "limiting probability is 1/2",
        "not in {0,1}",
        "exclude random 0-ary relation symbols",
        "make them deterministic",
    ):
        require(fragment in guard_statement, f"guard statement missing fragment: {fragment}")

    require(
        set(receipt.get("checked_boundary", [])) == EXPECTED_BOUNDARY,
        "checked boundary set changed",
    )
    require(
        set(receipt.get("forbidden_regressions", [])) == EXPECTED_FORBIDDEN,
        "forbidden regression set changed",
    )

    positive_surface = json.dumps(
        {
            "status": receipt.get("status"),
            "scope": receipt.get("scope"),
            "guard_statement": receipt.get("guard_statement"),
            "checked_boundary": receipt.get("checked_boundary"),
        },
        sort_keys=True,
    )
    for forbidden in EXPECTED_FORBIDDEN:
        require(
            forbidden not in positive_surface,
            f"forbidden regression appears in positive surface: {forbidden}",
        )

    boundary = receipt.get("boundary", "")
    for fragment in (
        "only a regression guard",
        "random 0-ary relation negative boundary",
        "does not prove a global vocabulary closure",
        "unrestricted finite-model-theory closure",
        "Fagin theorem",
        "Lean-formal counterexample theorem",
    ):
        require(fragment in boundary, f"boundary missing fragment: {fragment}")

    print("ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_REGRESSION_RECEIPT_OK")


if __name__ == "__main__":
    main()
