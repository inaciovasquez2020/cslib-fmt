# EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT_PUBLIC_ANCHOR

STATUS := PUBLIC_BOUNDED_EXAMPLE_ANCHOR

REPOSITORY := cslib-fmt

MAIN_ANCHOR_COMMIT := 9b4133c

CLAIM := existential ex-body to quantified-radius witness constructor stopping point is recorded as a bounded machine-checkable stopping-point example.

VERIFIER_COMMAND := `python3 tools/verify_existential_ex_body_to_quantified_radius_witness_constructor_stopping_point.py`

PYTEST_COMMAND := `python3 -m pytest -q tests/test_existential_ex_body_to_quantified_radius_witness_constructor_stopping_point.py`

BOUNDARY :=
- no existential ex-body to quantified-radius witness constructor proof claim
- no existential constructor proof claim
- no quantified radius witness constructor discharge claim
- no Fagin theorem claim
- no 0-1 Law claim
- no general finite-model-theory closure claim
- no unrestricted theorem closure claim
