# Shortest Path Length Closure Plan

## Final live frontier
- RESOLVED: former `FMT/Graph/DistanceCore.lean:7: axiom shortest_path_length` removed from live code

## Required final lemma
For every graph `G` and vertices `u v`, if there exists a path length from `u` to `v`, then there exists a minimal such length:
- `∃ n, Nonempty (PathLength G u v n)`
- implies `∃ d, Nonempty (PathLength G u v d) ∧ ∀ m, m < d → ¬ Nonempty (PathLength G u v m)`

## Reason
Resolved in live code. This file is retained as archival history only.
