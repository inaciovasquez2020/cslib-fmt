# FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION_2026_06_20

STATUS := CLASSIFICATION_ONLY

FRONTIER := between atomic formula-radius input connection status and full unguarded FO formula-radius construction

BASE_HEAD := 52d012a

CLOSED_INPUTS :=
- ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS
- FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE
- BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE

RANKED_GAPS :=
1. quantified_formula_radius_constructor_branch
   - reason: full formula-radius construction cannot be assembled from atomic input plus bounded Boolean recursion without a checked constructor branch for quantified formulas.
2. formula_structural_recursion_assembler
   - reason: the global construction still needs a structural recursion/induction assembler after every constructor branch is available.
3. full_unguarded_fo_formula_radius_construction
   - reason: the full theorem remains downstream of the quantified branch and the structural assembler.

WEAKEST_MISSING_BRANCH := quantified_formula_radius_constructor_branch

BOUNDARY := ¬ unguarded_fo_formula_radius_construction

NEXT_ACTIONS :=
1. Add only a quantified formula-radius constructor target shell.
