# Unguarded FO formula-radius construction gap — 2026-06-20

STATUS := `FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET`

SCOPE :=

Status/documentation scoped gap target only. No new Lean theorem is introduced by this layer.

PREVIOUS_CHAIN_STOP :=

`FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK`

The finite Boolean fold access chain is stopped unless a downstream theorem forces a missing expression-index scoped access lemma.

WEAKEST_GAP :=

`atomic locality input existence`

RANKED_GAPS :=

1. atomic locality input existence
2. constructor-local radius propagation specification
3. formula syntax recursion target for all Formula constructors
4. radius monotonicity or explicit radius equality transport
5. fragment-membership bridge from recursive construction outputs
6. full formula-radius construction theorem

BLOCKED_THEOREM :=

Formula-radius construction theorem for arbitrary unguarded FO formulas.

BLOCKED_REASON :=

- finite Boolean fold access is expression-index scoped only
- atomic locality input existence is not yet provided
- no global recursive radius assignment over all Formula constructors is proved
- no monotonicity/transport layer for changing radii is proved

ADMISSIBLE_NEXT_LAYER :=

Surface an atomic locality input existence target before attempting recursive formula-radius construction.

Do not assert existence for arbitrary atoms. Do not introduce a recursive formula-radius theorem. Do not generalize finite Boolean fold access to arbitrary fragments.

BOUNDARY :=

This is a formula-radius construction gap target only.

Still no atomic locality input existence, no formula-radius construction theorem, no arbitrary bounded-fragment closure, no radius monotonicity, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.

NEXT_TARGET := add a status-only atomic locality input existence target.
