# FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE_PUBLIC_ANCHOR

STATUS := PUBLIC_BOUNDED_EXAMPLE_ANCHOR

REPOSITORY := cslib-fmt

MAIN_ANCHOR_COMMIT := bb48345

CLAIM := formula structural-recursion positive-radius edge is recorded as a bounded machine-checkable edge example.

VERIFIER_COMMAND := `python3 tools/verify_formula_structural_recursion_positive_radius_edge.py`

PYTEST_COMMAND := `python3 -m pytest -q tests/test_formula_structural_recursion_positive_radius_edge.py`

BOUNDARY :=
- no Fagin theorem claim
- no 0-1 Law claim
- no unguarded FO locality claim
- no general finite-model-theory closure claim
- no unrestricted theorem closure claim
- no Clay-level closure claim
