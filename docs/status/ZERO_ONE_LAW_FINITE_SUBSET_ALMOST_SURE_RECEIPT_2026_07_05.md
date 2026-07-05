Zero-One Law Finite Subset Almost-Sure Receipt — 2026-07-05
Status
FINITE_SUBSET_T_EXT_ALMOST_SURE_RECEIPT_RECORDED
Scope
This receipt records the finite union-bound closure step used in the classical finite-relational first-order 0-1 law.
The input is:
Gamma finite subset of T_ext
for every gamma in Gamma, Pr[A_n satisfies gamma] -> 1
The output is:
Pr[A_n satisfies Gamma] -> 1
Proof surface
For each gamma in Gamma:
Pr[A_n does not satisfy gamma] -> 0
If A_n does not satisfy Gamma, then it fails at least one member of Gamma:
A_n does not satisfy Gamma
implies
exists gamma in Gamma, A_n does not satisfy gamma
By the union bound:
Pr[A_n does not satisfy Gamma]
<=
sum_{gamma in Gamma} Pr[A_n does not satisfy gamma]
Because Gamma is finite, the right-hand side is a finite sum of sequences tending to 0.
Therefore:
Pr[A_n does not satisfy Gamma] -> 0
and hence:
Pr[A_n satisfies Gamma] -> 1
Boundary
This receipt does not claim:
almost-sure closure for infinite subsets of T_ext
countable intersection closure
dependent probability model closure
nonuniform probability model closure
Lean-formal probability theorem closure
