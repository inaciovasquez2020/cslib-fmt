# Shortest Path Frontier

## Independent live frontier
- `FMT/Graph/DistanceCore.lean:7: axiom shortest_path_length`

## Audit
- No other live `axiom`, `sorry`, or `admit` in `FMT/` excluding audit/status files.

## Build
- `lake build` passes.

## Status
- Distance layer is reduced to the single frontier assumption `shortest_path_length`.
