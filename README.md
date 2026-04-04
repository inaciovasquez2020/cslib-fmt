# CSLIB FMT (Finite-Model Theory)

[![CI](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml/badge.svg)](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml)

A Lean 4 library for finite-model-theoretic locality, bounded-radius structure, EF games, FO^k syntax, local types, and invariant interfaces.


# CSLIB FMT (Finite-Model Theory)

[![CI](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml/badge.svg)](https://github.com/inaciovasquez2020/cslib-fmt/actions/workflows/verify.yml)

A Lean 4 library for finite-model-theoretic locality, bounded-radius structure, EF games, FO^k syntax, local types, and invariant interfaces.

## Current status

* Build: repository compiles on the pinned Lean toolchain.
* Scope: reusable finite-model-theory infrastructure plus project-specific higher layers.
* Public maturity target: stable core, explicit status map, reusable examples, contributor path.

## Start here

## Public API

- `FMT.Graph`
- `FMT.Logic`
- `FMT.Game`
- `FMT.Types`
- `FMT.Invariants`


1. `lake build`
2. Read `docs/onboarding/START_HERE.md`
3. Run the minimal example path:

   * `FMT.Graph.PathLength`
   * `FMT.Graph.Distance`
   * `FMT.Logic.FOkSyntax`
   * `FMT.Game.EF`
4. Open `docs/status/STATUS.md` for Closed / Conditional / Open theorem status.
5. Open `docs/onboarding/ARCHITECTURE.md` for module layout.

## Reusable library surface

* Graph/path/distance infrastructure
* Bounded-radius / rooted-ball infrastructure
* FO^k syntax and locality scaffolding
* EF-game scaffolding
* Local type / factorization interfaces
* Cycle-space and obstruction interfaces

## Repository map

* `FMT/Graph` — graph, paths, distance, bounded-radius infrastructure
* `FMT/Logic` — FO^k syntax and locality-facing logic layer
* `FMT/Game` — EF-game infrastructure
* `FMT/Types` — local types, factorization, WL-facing interfaces
* `FMT/Invariants` — cycle-space and global obstruction layer
* `FMT/Examples` — explicit examples and separation templates
* `docs/` — public architecture, roadmap, notes, theorem status

## External validation surface

* See `docs/status/ROADMAP.md`
* See `docs/status/STATUS.md`
* See `.github/ISSUE_TEMPLATE/`
  EOF

cd ~/github-audit/cslib-fmt && cat > docs/onboarding/START_HERE.md <<'EOF'

# Start Here

## Minimal build

```zsh
lake build
```

## Canonical entry chain

1. `FMT.Graph.PathLength`
2. `FMT.Graph.Distance`
3. `FMT.Graph.BoundedRadius`
4. `FMT.Logic.FOkSyntax`
5. `FMT.Logic.LocalityRadius`
6. `FMT.Game.EF`
7. `FMT.Types.LocalType`
8. `FMT.Invariants.CycleSpace`

## Minimal theorem chain

### Stage 1: Paths

* Construct finite paths.
* Reverse and concatenate paths.
* Extract existence consequences.

### Stage 2: Distance

* Define `dist?`.
* Relate paths to distance upper bounds.
* Establish theorem-level symmetry and triangle inequality.

### Stage 3: Radius structure

* Define balls/rooted neighborhoods.
* Connect distance to bounded-radius views.

### Stage 4: Logic/game layer

* FO^k syntax.
* Locality radius interfaces.
* EF game scaffolding over bounded-radius data.

### Stage 5: Type/invariant interface

* Local type representation.
* Factorization interface.
* Global invariant interface.

## First tasks

* Build the repo.
* Read `docs/onboarding/ARCHITECTURE.md`.
* Read `docs/status/STATUS.md`.
* Run the example in `examples/MinimalCore.lean`.
  EOF

cd ~/github-audit/cslib-fmt && cat > docs/onboarding/ARCHITECTURE.md <<'EOF'

# Architecture

## Layer A: Core graph infrastructure

Purpose: paths, path length, existence, concatenation, reversal, distance.

Primary modules:

* `FMT.Graph.Basic`
* `FMT.Graph.PathLength`
* `FMT.Graph.Distance`
* `FMT.Graph.BoundedRadius`

Invariant:

* graph/path/distance layer is reusable independently of URF-specific claims.

## Layer B: Logic infrastructure

Purpose: FO^k syntax and locality-facing definitions.

Primary modules:

* `FMT.Logic.FOkSyntax`
* `FMT.Logic.LocalityRadius`

Invariant:

* syntax/locality layer depends only on stable graph/radius interfaces.

## Layer C: Game infrastructure

Purpose: EF/k-pebble style interfaces over bounded-radius structures.

Primary modules:

* `FMT.Game.EF`
* `FMT.Game.BoundedRadiusEF`

Invariant:

* game layer is separable from any specific obstruction theorem.

## Layer D: Type/factorization layer

Purpose: local types, factorization interfaces, definable compression boundaries.

Primary modules:

* `FMT.Types.LocalType`
* `FMT.Types.Factorization`
* `FMT.Types.WL`

Invariant:

* local descriptions remain modular and reusable.

## Layer E: Global invariant layer

Purpose: cycle-space, quotient/global obstruction interfaces.

Primary modules:

* `FMT.Invariants.CycleSpace`
* `FMT.Invariants.NonFactorization`

Invariant:

* global obstructions are stated independently from library-core utility theorems.

## Layer F: Examples

Purpose: explicit instances, high-girth/lift-style templates, separation witnesses.

Primary modules:

* `FMT.Examples.*`

Invariant:

* examples test interfaces without contaminating reusable core APIs.

## Public maturity rules

1. Stable imports from lower to higher layers only.
2. Closed / Conditional / Open status recorded explicitly.
3. Reusable modules documented independently of project-specific interpretation.
   EOF

cd ~/github-audit/cslib-fmt && cat > docs/status/STATUS.md <<'EOF'

# Theorem Status

Legend:

* Closed: theorem-level proof present in repository.
* Conditional: result depends on an explicitly named assumption/lemma.
* Open: result not yet proved in repository.

## Core graph layer

| Item                         | Status | File                               | Note                            |
| ---------------------------- | ------ | ---------------------------------- | ------------------------------- |
| PathLength basic structure   | Closed | `FMT/Graph/PathLength.lean`        | core path object                |
| Path reversal                | Closed | `FMT/Graph/PathLengthReverse.lean` | reversal infrastructure         |
| Path concatenation           | Closed | `FMT/Graph/PathLengthConcat.lean`  | concatenation infrastructure    |
| Distance existence baseline  | Closed | `FMT/Graph/Distance.lean`          | existence-level distance        |
| Distance symmetry            | Open   | `FMT/Graph/DistSymm.lean`          | theorem-level closure target    |
| Distance triangle inequality | Open   | `FMT/Graph/DistTriangle.lean`      | theorem-level closure target    |
| dist upper bound from path   | Open   | `FMT/Graph/DistancePath.lean`      | constructive replacement target |

## Logic/game layer

| Item                      | Status      | File                            | Note                                 |
| ------------------------- | ----------- | ------------------------------- | ------------------------------------ |
| FO^k syntax scaffold      | Conditional | `FMT/Logic/FOkSyntax.lean`      | dependent on current syntax coverage |
| Locality radius interface | Conditional | `FMT/Logic/LocalityRadius.lean` | review pending                       |
| EF scaffold               | Conditional | `FMT/Game/EF.lean`              | public baseline pending hardening    |

## Type/factorization layer

| Item                      | Status      | File                           | Note                           |
| ------------------------- | ----------- | ------------------------------ | ------------------------------ |
| Local type representation | Conditional | `FMT/Types/LocalType.lean`     | interface hardening pending    |
| FactorsThrough interface  | Conditional | `FMT/Types/Factorization.lean` | semantic strengthening pending |
| WL-facing layer           | Conditional | `FMT/Types/WL.lean`            | review pending                 |

## Global invariant layer

| Item                                   | Status      | File                                   | Note                            |
| -------------------------------------- | ----------- | -------------------------------------- | ------------------------------- |
| Cycle-space interface                  | Conditional | `FMT/Invariants/CycleSpace.lean`       | reusable API extraction pending |
| Non-factorization/separation interface | Open        | `FMT/Invariants/NonFactorization.lean` | research-facing frontier        |

## Release rule

A release is maturity-valid only if every exported item is labeled Closed, Conditional, or Open.
