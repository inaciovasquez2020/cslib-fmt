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

## Formal Status

Status: Clean Formal Scaffold / Needs Theorem Audit

Build status:
- A successful build means the checked root target compiles.
- It does not imply that the repository contains a final solve.

Theorem status:
- A `Prop` specification is not a proof.
- A target statement is not a proof.
- No final-solve claim is asserted at repository level.
- A final theorem claim requires an identified file name, theorem name, dependency chain, and proof status.

Current status:
- Strongest verified theorem: not asserted at repository level
- Weakest missing object: exported-theorem audit separating definitions, specifications, verified lemmas, conditional theorems, and final theorems
- Theorem-surface audit: `docs/status/THEOREM_SURFACE_AUDIT_2026_04_27.md`
