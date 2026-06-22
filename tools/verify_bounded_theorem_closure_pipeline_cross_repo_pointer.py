#!/usr/bin/env python3
from pathlib import Path

doc_path = Path("docs/status/BOUNDED_THEOREM_CLOSURE_PIPELINE_CROSS_REPO_POINTER.md")

if not doc_path.exists():
    raise SystemExit("MISSING_OBJECT := BOUNDED_THEOREM_CLOSURE_PIPELINE_CROSS_REPO_POINTER doc")

doc = doc_path.read_text()

required_needles = [
    "STATUS := CROSS_REPO_POINTER_ONLY",
    "UPSTREAM_CERTIFICATE_REPOSITORY := theorem-closure-classifier",
    "UPSTREAM_CERTIFICATE_OBJECT := BOUNDED_THEOREM_CLOSURE_PIPELINE_CERTIFICATE",
    "UPSTREAM_CERTIFICATE_COMMIT := cb4688f",
    "UPSTREAM_CERTIFICATE_DOC := docs/status/BOUNDED_THEOREM_CLOSURE_PIPELINE_CERTIFICATE.md",
    "UPSTREAM_CERTIFICATE_ARTIFACT := artifacts/external_validation/bounded_theorem_closure_pipeline_certificate_2026_06_22.json",
    "LOCAL_DOWNSTREAM_EXAMPLE := cslib-fmt distance/factorization surface",
    "CLAIM := cslib-fmt provides a concrete downstream bounded theorem-surface example referenced by the bounded theorem-closure audit pipeline certificate.",
    "no unrestricted theorem closure claim",
    "no new benchmark theorem proof claim",
    "no global finite-model-theory closure claim",
    "no Fagin theorem claim",
    "no 0-1 Law claim",
    "no Clay-level closure claim",
]

for needle in required_needles:
    if needle not in doc:
        raise SystemExit(f"MISSING_OBJECT := cross-repo pointer contains {needle!r}")

for forbidden in [
    "CLAIM := unrestricted theorem closure achieved",
    "CLAIM := new benchmark theorem proved",
    "CLAIM := global finite-model-theory closure achieved",
    "CLAIM := Fagin theorem proved",
    "CLAIM := 0-1 Law proved",
    "CLAIM := Clay-level closure achieved",
]:
    if forbidden in doc:
        raise SystemExit(f"BOUNDARY := forbidden strengthened claim {forbidden!r}")

print("BOUNDED_THEOREM_CLOSURE_PIPELINE_CROSS_REPO_POINTER_OK")
