# Existential constructor machine grep raw git-show identifier visibility resolution

STATUS := EXISTENTIAL_CONSTRUCTOR_MACHINE_GREP_RAW_GIT_SHOW_IDENTIFIER_VISIBILITY_RESOLUTION_ONLY

OBJECT := existential_constructor_machine_grep_raw_git_show_identifier_visibility_resolution

SOURCE_COMMIT := 6954d09

REVIEW_TARGET_COMMIT := cc60f9a

SOURCE_STATUS := EXISTENTIAL_CONSTRUCTOR_RAW_GIT_SHOW_AI_REVIEW_CONFLICT_ONLY

RAW_GIT_SHOW_COMMAND := git show cc60f9a:lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean

MACHINE_GREP_RESULT := identifier_present_in_raw_git_show_output

FOUND_IDENTIFIER := `existential_constructor_actual_downstream_theorem_use_status`

FOUND_IDENTIFIER_LINE_NUMBERS := [1607, 1610, 1611]

FOUND_CLOSED_IDENTIFIER := `existential_constructor_actual_downstream_theorem_use_status_closed`

FOUND_CLOSED_IDENTIFIER_LINE_NUMBERS := [1610]

NAMED_EDGE_FORBIDDEN_TOKENS_ABSENT :=

- `sorry`
- `admit`
- `axiom`
- `opaque`

CONFLICT_RESOLUTION := machine_grep_resolves_ai_visibility_conflict_to_identifier_present_in_raw_git_show_output

CLAUDE_REVIEW_STATUS := not_supported_by_machine_grep_except_render_truncation_caveat

GEMINI_REVIEW_STATUS := supported_by_machine_grep

This resolves only the machine-visible raw-file identifier conflict. It does not claim external acceptance, independent expert validation, mathematical certification, reviewer confirmation, human review, Fagin's theorem, the 0-1 Law, Pk1 route closure, 2vK route closure, or new external mathematical acceptance.

WEAKEST_NEXT_BOUNDARY := independent_live_repository_or_human_review
