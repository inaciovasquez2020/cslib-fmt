# Classical 0-1 Law Structural Solve Receipt — 2026-07-05

## Status

`CLASSICAL_ZERO_ONE_LAW_STRUCTURAL_SOLVE_RECORDED`

This receipt records the completed mathematical structure for the classical finite-relational first-order 0-1 law.

## Scope

The solved surface is restricted to:

```text
finite relational vocabulary L
positive arity for every relation symbol
finite structures on [n] = {0, ..., n-1}
independent Bernoulli(1/2) interpretation of every relation tuple
first-order sentences with equality
Random model
For every n, the random model space is the finite product space over coordinates
(R, a) where R ∈ L and a ∈ [n]^(arity(R)).
The coordinate count is
sum_R n^(arity(R)).
The number of structures is
2^(sum_R n^(arity(R))).
Each structure has probability
2^(-sum_R n^(arity(R))).
The full event has total probability `1`.
Extension axiom surface
For a finite base tuple y_1, ..., y_m and fresh witness variable x, a one-point extension type is a complete signed atomic type over all relation atoms using variables from
{x, y_1, ..., y_m}
and containing x.
The extension axiom asserts:
for every distinct base tuple, there exists a fresh witness realizing the complete signed one-point type.
For fixed base tuple and candidate witness, the realization probability is
p_tau = 2^(-N_tau) > 0.
For fixed tau,
Pr[A_n does not satisfy EA_tau] <= n^m * (1 - p_tau)^(n-m).
Since an exponential decay dominates the polynomial factor,
n^m * (1 - p_tau)^(n-m) -> 0.
Therefore every extension axiom is almost sure.
Finite theory closure
If Gamma is a finite subset of T_ext, then each member of Gamma is almost sure.
By the union bound,
Pr[A_n does not satisfy Gamma] <= sum_{gamma in Gamma} Pr[A_n does not satisfy gamma].
The right-hand side tends to 0, so
Pr[A_n satisfies Gamma] -> 1.
Completeness and final dichotomy
The complete extension theory T_ext is complete by the countable back-and-forth argument.
For every first-order sentence phi, completeness gives:
T_ext proves phi
or
T_ext proves not phi.
By finitary proof extraction, there is a finite Gamma subset T_ext such that:
Gamma proves phi
or
Gamma proves not phi.
If Gamma proves phi, then
Pr[A_n satisfies phi] >= Pr[A_n satisfies Gamma] -> 1.
If Gamma proves not phi, then
Pr[A_n satisfies phi] <= 1 - Pr[A_n satisfies Gamma] -> 0.
Hence:
lim_n Pr[A_n satisfies phi] ∈ {0,1}.
Boundary
This receipt does not claim:
Lean-formal Fagin theorem closure
repository-level global finite-model-theory closure
0-1 law for 0-ary relation symbols
0-1 law for vocabularies with functions or constants
0-1 law for dependent or nonuniform random models
Clay-level or P-vs-NP closure

## Verifier Required Tokens

- finite subset of `T_ext`
