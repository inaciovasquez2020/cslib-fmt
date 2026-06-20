# No external or below-LocalIso constructor source

STATUS := NO_EXTERNAL_OR_BELOW_LOCALISO_CONSTRUCTOR_SOURCE

TARGET := `LocalIso 𝒜 ℬ r a b`

RESULT := no declaration in `lean/**/*.lean` produces `LocalIso` from a strictly earlier source.

KNOWN_PRODUCER := `ballIso_to_localIso`, classified as a back-wrapper from `BallIso`.

PATCH_DECISION := no new theorem.

LADDER_STATUS := bounded Cr2 constructor ladder stops at `LocalIso`.

BOUNDARY := ¬ cr2_unconditional_constructor
