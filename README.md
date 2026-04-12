# CSLIB FMT (Finite-Model Theory)

[![CI](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml/badge.svg)](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml)

A Lean 4 library for finite-model-theoretic locality, bounded-radius structure, EF games, FO^k syntax, local types, and invariant interfaces.

## Current status

- Build: repository compiles on the pinned Lean toolchain.
- Scope: reusable finite-model-theory infrastructure plus project-specific higher layers.
- Public maturity target: stable core, explicit status map, reusable examples, contributor path.

## Start here

1. `lake build`
2. Read `docs/onboarding/START_HERE.md`
3. Run the minimal example path

## Public API

- `FMT.Graph`
- `FMT.Logic`
- `FMT.Game`
- `FMT.Types`
- `FMT.Invariants`

## URF routing

This repository is a finite-model-theory library and formalization surface within the broader URF program.

Canonical URF definitions, theorem statements, dependency ledgers, and closure claims remain in `urf-core`.

Community-additive examples, tests, implementations, and non-canonical extensions belong in `urf-core-community`.
