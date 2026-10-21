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

## Recent proof-bearing work — October 2026

Recent merged additions and their boundaries are recorded in [Recent Proof Work Review](docs/status/RECENT_PROOF_WORK_REVIEW_2026_10_21.md).

- [PR #191](https://github.com/inaciovasquez2020/cslib-fmt/pull/191): pointed-neighborhood equivalence and formula-preservation interfaces.
- [PR #192](https://github.com/inaciovasquez2020/cslib-fmt/pull/192): reflexive local pointed back-and-forth witness.
- [PR #193](https://github.com/inaciovasquez2020/cslib-fmt/pull/193): proof-bearing natural-number left-cancellation lemma.

These are bounded formal results. They do not prove Gaifman locality, Fagin's theorem, the 0-1 Law, or global finite-model-theory closure. The July 5 exported theorem-surface receipt predates PR #193 and must not be used as the current complete declaration count.

## Current locality frontier

The current locality surface includes pointed-neighborhood equivalence and a reflexive local pointed back-and-forth witness. The remaining mathematical gap is a nontrivial local back-and-forth witness between distinct assignments that does not depend on a global automorphism.

Boundary: the smaller-radius locality surface weakening at `8866e78` remains a bounded input result; it does not by itself prove radius monotonicity under the blocked assignment-close direction. No standard Gaifman-locality theorem is claimed.

## Unguarded FO downstream certificate library

This repository includes a small downstream Lean certificate surface for the
unguarded FO locality-radius work.

Import entry point:

```lean
import CSLIB.FMT.UnguardedFO.DownstreamLibrary
```

Current downstream wrappers:

- `downstream_library_radius_zero_locality_input`
- `downstream_library_full_formula_radius_status`

Boundary: this library surface does not claim standard Gaifman locality,
Fagin's theorem, the 0-1 Law, Pk1 route closure, or 2vK route closure.
