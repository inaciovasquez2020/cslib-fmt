# FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES_PUBLIC_ANCHOR

STATUS := PUBLIC_BOUNDED_EXAMPLE_ANCHOR

REPOSITORY := cslib-fmt

MAIN_ANCHOR_COMMIT := 0b48a90

CLAIM := full formula-radius historical boundary supersession notes are recorded as a bounded machine-checkable supersession-notes example.

VERIFIER_COMMAND := `python3 tools/verify_full_formula_radius_historical_boundary_supersession_notes.py`

PYTEST_COMMAND := `python3 -m pytest -q tests/test_full_formula_radius_historical_boundary_supersession_notes.py`

FULL_PYTEST_COMMAND := `python3 -m pytest -q`

BOUNDARY :=
- supersession notes only
- no formula-radius theorem strengthening claim
- no Fagin theorem claim
- no 0-1 Law claim
- no unguarded FO locality claim
- no general finite-model-theory closure claim
- no unrestricted theorem closure claim
