# CSLIB FMT (Finite-Model Theory)

This repository implements a CSLIB-aligned finite-model theory library, following the suggestion of Moshe Vardi to build reusable infrastructure for locality, EF games, and invariants.

## Scope
- FO^k locality and bounded-radius logic
- Ehrenfeucht–Fraïssé games (finite and local)
- Local type systems and factorization interfaces
- Global invariants (cycle space, cohomology)
- Explicit separation constructions (high-girth lifts)

## CSLIB Alignment
- Modular interfaces (Graph, Types, Invariants)
- Reusable primitives for locality analysis
- Executable Lean formalization
- Minimal, composable API layer

## Reference
- Libkin, *Elements of Finite Model Theory*:
  https://homepages.inf.ed.ac.uk/libkin/fmt/fmt.pdf

## Status

Current closure checkpoint: `cslib-fmt-closure-2026-04-01`

- Branch: `feat/cslib-fmt`
- Head: `0956fee`
- Build status: green (`lake build`)
- Release checkpoint: `cslib-fmt-closure-2026-04-01`

This repository is currently at a build-green closure checkpoint for the present formalization. The checkpoint records the semantic replacements and cleanup reflected in the current `feat/cslib-fmt` branch state. The release is intended as a repository checkpoint and should be read exactly at the level supported by the code and release notes.

