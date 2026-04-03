# EV0V3 Interface

Status: isolated namespace

## Boundary
- No direct import into `FMT.Graph` yet.
- No mutation of existing graph-distance semantics.
- Integration only through explicit bridge modules.

## Planned bridge path
1. Define EV0V3 invariants locally.
2. Add explicit import boundary.
3. Introduce bridge module(s) only after invariants stabilize.
