# Shortest Path Length Closure Plan

## Final live frontier
- `FMT/Graph/DistanceCore.lean:7: axiom shortest_path_length`

## Required final lemma
For every graph `G` and vertices `u v`, if there exists a path length from `u` to `v`, then there exists a minimal such length:
- `∃ n, Nonempty (PathLength G u v n)`
- implies `∃ d, Nonempty (PathLength G u v d) ∧ ∀ m, m < d → ¬ Nonempty (PathLength G u v m)`

## Reason
Proving this lemma constructively removes the final live frontier axiom without reintroducing any `sorry` into `FMT/`.
