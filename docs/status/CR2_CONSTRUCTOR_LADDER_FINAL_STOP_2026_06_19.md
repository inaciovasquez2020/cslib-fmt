# Cr2 constructor ladder final stop

STATUS := FINAL_BOUNDED_CR2_LADDER_STOP

CLOSED_CONDITIONAL_CHAIN :=
- `PlainInducedRadiusBallIso → Cr2`
- `PointedRadiusBallEquiv → PlainInducedRadiusBallIso → Cr2`
- `LocalIso → BallIso → PointedRadiusBallEquiv → Cr2`

STOPPING_LOCKS :=
- `NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19`
- `NO_EXTERNAL_BELOW_LOCALISO_CONSTRUCTOR_SOURCE_2026_06_19`

LADDER_STATUS := bounded Cr2 constructor ladder stops at `LocalIso`.

PATCH_DECISION := no new theorem.

FORBIDDEN_WRAPPER_NOT_ADDED := `ballIso_to_cr2`

BOUNDARY := ¬ cr2_unconditional_constructor
