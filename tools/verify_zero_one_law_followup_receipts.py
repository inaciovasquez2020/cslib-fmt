#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

DOCS = [
    ROOT / "docs/status/ZERO_ONE_LAW_BACK_AND_FORTH_COMPLETENESS_RECEIPT_2026_07_05.md",
    ROOT / "docs/status/ZERO_ONE_LAW_FINITE_SUBSET_ALMOST_SURE_RECEIPT_2026_07_05.md",
    ROOT / "docs/status/ZERO_ONE_LAW_ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_2026_07_05.md",
]

ARTIFACTS = [
    ROOT / "artifacts/status/zero_one_law_back_and_forth_completeness_receipt_2026_07_05.json",
    ROOT / "artifacts/status/zero_one_law_finite_subset_almost_sure_receipt_2026_07_05.json",
    ROOT / "artifacts/status/zero_one_law_zero_ary_relation_negative_boundary_receipt_2026_07_05.json",
]

STATUS = ROOT / "STATUS.md"

REQUIRED_STATUS_LINKS = [
    "docs/status/ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECEIPT_2026_07_05.md",
    "docs/status/ZERO_ONE_LAW_BACK_AND_FORTH_COMPLETENESS_RECEIPT_2026_07_05.md",
    "docs/status/ZERO_ONE_LAW_FINITE_SUBSET_ALMOST_SURE_RECEIPT_2026_07_05.md",
    "docs/status/ZERO_ONE_LAW_ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_2026_07_05.md",
]

REQUIRED_DOC_TOKENS = {
    "ZERO_ONE_LAW_BACK_AND_FORTH_COMPLETENESS_RECEIPT_2026_07_05.md": [
        "finite partial isomorphism",
        "forward extension",
        "backward step",
        "M ≅ N",
        "T_ext proves phi or T_ext proves not phi",
        "Lean-formal T_ext completeness theorem closure",
    ],
    "ZERO_ONE_LAW_FINITE_SUBSET_ALMOST_SURE_RECEIPT_2026_07_05.md": [
        "Gamma finite subset of T_ext",
        "union bound",
        "finite sum",
        "Pr[A_n satisfies Gamma] -> 1",
        "almost-sure closure for infinite subsets of T_ext",
    ],
    "ZERO_ONE_LAW_ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_2026_07_05.md": [
        "arity(P) = 0",
        "phi = P",
        "Pr[A_n satisfies P] = 1/2",
        "1/2 not in {0,1}",
        "0-1 law for random 0-ary relation symbols",
    ],
}

REQUIRED_ARTIFACT_STATUS = {
    "zero_one_law_back_and_forth_completeness_receipt_2026_07_05": "T_EXT_COMPLETENESS_BACK_AND_FORTH_RECEIPT_RECORDED",
    "zero_one_law_finite_subset_almost_sure_receipt_2026_07_05": "FINITE_SUBSET_T_EXT_ALMOST_SURE_RECEIPT_RECORDED",
    "zero_one_law_zero_ary_relation_negative_boundary_receipt_2026_07_05": "ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_RECORDED",
}

FORBIDDEN = [
    "Lean-formal Fagin theorem closure: true",
    "global finite-model-theory closure: true",
    "0-1 law for random 0-ary relation symbols: true",
    "functions/constants closure: true",
    "dependent/nonuniform random models closure: true",
    "P-vs-NP solved",
]


def require_file(path: Path) -> str:
    if not path.exists():
        raise SystemExit(f"MISSING_OBJECT := {path.relative_to(ROOT)}")
    return path.read_text()


def main() -> None:
    status_text = require_file(STATUS)

    for link in REQUIRED_STATUS_LINKS:
        if link not in status_text:
            raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_MISSING_STATUS_LINK := {link}")

    joined = status_text

    for doc in DOCS:
        text = require_file(doc)
        joined += "\n" + text
        for token in REQUIRED_DOC_TOKENS[doc.name]:
            if token not in text:
                raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_MISSING_DOC_TOKEN := {doc.name} :: {token}")

    for artifact in ARTIFACTS:
        data = json.loads(require_file(artifact))
        joined += "\n" + json.dumps(data, sort_keys=True)

        name = data.get("artifact")
        expected = REQUIRED_ARTIFACT_STATUS.get(name)
        if expected is None:
            raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_UNKNOWN_ARTIFACT := {name}")

        if data.get("status") != expected:
            raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_BAD_STATUS := {name} :: {data.get('status')}")

        boundaries = data.get("boundaries")
        if not isinstance(boundaries, list) or not boundaries:
            raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_MISSING_BOUNDARIES := {name}")

    for token in FORBIDDEN:
        if token in joined:
            raise SystemExit(f"ZERO_ONE_LAW_FOLLOWUP_FORBIDDEN_TOKEN := {token}")

    print("ZERO_ONE_LAW_FOLLOWUP_RECEIPTS_OK")


if __name__ == "__main__":
    main()
