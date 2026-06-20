# No earlier LocalIso constructor source

STATUS := NO_EARLIER_LOCALISO_CONSTRUCTOR_SOURCE

TARGET := `LocalIso 𝒜 ℬ r a b`

WEAKEST_EXISTING_PRODUCER := `ballIso_to_localIso`

CLASSIFICATION := back-wrapper from `BallIso`, not a strictly earlier constructor source.

PATCH_DECISION := no new theorem.

BOUNDARY := ¬ cr2_unconditional_constructor
