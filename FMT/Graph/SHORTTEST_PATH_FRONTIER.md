# Shortest Path Frontier

## Independent live frontier
- RESOLVED: former `FMT/Graph/DistanceCore.lean:7: axiom shortest_path_length` removed from live code

## Audit
- No live `axiom`, `sorry`, or `admit` remain in compiled `FMT/` code; archival text may still reference prior frontiers.

## Build
- `lake build` passes.

## Status
- Distance layer no longer depends on a live frontier assumption in compiled code.
