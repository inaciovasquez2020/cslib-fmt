# Final Remaining Gap

## Unprovable unconditional frontier
- RESOLVED: no remaining live distance-core gap in compiled code

## Weakest sufficient replacement
For every graph `G` and vertices `u v`, assume path existence:
- `∃ n, Nonempty (PathLength G u v n)`

Then conclude minimality:
- `∃ d, Nonempty (PathLength G u v d) ∧ ∀ m, m < d → ¬ Nonempty (PathLength G u v m)`

## Precise obstruction
Without the path-existence hypothesis, the unconditional statement is not derivable from `PathLength` alone.

## Current live frontier
- replace unconditional `shortest_path_length`
- by conditional minimal-length existence under explicit path existence
