# FINITE_BOOLEAN_DISJUNCTION_FOLD_ACCESS_SURFACE_2026_06_20

STATUS := ACCESS_SURFACE_ONLY

OBJECTS :=
- def finite_boolean_disjunction_fold_access_surface
- theorem finite_boolean_disjunction_fold_access_surface_closed

SOURCE := lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean

BASE_HEAD := 58feab3

LOCKED_CLAIM := finite Boolean disjunction fold access surface exists as checked Lean declarations and is locked against existing repository-level finite Boolean fold declarations.

LOCAL_DEPENDENCIES :=
- theorem unguarded_fo_disj_same_radius_constructor
- theorem unguarded_fo_disj_common_smaller_radius_constructor

REPOSITORY_DEPENDENCIES :=
- finite_boolean_family_fold
- finite_boolean_family_fold_shared_radius

BOUNDARY := ¬ arbitrary_boolean_or_quantifier_recursion

NEXT_ACTIONS :=
1. Add only the bounded Boolean recursion gate from the finite Boolean fold access surface.
