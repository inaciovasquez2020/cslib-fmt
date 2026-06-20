# QUANTIFIED_FORMULA_RADIUS_CONSTRUCTOR_DEPENDENCY_STATUS_GATE_2026_06_20

STATUS := DEPENDENCY_STATUS_GATE_ONLY

OBJECTS :=
- def quantified_formula_radius_constructor_dependency_status_gate
- theorem quantified_formula_radius_constructor_dependency_status_gate_closed

SOURCE := lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean

BASE_HEAD := 06ecb91

TARGET := quantified_formula_radius_constructor

LOCKED_CLAIM := quantified formula-radius constructor dependency-status gate exists as checked Lean declarations, derived only from the assignment extension/projection radius-control target shell.

CLOSED_DEPENDENCY_TARGETS :=
- quantifier_locality_input_transport_target_shell
- assignment_extension_projection_radius_control_target_shell

DEPENDENCIES :=
- def assignment_extension_projection_radius_control_target_shell
- theorem assignment_extension_projection_radius_control_target_shell_closed
- def quantifier_locality_input_transport_target_shell
- theorem quantifier_locality_input_transport_target_shell_closed
- def quantified_formula_radius_constructor_target_shell
- theorem quantified_formula_radius_constructor_target_shell_closed
- QUANTIFIED_CONSTRUCTOR_DEPENDENCY_LEDGER

BOUNDARY := ¬ quantified_formula_radius_constructor

NEXT_ACTIONS :=
1. Classify the next weakest obstruction to proving quantified_formula_radius_constructor.
