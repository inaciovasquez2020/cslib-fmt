# Unguarded FO formula-radius frontier stop — 2026-06-20

STATUS := `FORMULA_RADIUS_FRONTIER_STOP`

SCOPE :=

Status/documentation scoped final stopping point. No new Lean theorem is introduced by this layer.

CLOSED_CHAIN :=

- `FINITE_BOOLEAN_FOLD_ACCESS_STATUS_LOCK`
- `FORMULA_RADIUS_CONSTRUCTION_GAP_TARGET`
- `ATOMIC_LOCALITY_INPUT_EXISTENCE_TARGET_ONLY`

STOP_REASON :=

- finite Boolean fold access chain is complete enough for expression-index scoped access
- formula-radius construction is blocked by atomic locality input existence
- arbitrary atomic existence must not be asserted
- recursive formula-radius construction must not be introduced before atomic input and radius transport obligations

WEAKEST_REMAINING_POINT :=

`atomic locality input existence`

NEXT_ADMISSIBLE_CONDITION :=

Only continue if a concrete downstream theorem forces a named conditional atomic locality obligation surface.

BOUNDARY :=

This is the stopping point for the current finite Boolean fold access and formula-radius gap sequence.

It does not assert atomic locality input existence. It does not assert existence for arbitrary atoms. It does not introduce a recursive formula-radius construction theorem.

Still no atomic locality input existence, no formula-radius construction theorem, no arbitrary bounded-fragment closure, no radius monotonicity, no unguarded FO locality theorem, no full Gaifman locality, no Fagin theorem, no 0-1 Law, and no general FMT closure.
