# CSLIB-FMT Public Status Update — 2026-11-06

## Purpose

This dated status update records a corrected locality frontier. It is a separate documentation update, **not** a replacement for the June 2, 2026 release and **not** a new theorem claim.

## Preserved historical release

- Release: [Public cslib-fmt finite graph diameter — 2026-06-02](https://github.com/inaciovasquez2020/cslib-fmt/releases/tag/public-cslib-fmt-finite-graph-diameter-2026-06-02)
- Original tag: `public-cslib-fmt-finite-graph-diameter-2026-06-02`
- Tagged commit: `aa3040363dfad3e76ebef1abf93209d1802016e0`
- Bounded release scope: finite unweighted graph diameter, `Option Nat` distance-value surface. No weighted or infinite-graph theorem is implied.

## Corrected current locality frontier

`STATUS.md` previously said `Remaining Live Frontier: none`. The statement was corrected in commit [`0684a896`](https://github.com/inaciovasquez2020/cslib-fmt/commit/0684a8965b68125a40f8bc8fd319ab75c46e93c1).

The outstanding mathematical obligation is a **non-reflexive `LocalPointedBackAndForth` witness between distinct assignments without relying on a global automorphism**, or a precise obstruction showing that the available hypotheses do not suffice.

The merged proof-bearing work summarized in [the October 21 review](RECENT_PROOF_WORK_REVIEW_2026_10_21.md) includes PRs [#191](https://github.com/inaciovasquez2020/cslib-fmt/pull/191), [#192](https://github.com/inaciovasquez2020/cslib-fmt/pull/192), and [#193](https://github.com/inaciovasquez2020/cslib-fmt/pull/193). These are scoped results. A standard Gaifman-locality theorem, Fagin's theorem, an unrestricted 0-1 law, and global finite-model-theory completion remain **not established**.

## Validation of the correction

Checks for `0684a8965b68125a40f8bc8fd319ab75c46e93c1`:

- [External status lock — PASS](https://github.com/inaciovasquez2020/cslib-fmt/actions/runs/42277523436), including the existing status verifier and bounded regression checks.
- [Lean CI — PASS](https://github.com/inaciovasquez2020/cslib-fmt/actions/runs/42277523424).
- [Lean proof-portfolio classification — PASS](https://github.com/inaciovasquez2020/cslib-fmt/actions/runs/42277523507).

The correction changes documentation only. Build and status-verifier success do not establish the open mathematics. The historical release and original tag were not modified.
