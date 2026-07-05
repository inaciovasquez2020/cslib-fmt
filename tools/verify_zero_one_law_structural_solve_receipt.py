#!/usr/bin/env python3
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ARTIFACT = ROOT / "artifacts/status/zero_one_law_structural_solve_receipt_2026_07_05.json"
DOC = ROOT / "docs/status/ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECEIPT_2026_07_05.md"

REQUIRED_JSON = {
    "artifact": "zero_one_law_structural_solve_receipt_2026_07_05",
    "repository": "cslib-fmt",
    "status": "CLASSICAL_ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECORDED",
}

REQUIRED_BOUNDARIES = [
    "no Lean-formal Fagin theorem closure claim",
    "no repository-level global finite-model-theory closure claim",
    "no 0-1 law claim for 0-ary relation symbols",
    "no 0-1 law claim for vocabularies with functions or constants",
    "no 0-1 law claim for dependent or nonuniform random models",
    "no Clay-level or P-vs-NP claim",
]

REQUIRED_TEXT = [
    "finite relational vocabulary L",
    "positive arity for every relation symbol",
    "independent Bernoulli(1/2)",
    "2^(sum_R n^(arity(R)))",
    "total probability `1`",
    "Pr[A_n does not satisfy EA_tau] <= n^m * (1 - p_tau)^(n-m)",
    "finite subset of `T_ext`",
    "countable back-and-forth",
    "lim_n Pr[A_n satisfies phi] ∈ {0,1}",
    "0-1 law for 0-ary relation symbols",
    "0-1 law for vocabularies with functions or constants",
    "0-1 law for dependent or nonuniform random models",
]

FORBIDDEN_TEXT = [
    "Lean-formal Fagin theorem closure claim: true",
    "repository-level global finite-model-theory closure claim: true",
    "0-1 law for 0-ary relation symbols: true",
    "0-1 law for vocabularies with functions or constants: true",
    "dependent or nonuniform random models: true",
    "P-vs-NP solved",
]


def main() -> None:
    if not ARTIFACT.exists():
        raise SystemExit(f"MISSING_OBJECT := {ARTIFACT}")
    if not DOC.exists():
        raise SystemExit(f"MISSING_OBJECT := {DOC}")

    data = json.loads(ARTIFACT.read_text())
    doc_text = DOC.read_text()

    for key, expected in REQUIRED_JSON.items():
        actual = data.get(key)
        if actual != expected:
            raise SystemExit(f"ZERO_ONE_LAW_RECEIPT_BAD_{key.upper()} := {actual!r}")

    boundaries = data.get("boundaries")
    if not isinstance(boundaries, list):
        raise SystemExit("ZERO_ONE_LAW_RECEIPT_BOUNDARIES_NOT_LIST")

    for boundary in REQUIRED_BOUNDARIES:
        if boundary not in boundaries:
            raise SystemExit(f"ZERO_ONE_LAW_RECEIPT_MISSING_BOUNDARY := {boundary}")

    for token in REQUIRED_TEXT:
        if token not in doc_text:
            raise SystemExit(f"ZERO_ONE_LAW_RECEIPT_MISSING_TEXT := {token}")

    joined = json.dumps(data, sort_keys=True) + "\n" + doc_text
    for token in FORBIDDEN_TEXT:
        if token in joined:
            raise SystemExit(f"ZERO_ONE_LAW_RECEIPT_FORBIDDEN_TEXT := {token}")

    print("ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECEIPT_OK")


if __name__ == "__main__":
    main()
