# Public cslib-fmt release readiness — 2026-06-02

Status: `PUBLIC_CSLIB_FMT_RELEASE_PREPARED`

Prepared object: `PreparePublicCslibFmtRelease`

Repository: `cslib-fmt`

Release scope: finite graph diameter public convenience surface.

## Included closed objects

- `finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable`
- `finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable`
- `finiteGraphDiameter_none_of_not_allPairDistancesReachable'`
- `finiteGraphDiameter_some_iff_allPairDistancesReachable`
- `finiteGraphDiameter_closed_option_nat_cases`

## Boundary

- finite graph diameter Option Nat layer only
- finite graphs only
- unweighted graph distance surface only
- no infinite graph claim
- no weighted graph claim
- no full graph theory completion claim
- no cross-repository theorem claim

## Verification

- `python3 tools/verify_public_cslib_fmt_release_readiness.py`
- `python3 -m pytest -q tests/test_public_cslib_fmt_release_readiness.py`
- `python3 tools/verify_finite_graph_diameter_final_convenience_layer.py`
- `python3 -m pytest -q tests/test_finite_graph_diameter_final_convenience_layer.py`
- `lake build FMT.Graph.FiniteGraphDiameter`
- `lake build`
- `git diff --check`

## Next admissible object

`CreatePublicCslibFmtReleaseOrArchiveReleaseCandidate`
