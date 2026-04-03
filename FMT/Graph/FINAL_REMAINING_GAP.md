# Final Remaining Gap

## Only live mathematical frontier
- `FMT/Graph/DistanceCore.lean:7: axiom shortest_path_length`

## Missing lemma
For every graph `G` and vertices `u v`, if there exists a path length from `u` to `v`, then there exists a minimal such length:
- `∃ n, Nonempty (PathLength G u v n)`
- implies `∃ d, Nonempty (PathLength G u v d) ∧ ∀ m, m < d → ¬ Nonempty (PathLength G u v m)`

## Audit condition
No other live `axiom`, `sorry`, or `admit` in `FMT/` excluding audit/status markdown or txt artifacts.
