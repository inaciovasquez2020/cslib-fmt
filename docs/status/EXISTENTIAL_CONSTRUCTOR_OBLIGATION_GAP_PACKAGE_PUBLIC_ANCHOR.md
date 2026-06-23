# EXISTENTIAL_CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_PUBLIC_ANCHOR

STATUS := PUBLIC_BOUNDED_EXAMPLE_ANCHOR

REPOSITORY := cslib-fmt

MAIN_ANCHOR_COMMIT := ddd1947

CLAIM := existential constructor obligation gap package is recorded as a bounded machine-checkable gap-package example.

VERIFIER_COMMAND := `python3 tools/verify_existential_constructor_obligation_gap_package_status.py`

PYTEST_COMMAND := `python3 -m pytest -q tests/test_existential_constructor_obligation_gap_package_status.py`

BOUNDARY :=
- no existential constructor proof claim
- no existential body witness locality transport proof claim
- no quantified radius witness constructor proof claim
- no Fagin theorem claim
- no 0-1 Law claim
- no general finite-model-theory closure claim
- no unrestricted theorem closure claim
