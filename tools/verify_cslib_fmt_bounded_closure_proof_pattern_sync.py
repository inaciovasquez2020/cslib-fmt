#!/usr/bin/env python3
from pathlib import Path
import json


ARTIFACT = Path("artifacts/status/cslib_fmt_bounded_closure_proof_pattern_sync_2026_06_13.json")
DOC = Path("docs/status/CSLIB_FMT_BOUNDED_CLOSURE_PROOF_PATTERN_SYNC_2026_06_13.md")
PIPELINE_ARTIFACT = Path("artifacts/fmt/guarded_locality_pipeline_2026_06_13.json")
PIPELINE_DOC = Path("docs/status/CSLIB_FMT_GUARDED_LOCALITY_PIPELINE_2026_06_13.md")
PIPELINE_VERIFIER = Path("tools/verify_guarded_locality_pipeline.py")
PIPELINE_TEST = Path("tests/test_guarded_locality_pipeline.py")

REQUIRED_STATUS_CLASSES = {
    "PROVED_BOUNDED_PIPELINE",
    "INPUT_SURFACE",
    "EXPLICIT_NON_CLAIM_BOUNDARY",
    "OPEN_GLOBAL_FRONTIER",
}

REQUIRED_PATTERN_COMPONENTS = {
    "bounded_pipeline_claim",
    "input_surface",
    "bounded_theorem_objects",
    "verifier_or_certificate",
    "status_classification",
    "explicit_boundary",
}

REQUIRED_NON_CLAIMS = {
    "NO_FULL_GAIFMAN_LOCALITY",
    "NO_UNGUARDED_FO_LOCALITY",
    "NO_FAGIN_THEOREM",
    "NO_ZERO_ONE_LAW",
    "NO_GLOBAL_FMT_FINAL_THEOREM",
    "NO_THEOREM_PROMOTION",
}

REQUIRED_LOCAL_ARTIFACTS = {
    str(PIPELINE_DOC),
    str(PIPELINE_ARTIFACT),
    str(PIPELINE_VERIFIER),
    str(PIPELINE_TEST),
}


def read_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def verify() -> None:
    for path in [ARTIFACT, DOC, PIPELINE_ARTIFACT, PIPELINE_DOC, PIPELINE_VERIFIER, PIPELINE_TEST]:
        if not path.exists():
            raise SystemExit(f"missing {path}")

    artifact = read_json(ARTIFACT)
    doc = DOC.read_text(encoding="utf-8")
    pipeline = read_json(PIPELINE_ARTIFACT)

    assert artifact["id"] == "CSLIB_FMT_BOUNDED_CLOSURE_PROOF_PATTERN_SYNC_2026_06_13"
    assert artifact["repository"] == "cslib-fmt"
    assert artifact["status"] == "BOUNDED_CLOSURE_PROOF_PATTERN_SYNC_ADDED"
    assert artifact["closed_object"] == "CSLIB_FMT_BOUNDED_CLOSURE_PROOF_PATTERN_SYNC"
    assert artifact["object_type"] == "bounded_status_pattern_sync"
    assert artifact["source_pattern_repository"] == "urf-textbook"
    assert artifact["source_pattern_commit"] == "8def1fc"
    assert artifact["classifier_reference_repository"] == "theorem-closure-classifier"
    assert artifact["classifier_reference_commit"] == "d9b6677"
    assert artifact["depends_on"] == ["CSLIB_FMT_GUARDED_LOCALITY_PIPELINE"]
    assert set(artifact["local_artifacts"]) == REQUIRED_LOCAL_ARTIFACTS
    assert set(artifact["status_classes_used"]) == REQUIRED_STATUS_CLASSES
    assert set(artifact["required_pattern_components"]) == REQUIRED_PATTERN_COMPONENTS
    assert set(artifact["non_claims"]) == REQUIRED_NON_CLAIMS
    assert artifact["next_admissible_object"] == "StopOrAddPatternAdoptionForAnotherBoundedPipeline"

    assert pipeline["object"] == "CSLIB_FMT_GUARDED_LOCALITY_PIPELINE"
    assert pipeline["status"] == "BOUNDED_GUARDED_LOCALITY_CLOSURE"
    assert "RestrictedEFGameLocalTypeInvariantInputSurface" in pipeline["declarations"]
    assert "full Gaifman locality" in pipeline["non_claims"]
    assert "Fagin theorem" in pipeline["non_claims"]
    assert "0-1 law" in pipeline["non_claims"]

    assert "does not prove full Gaifman locality" in doc
    assert "does not prove unguarded first-order locality" in doc
    assert "does not prove Fagin's Theorem" in doc
    assert "does not prove the 0-1 Law" in doc
    assert "does not prove a global finite-model-theory final theorem" in doc
    assert "does not promote any bounded status artifact" in doc


if __name__ == "__main__":
    verify()
    print("CSLIB_FMT_BOUNDED_CLOSURE_PROOF_PATTERN_SYNC_OK")
