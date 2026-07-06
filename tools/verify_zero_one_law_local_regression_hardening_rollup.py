#!/usr/bin/env python3
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ROLLUP = ROOT / "artifacts/status/zero_one_law_local_regression_hardening_rollup_2026_07_06.json"
WORKFLOW = ROOT / ".github/workflows/external-status-lock.yml"

EXPECTED_ROLLUP_STATUS = "ZERO_ONE_LAW_LOCAL_REGRESSION_HARDENING_ROLLUP_RECORDED"

EXPECTED_RECEIPTS = {
    186: {
        "title": "docs: add finite subset union bound local closure receipt",
        "receipt": "artifacts/status/finite_subset_union_bound_local_closure_receipt_2026_07_06.json",
        "verifier": "tools/verify_finite_subset_union_bound_local_closure_receipt.py",
        "status": "FINITE_SUBSET_UNION_BOUND_LOCAL_CLOSURE_RECEIPT_RECORDED",
    },
    187: {
        "title": "docs: add zero-ary relation negative boundary regression receipt",
        "receipt": "artifacts/status/zero_ary_relation_negative_boundary_regression_receipt_2026_07_06.json",
        "verifier": "tools/verify_zero_ary_relation_negative_boundary_regression_receipt.py",
        "status": "ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_REGRESSION_RECEIPT_RECORDED",
    },
    188: {
        "title": "docs: add T_ext back-and-forth completeness regression receipt",
        "receipt": "artifacts/status/t_ext_back_and_forth_completeness_regression_receipt_2026_07_06.json",
        "verifier": "tools/verify_t_ext_back_and_forth_completeness_regression_receipt.py",
        "status": "T_EXT_BACK_AND_FORTH_COMPLETENESS_REGRESSION_RECEIPT_RECORDED",
    },
}

EXPECTED_GAINS = {
    "finite-subset union-bound local closure is verifier-locked",
    "random 0-ary relation negative boundary is regression-guarded",
    "T_ext back-and-forth completeness receipt is regression-guarded",
    "each verifier is wired into external-status-lock",
}

EXPECTED_BOUNDARIES = {
    "no global zero-one law closure",
    "no Fagin theorem",
    "no unrestricted finite-model-theory closure",
    "no 0-ary relation positive closure",
    "no random 0-ary relation zero-one law",
    "no Lean-formal T_ext completeness theorem",
    "no countable-theory completeness closure",
    "no uniform sentence decision procedure",
}

FORBIDDEN_POSITIVE = {
    "GLOBAL_ZERO_ONE_LAW_CLOSURE",
    "FAGIN_THEOREM",
    "UNRESTRICTED_FMT_CLOSURE",
    "ZERO_ARY_RELATION_POSITIVE_CLOSURE",
    "RANDOM_ZERO_ARY_RELATION_ZERO_ONE_LAW",
    "LEAN_FORMAL_T_EXT_COMPLETENESS_THEOREM",
    "COUNTABLE_THEORY_COMPLETENESS_CLOSURE",
    "UNIFORM_SENTENCE_DECISION_PROCEDURE",
}


def fail(message: str) -> None:
    raise SystemExit(f"ZERO_ONE_LAW_LOCAL_REGRESSION_HARDENING_ROLLUP_FAIL: {message}")


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
    rollup = load_json(ROLLUP)
    workflow_text = WORKFLOW.read_text() if WORKFLOW.exists() else ""

    require(
        rollup.get("artifact") == "zero_one_law_local_regression_hardening_rollup_2026_07_06",
        "unexpected artifact",
    )
    require(rollup.get("repository") == "cslib-fmt", "unexpected repository")
    require(rollup.get("status") == EXPECTED_ROLLUP_STATUS, "unexpected rollup status")

    prs = rollup.get("merged_prs")
    require(isinstance(prs, list), "merged_prs is not a list")
    require({entry.get("pr") for entry in prs} == set(EXPECTED_RECEIPTS), "unexpected PR set")

    for entry in prs:
        pr = entry.get("pr")
        expected = EXPECTED_RECEIPTS[pr]
        for key, value in expected.items():
            require(entry.get(key) == value, f"PR {pr} has unexpected {key}")

        receipt_path = ROOT / expected["receipt"]
        verifier_path = ROOT / expected["verifier"]
        receipt = load_json(receipt_path)

        require(receipt.get("status") == expected["status"], f"PR {pr} receipt status changed")
        require(verifier_path.exists(), f"missing verifier for PR {pr}")
        require(expected["verifier"] in workflow_text, f"workflow missing verifier for PR {pr}")

    require(set(rollup.get("chain_gain", [])) == EXPECTED_GAINS, "chain_gain set changed")
    require(set(rollup.get("preserved_boundaries", [])) == EXPECTED_BOUNDARIES, "preserved_boundaries set changed")

    positive_surface = json.dumps(
        {
            "status": rollup.get("status"),
            "scope": rollup.get("scope"),
            "merged_prs": rollup.get("merged_prs"),
            "chain_gain": rollup.get("chain_gain"),
        },
        sort_keys=True,
    )
    for forbidden in FORBIDDEN_POSITIVE:
        require(forbidden not in positive_surface, f"forbidden positive claim appears in positive surface: {forbidden}")

    boundary = rollup.get("boundary", "")
    for fragment in (
        "only local regression hardening",
        "does not prove a global zero-one law",
        "Fagin theorem",
        "unrestricted finite-model-theory closure",
        "0-ary relation positive closure",
        "Lean-formal T_ext completeness theorem",
        "uniform sentence decision procedure",
    ):
        require(fragment in boundary, f"boundary missing fragment: {fragment}")

    print("ZERO_ONE_LAW_LOCAL_REGRESSION_HARDENING_ROLLUP_OK")


if __name__ == "__main__":
    main()
