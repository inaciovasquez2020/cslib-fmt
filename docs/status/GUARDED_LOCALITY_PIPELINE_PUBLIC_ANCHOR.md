# GUARDED_LOCALITY_PIPELINE_PUBLIC_ANCHOR

STATUS := PUBLIC_BOUNDED_EXAMPLE_ANCHOR

REPOSITORY := cslib-fmt

MAIN_ANCHOR_COMMIT := cc686b2

CLAIM := guarded locality pipeline is recorded as a bounded machine-checkable locality-pipeline example.

VERIFIER_COMMAND := `python3 tools/verify_guarded_locality_pipeline.py`

PYTEST_COMMAND := `python3 -m pytest -q tests/test_guarded_locality_pipeline.py`

BOUNDARY :=
- no Fagin theorem claim
- no 0-1 Law claim
- no unguarded FO locality claim
- no general finite-model-theory closure claim
- no unrestricted theorem closure claim
- no Clay-level closure claim
