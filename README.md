# CSLIB FMT (Finite-Model Theory)

[![CI](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml/badge.svg)](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml)

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

## Graph distance semantics

Canonical graph distance is now path-based and exposed through `FMT.Graph`.

Primary public objects:
- `FMT.Graph.PathLength`
- `FMT.Graph.Reachable`
- `FMT.Graph.dist?`
- `FMT.Graph.DistLE`
- `FMT.Graph.DistGT`

Canonical semantics:
- `dist? G u v = none` means no finite path witness exists
- `dist? G u v = some d` means there is a path of length `d`
- `dist? G u v = some 0` iff `u = v`

Compatibility status:
- `FMT.Graph.dist` remains only as a legacy compatibility wrapper
- new modules should use `dist?`, `DistLE`, and `DistGT`

