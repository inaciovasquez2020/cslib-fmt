#!/usr/bin/env python3
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RECEIPT = ROOT / "artifacts/status/finite_subset_union_bound_local_closure_receipt_2026_07_06.json"
INPUT_RECEIPT = ROOT / "artifacts/status/zero_one_law_finite_subset_almost_sure_receipt_2026_07_05.json"

EXPECTED_FORBIDDEN = {
    "GLOBAL_ZERO_ONE_LAW_CLOSURE",
    "FAGIN_THEOREM",
    "UNRESTRICTED_FMT_CLOSURE",
    "ZERO_ARY_RELATION_POSITIVE_CLOSURE",
    "COUNTABLE_INTERSECTION_ALMOST_SURE_CLOSURE",
    "INFINITE_GAMMA_CLOSURE",
    "DEPENDENT_PROBABILITY_MODEL_CLOSURE",
    "NONUNIFORM_PROBABILITY_MODEL_CLOSURE",
    "LEAN_FORMAL_PROBABILITY_THEOREM",
}

EXPECTED_INVARIANTS = {
    "Gamma is finite",
    "each member failure event has probability tending to 0",
    "failure of the conjunction is contained in the finite union of member failure events",
    "finite union bound applies",
    "finite sum of null-limit terms tends to 0",
}


def fail(message: str) -> None:
    raise SystemExit(f"FINITE_SUBSET_UNION_BOUND_LOCAL_CLOSURE_RECEIPT_FAIL: {message}")


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
        input_receipt.get("status") == "FINITE_SUBSET_T_EXT_ALMOST_SURE_RECEIPT_RECORDED",
        "input finite-subset almost-sure receipt status changed",
    )
    require(
        receipt.get("artifact") == "finite_subset_union_bound_local_closure_receipt_2026_07_06",
        "unexpected artifact name",
    )
    require(receipt.get("repository") == "cslib-fmt", "unexpected repository")
    require(
        receipt.get("status") == "FINITE_SUBSET_UNION_BOUND_LOCAL_CLOSURE_RECEIPT_RECORDED",
        "unexpected status",
    )
    require(
        receipt.get("input_receipt")
        == "artifacts/status/zero_one_law_finite_subset_almost_sure_receipt_2026_07_05.json",
        "unexpected input receipt pointer",
    )
    require(
        receipt.get("positive_claim") == "FINITE_SUBSET_UNION_BOUND_LOCAL_CLOSURE_ONLY",
        "positive claim is not locally bounded",
    )

    local_statement = receipt.get("local_statement", "")
    for fragment in (
        "fixed finite Gamma subset of T_ext",
        "null-limit failure probability",
        "finite sum",
        "tends to 0",
    ):
        require(fragment in local_statement, f"local statement missing fragment: {fragment}")

    require(
        set(receipt.get("checked_invariant", [])) == EXPECTED_INVARIANTS,
        "checked invariant set changed",
    )
    require(
        set(receipt.get("forbidden_claims", [])) == EXPECTED_FORBIDDEN,
        "forbidden claim set changed",
    )

    positive_surface = json.dumps(
        {
            "status": receipt.get("status"),
            "scope": receipt.get("scope"),
            "local_statement": receipt.get("local_statement"),
            "checked_invariant": receipt.get("checked_invariant"),
            "positive_claim": receipt.get("positive_claim"),
        },
        sort_keys=True,
    )
    for forbidden in EXPECTED_FORBIDDEN:
        require(
            forbidden not in positive_surface,
            f"forbidden claim appears in positive surface: {forbidden}",
        )

    boundary = receipt.get("boundary", "")
    for fragment in (
        "only the finite local union-bound step",
        "does not prove a global zero-one law",
        "Fagin theorem",
        "unrestricted finite-model-theory closure",
        "positive closure for 0-ary relation vocabularies",
    ):
        require(fragment in boundary, f"boundary missing fragment: {fragment}")

    print("FINITE_SUBSET_UNION_BOUND_LOCAL_CLOSURE_RECEIPT_OK")


if __name__ == "__main__":
    main()
