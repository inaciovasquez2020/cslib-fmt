#!/usr/bin/env python3
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RECEIPT = ROOT / "artifacts/status/t_ext_back_and_forth_completeness_regression_receipt_2026_07_06.json"
INPUT_RECEIPT = ROOT / "artifacts/status/zero_one_law_back_and_forth_completeness_receipt_2026_07_05.json"

EXPECTED_BOUNDARY = {
    "finite partial isomorphism between finite generated substructures",
    "forward extension",
    "backward extension",
    "countable enumeration schedules all elements of both countable models",
    "union of the chain is a total isomorphism",
    "countable categoricity implies completeness for the extension theory",
    "receipt-level completeness only",
}

EXPECTED_FORBIDDEN = {
    "GLOBAL_ZERO_ONE_LAW_CLOSURE",
    "FAGIN_THEOREM",
    "UNRESTRICTED_FMT_CLOSURE",
    "LEAN_FORMAL_T_EXT_COMPLETENESS_THEOREM",
    "COUNTABLE_THEORY_COMPLETENESS_CLOSURE",
    "UNIFORM_SENTENCE_DECISION_PROCEDURE",
}


def fail(message: str) -> None:
    raise SystemExit(f"T_EXT_BACK_AND_FORTH_COMPLETENESS_REGRESSION_RECEIPT_FAIL: {message}")


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
        input_receipt.get("status") == "T_EXT_COMPLETENESS_BACK_AND_FORTH_RECEIPT_RECORDED",
        "input T_ext back-and-forth receipt status changed",
    )

    input_surface = json.dumps(input_receipt, sort_keys=True)
    for fragment in (
        "finite partial isomorphism between finite generated substructures",
        "forward extension",
        "backward extension",
        "countable enumeration schedules all elements of both countable models",
        "union of the chain is a total isomorphism",
        "countable categoricity implies completeness for the extension theory",
    ):
        require(fragment in input_surface, f"input receipt missing fragment: {fragment}")

    require(
        receipt.get("artifact") == "t_ext_back_and_forth_completeness_regression_receipt_2026_07_06",
        "unexpected artifact name",
    )
    require(receipt.get("repository") == "cslib-fmt", "unexpected repository")
    require(
        receipt.get("status") == "T_EXT_BACK_AND_FORTH_COMPLETENESS_REGRESSION_RECEIPT_RECORDED",
        "unexpected status",
    )
    require(
        receipt.get("input_receipt")
        == "artifacts/status/zero_one_law_back_and_forth_completeness_receipt_2026_07_05.json",
        "unexpected input receipt pointer",
    )

    guard_statement = receipt.get("guard_statement", "")
    for fragment in (
        "bounded to a back-and-forth receipt",
        "finite partial isomorphisms",
        "forward extension",
        "backward extension",
        "countable models",
        "union of the chain is a total isomorphism",
        "countable categoricity implies completeness for the extension theory",
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
        "T_ext back-and-forth completeness receipt",
        "does not prove a global zero-one law",
        "Fagin theorem",
        "unrestricted finite-model-theory closure",
        "Lean-formal T_ext completeness theorem",
        "countable-theory completeness closure",
        "uniform sentence decision procedure",
    ):
        require(fragment in boundary, f"boundary missing fragment: {fragment}")

    print("T_EXT_BACK_AND_FORTH_COMPLETENESS_REGRESSION_RECEIPT_OK")


if __name__ == "__main__":
    main()
