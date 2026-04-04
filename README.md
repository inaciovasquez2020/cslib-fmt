# CSLIB FMT (Finite-Model Theory)

A Lean 4 library and research program for finite-model-theoretic locality, bounded-radius structure, EF games, FO^k syntax, local types, and cycle-space/global-obstruction interfaces.

## Current status

- Build: repository compiles on the pinned Lean toolchain.
- Scope: reusable finite-model-theory infrastructure plus project-specific higher layers.
- Public maturity target: stable core, explicit status map, reusable examples, contributor path.

## Start here

1. `lake build`
2. Read `docs/onboarding/START_HERE.md`
3. Run the minimal example path:
   - `FMT.Graph.PathLength`
   - `FMT.Graph.Distance`
   - `FMT.Logic.FOkSyntax`
   - `FMT.Game.EF`
4. Open `docs/status/STATUS.md` for Closed / Conditional / Open theorem status.
5. Open `docs/onboarding/ARCHITECTURE.md` for module layout.

## Reusable library surface

- Graph/path/distance infrastructure
- Bounded-radius / rooted-ball infrastructure
- FO^k syntax and locality scaffolding
- EF-game scaffolding
- Local type / factorization interfaces
- Cycle-space and obstruction interfaces

## Repository map

- `FMT/Graph` — graph, paths, distance, bounded-radius infrastructure
- `FMT/Logic` — FO^k syntax and locality-facing logic layer
- `FMT/Game` — EF-game infrastructure
- `FMT/Types` — local types, factorization, WL-facing interfaces
- `FMT/Invariants` — cycle-space and global obstruction layer
- `FMT/Examples` — explicit examples and separation templates
- `docs/` — public architecture, roadmap, notes, theorem status

## External validation surface

- See `docs/status/ROADMAP.md`
- See `docs/status/STATUS.md`
- See `.github/ISSUE_TEMPLATE/`
