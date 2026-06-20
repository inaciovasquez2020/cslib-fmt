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

## External status

This repository is governed by [`docs/status/EXTERNAL_STATUS_LOCK.md`](docs/status/EXTERNAL_STATUS_LOCK.md). Build success, CI success, dashboards, ledgers, axioms, admits, `sorry`, or placeholder witnesses do not constitute theorem-level closure.


## Lean proof portfolio classification

This repository is governed by [`docs/status/LEAN_PROOF_PORTFOLIO_CLASSIFICATION.md`](docs/status/LEAN_PROOF_PORTFOLIO_CLASSIFICATION.md). Its role in the portfolio is explicitly classified as proof-facing, conditional frontier, infrastructure/documentation, or legacy/scaffold.
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


## Closure status

Status: Distance/Factorization Surface Closed; General FMT Frontier Open.

* Distance-core surface: closed constructively in live `FMT.Graph` code.
* Factorization surface: closed by `useLocalFactorization` bridge witness.
* General FMT frontier: open; no Fagin theorem, 0-1 Law, or global finite-model-theory final theorem is claimed.
* Audit lock: `docs/status/CSLIB_FMT_DISTANCE_FACTORIZATION_SURFACE_STATUS_2026_06_13.md`

## General FMT frontier boundary

No Fagin theorem, 0-1 Law, global finite-model-theory final theorem, broad CSLIB adoption, direct Mathlib adoption, or Vardi endorsement/collaboration/coauthorship claim is asserted.

## Current stopping point: smaller-radius locality surface weakening

Status: `SMALLER_RADIUS_LOCALITY_SURFACE_WEAKENING`

Current pushed stopping point:

- `8866e78` — `theorem: add smaller-radius locality surface weakening`
- touched Lean source: `lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean`

Boundary: this is a smaller-radius locality surface weakening. It supersedes the prior README stopping pointer to `cbefa8d` as the current pushed head. It does not by itself prove radius monotonicity under the blocked assignment-close direction unless the corresponding theorem/checker explicitly records that closure.

Next bounded choice: lock the smaller-radius locality weakening status if not already locked, then decide whether the Boolean/quantifier recursion gate is admissible from that weakened locality input.
