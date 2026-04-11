# CSLIB FMT (Finite-Model Theory)


<!-- PUBLIC-SURFACE:BEGIN -->
## Start Here
- [`QUICKSTART.md`](QUICKSTART.md)
- [`docs/public/START_HERE.md`](docs/public/START_HERE.md)

## Proof Status
- [`docs/public/PROOF_STATUS.md`](docs/public/PROOF_STATUS.md)

## Independent Verification
- [`docs/public/INDEPENDENT_VERIFICATION.md`](docs/public/INDEPENDENT_VERIFICATION.md)

## Why It Matters
- [`docs/public/WHY_IT_MATTERS.md`](docs/public/WHY_IT_MATTERS.md)

## Citation
- [`CITATION.cff`](CITATION.cff)
<!-- PUBLIC-SURFACE:END -->

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
