# Restart Artifact

## Repository
cslib-fmt

## Branch
feat/cslib-fmt

## Current stable stop-state
- Distance layer build-green
- EV0V3 boundary integrity complete
- Working stop-point intended for 3–6 week re-entry

## Anchor commits
- Distance frontier cleanup tag base: db4abf5
- Post-frontier clean micro-fix: 902ceb3
- EV0V3 boundary integrity completion: 1beef12

## Anchor tags
- fmt-distance-frontier-db4abf5-clean
- fmt-distance-frontier-902ceb3
- EV0V3-initial-pass
- EV0V3-boundary-tested
- EV0V3-boundary-integrity-complete

## Verified artifacts
### Distance layer
- FMT/Graph/ExistsMinPathLength.lean
- FMT/Graph/PathLengthReverse.lean
- FMT/Graph/PathLengthConcat.lean
- FMT/Graph/DistanceSymmetry.lean
- FMT/Graph/FrontierSnapshot.txt
- FMT/Graph/FINAL_FRONTIER_REPORT.txt

### EV0V3
- EV0V3/README.txt
- EV0V3/INTERFACE.md
- EV0V3/break_destroy_test.sh
- EV0V3/invariants_test.sh
- EV0V3/import_boundary_test.sh

## Restart protocol
1. git checkout feat/cslib-fmt
2. git pull --ff-only
3. git checkout EV0V3-boundary-integrity-complete
4. git checkout feat/cslib-fmt
5. lake build
6. ./EV0V3/break_destroy_test.sh
7. ./EV0V3/invariants_test.sh
8. ./EV0V3/import_boundary_test.sh

## Immediate next frontier after return
1. Decide whether EV0V3 remains isolated or gets a first bridge module.
2. If isolated, add one more internal invariant file and one negative-coupling test.
3. If integrating, create explicit bridge module only; do not mutate FMT.Graph directly.
4. Re-scan repo with:
   grep -R -n "axiom\|sorry\|admit" FMT EV0V3 || true

## Success condition on re-entry
- lake build green
- EV0V3 three tests green
- no unexpected namespace coupling
- no semantic regression in distance layer
