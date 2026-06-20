# Pointed radius-ball equivalence to Cr2

STATUS := CONDITIONAL_CONSTRUCTOR_SOURCE_TO_CR2

THEOREM := `pointed_radius_ball_equiv_to_cr2`

STATEMENT := `PointedRadiusBallEquiv 𝒜 ℬ r a b → Cr2 𝒜 ℬ r a b`

PROOF_PATH := `PointedRadiusBallEquiv → PlainInducedRadiusBallIso → Cr2`

USES :=
- `pointed_radius_ball_equiv_to_plain_induced_radius_ball_isomorphism`
- `plain_induced_radius_ball_isomorphism_to_cr2`

FORBIDDEN_WRAPPER_NOT_ADDED := `ballIso_to_cr2`

BOUNDARY := ¬ cr2_unconditional_constructor
