# Existential constructor next boundary rank

STATUS := EXISTENTIAL_CONSTRUCTOR_NEXT_BOUNDARY_RANK_ONLY

OBJECT := existential_constructor_next_boundary_rank

SOURCE_STATUS := EXISTENTIAL_CONSTRUCTOR_BOUNDARY_SUPERSESSION_STATUS_ONLY

This ranks the two next boundaries after the existential-constructor supersession status.

RANKED_BOUNDARIES :=

1. `new_downstream_theorem_use`

   Reason: this is internal and executable before external review. It can be checked by adding one bounded downstream theorem or status use of the current Lean surface.

2. `external_independent_validation`

   Reason: this depends on an external reviewer or public acceptance signal. It is useful, but less directly executable than an internal downstream use.

DOES_NOT_CLAIM := external acceptance, Fagin's theorem, the 0-1 Law, a new mathematical theorem, Pk1 route closure, or 2vK route closure.

WEAKEST_NEXT_BOUNDARY := new_downstream_theorem_use
