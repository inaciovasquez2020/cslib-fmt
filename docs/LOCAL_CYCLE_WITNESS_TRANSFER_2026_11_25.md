# Local cycle witness transfer

PROVED_ON_PAPER; Lean NOT_RUN. Existing CyclePartitionRadiusMinimax unchanged.

For local cycle spaces U_v embedded in a common edge space, extract a basis of their sum from the union of local bases. Assign each basis vector to a supporting vertex. Each vertex supports at most dim U_v assigned independent vectors. Keeping one per used vertex gives at least ceil(d/D) independent vectors with distinct centers, where d=dim(sum_v U_v) and D=max_v dim U_v>0. If D=0 the span is zero.

For even m>=6, C_m square C_m is vertex-transitive but contains m^2/4 vertex-disjoint unit squares based at even coordinates; these provide independent radius-two cycles. Homogeneity does not bound the embedded span. This does not contradict the cycle-partition minimax theorem.

Canonical general theorem: URF-Core PR #605 (paper proof). Inspect mathlib independent transversal and basis extraction before formalizing. Lean 4.30.0-rc1 here versus 4.27.0 in URF-Core; compatibility not assumed. No imports or formal declarations changed.
