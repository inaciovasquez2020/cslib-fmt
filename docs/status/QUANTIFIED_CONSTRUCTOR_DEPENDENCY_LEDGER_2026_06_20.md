# QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER_2026_06_20

STATUS := DEPENDENCY_LEDGER_ONLY

TARGET := quantified_formula_radius_constructor_branch

BASE_HEAD := 7922f15

UPSTREAM_CLOSED_INPUTS :=
- QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_TARGET_SHELL
- FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION
- ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS
- FORMULA_RADIUS_CONSTRUCTION_GATE_STATUS_FROM_BOUNDED_BOOLEAN_RECURSION_GATE
- BOUNDED_BOOLEAN_RECURSION_GATE_FROM_FINITE_BOOLEAN_FOLD_ACCESS_SURFACE

REQUIRED_MISSING_DEPENDENCIES :=
1. quantifier_locality_input_transport
   - reason: a quantified constructor must relate the locality input surface for the body formula to the locality input surface for the quantified formula.
2. assignment_extension_or_projection_radius_control
   - reason: quantifier semantics changes the assignment context, so radius control must survive the variable-extension/projection step.
3. quantified_formula_radius_constructor
   - reason: the constructor itself is downstream of the transport and assignment-radius control dependencies.

WEAKEST_NEXT_DEPENDENCY := quantifier_locality_input_transport

BOUNDARY := ¬ quantified_formula_radius_constructor

NEXT_ACTIONS :=
1. Add only a quantifier locality input transport target shell.
