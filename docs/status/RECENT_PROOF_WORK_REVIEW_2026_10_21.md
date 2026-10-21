# Recent Proof-Bearing Work Review — 2026-10-21

## Scope

This is a source-linked status refresh for recent work already merged into `main`. It records the exact bounded results and their non-claim boundaries. It does not promote build success or a status record into a broader theorem claim.

Reviewed base commit: `2b47798cae0f46c549a6427d134575ba390819ca`.

## Recent merged changes

### PR #191 — local pointed-neighborhood back-and-forth surface

Source: [PR #191](https://github.com/inaciovasquez2020/cslib-fmt/pull/191)

The merged change added a proof-bearing `PointedNeighborhoodEquiv` surface, preservation of equality and relation atoms, quantified witness back-and-forth, structural formula preservation, and interfaces derived from relational automorphisms. The PR records a direct target-file Lean check.

**Boundary:** no concrete `LocalPointedBackAndForth` witness independent of global automorphisms was established by that change. It does not prove Gaifman locality.

### PR #192 — reflexive local pointed back-and-forth witness

Source: [PR #192](https://github.com/inaciovasquez2020/cslib-fmt/pull/192)

The merged change constructs the reflexive witness `LocalPointedBackAndForth M r ρ ρ`, using equality of assignments and the identity pointed-neighborhood equivalence. The PR records direct Lean checking, `lake build`, and the proof-portfolio and external-status-lock verifiers.

**Boundary:** this closes only the reflexive base case. It does not construct the required nontrivial local back-and-forth system between distinct assignments and does not prove Gaifman locality.

### PR #193 — natural-number left cancellation core lemma

Source: [PR #193](https://github.com/inaciovasquez2020/cslib-fmt/pull/193)

The merged source `CslibFmt/FormalContent/NonVacuousCore.lean` now contains:

```lean
theorem nat_add_left_cancel_core {a b c : Nat}
    (h : a + b = a + c) : b = c :=
  Nat.add_left_cancel h
```

The PR describes this as a proof-bearing lemma without axioms or placeholders. The merge commit's Lean CI and proof-portfolio classification workflows passed.

## Current boundary

- The recent locality work is reusable formal infrastructure, not a completed Gaifman locality theorem.
- No Fagin theorem, 0-1 Law, or global finite-model-theory closure is claimed.
- The July 5, 2026 exported theorem-surface receipt is historical and does not include the left-cancellation lemma added in PR #193. Its count must not be presented as the current complete declaration count.
- The strict current count of machine-verified solved theorems remains unaudited. A fresh syntactic inventory alone would not settle proof dependencies or conditionality.
- Recent work in cosmology or other unrelated repositories is not imported here as a finite-model-theory theorem.

## Recommended next mathematical frontier

Construct a non-reflexive `LocalPointedBackAndForth` witness for distinct assignments without relying on a global automorphism, or record a precise obstruction if the required hypotheses are insufficient. Only then reassess whether a standard Gaifman-locality theorem is within reach.

This document records existing merged work; it does not add a new Lean theorem.
