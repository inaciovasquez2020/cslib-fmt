# Full formula-radius historical boundary supersession notes

Status: `FULL_FORMULA_RADIUS_HISTORICAL_BOUNDARY_SUPERSESSION_NOTES`

Policy:

- Preserve old historical boundary records unchanged.
- Add targeted supersession notes.
- Do not rewrite historical status records.

The repository-internal `full_formula_radius_construction` object was closed by commit `e352dfa`.

Historical downstream records that mention the old full formula-radius construction boundary remain provenance-preserving records of their original state. They should now be read as pre-`e352dfa` historical boundary records, not as current repository state.

Current state: `full_formula_radius_construction` is closed internally in the repository.

Source audit: `artifacts/full_formula_radius_downstream_old_boundary_audit_2026_06_21.json`
Source audit hit count: `66`

## Superseded historical paths

- `artifacts/cslib_fmt/formula_radius_construction_weakest_missing_branch_classification_2026_06_20.json`
- `artifacts/cslib_fmt/noncomputable_audit_2026_06_19.json`
- `artifacts/cslib_fmt/unguarded_fo_formula_radius_construction_gap_2026_06_20.json`
- `artifacts/existential_body_assignment_extension_invariance_component_package_2026_06_21.json`
- `artifacts/existential_body_distinct_witness_assignment_extension_invariance_2026_06_21.json`
- `artifacts/existential_body_same_witness_assignment_extension_invariance_2026_06_21.json`
- `artifacts/existential_body_witness_locality_transport_type_shell_2026_06_21.json`
- `artifacts/existential_body_witness_transport_inhabitance_failure_lock_2026_06_21.json`
- `artifacts/existential_constructor_definition_inspection_2026_06_21.json`
- `artifacts/existential_constructor_frontier_from_body_invariance_package_status_2026_06_21.json`
- `artifacts/existential_constructor_obligation_gap_package_status_2026_06_21.json`
- `artifacts/existential_ex_body_to_quantified_radius_witness_constructor_shell_2026_06_21.json`
- `artifacts/existential_ex_body_to_quantified_radius_witness_constructor_stopping_point_2026_06_21.json`
- `artifacts/existential_locality_radius_constructor_missing_theorem_status_2026_06_21.json`
- `artifacts/formula_radius_construction_gate_structural_recursion_edge_2026_06_21.json`
- `artifacts/formula_structural_recursion_positive_radius_edge_2026_06_21.json`
- `artifacts/full_unguarded_fo_pk1_route_gap_rank_2026_06_21.json`
- `artifacts/pk1_quantified_constructor_branch_frontier_status_2026_06_21.json`
- `artifacts/pk1_target_theorem_statement_shell_2026_06_21.json`
- `artifacts/twovk_bridge_target_shell_2026_06_21.json`
- `artifacts/twovk_to_pk1_formula_radius_gate_structural_recursion_status_2026_06_21.json`
- `artifacts/twovk_to_pk1_frontier_formula_radius_gate_status_2026_06_21.json`
- `artifacts/twovk_to_pk1_quantified_constructor_frontier_status_2026_06_21.json`
- `artifacts/twovk_to_pk1_statement_status_2026_06_21.json`
- `artifacts/twovk_to_pk1_structural_recursion_proof_bearing_quantifier_status_2026_06_21.json`
- `docs/status/ATOMIC_FORMULA_RADIUS_INPUT_CONNECTION_STATUS_2026_06_20.md`
- `docs/status/EXISTENTIAL_BODY_ASSIGNMENT_EXTENSION_INVARIANCE_COMPONENT_PACKAGE.md`
- `docs/status/EXISTENTIAL_BODY_DISTINCT_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE.md`
- `docs/status/EXISTENTIAL_BODY_SAME_WITNESS_ASSIGNMENT_EXTENSION_INVARIANCE.md`
- `docs/status/EXISTENTIAL_BODY_WITNESS_LOCALITY_TRANSPORT_TYPE_SHELL.md`
- `docs/status/EXISTENTIAL_BODY_WITNESS_TRANSPORT_INHABITANCE_FAILURE_LOCK.md`
- `docs/status/EXISTENTIAL_CONSTRUCTOR_DEFINITION_INSPECTION.md`
- `docs/status/EXISTENTIAL_CONSTRUCTOR_FRONTIER_FROM_BODY_INVARIANCE_PACKAGE_STATUS.md`
- `docs/status/EXISTENTIAL_CONSTRUCTOR_OBLIGATION_GAP_PACKAGE_STATUS.md`
- `docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_SHELL.md`
- `docs/status/EXISTENTIAL_EX_BODY_TO_QUANTIFIED_RADIUS_WITNESS_CONSTRUCTOR_STOPPING_POINT.md`
- `docs/status/EXISTENTIAL_LOCALITY_RADIUS_CONSTRUCTOR_MISSING_THEOREM_STATUS.md`
- `docs/status/FORMULA_RADIUS_CONSTRUCTION_GATE_STRUCTURAL_RECURSION_EDGE.md`
- `docs/status/FORMULA_RADIUS_CONSTRUCTION_WEAKEST_MISSING_BRANCH_CLASSIFICATION_2026_06_20.md`
- `docs/status/FORMULA_STRUCTURAL_RECURSION_POSITIVE_RADIUS_EDGE.md`
- `docs/status/FULL_UNGUARDED_FO_PK1_ROUTE_GAP_RANK.md`
- `docs/status/PK1_QUANTIFIED_CONSTRUCTOR_BRANCH_FRONTIER_STATUS.md`
- `docs/status/PK1_TARGET_THEOREM_STATEMENT_SHELL.md`
- `docs/status/TWOVK_BRIDGE_TARGET_SHELL.md`
- `docs/status/TWOVK_TO_PK1_FORMULA_RADIUS_GATE_STRUCTURAL_RECURSION_STATUS.md`
- `docs/status/TWOVK_TO_PK1_FRONTIER_FORMULA_RADIUS_GATE_STATUS.md`
- `docs/status/TWOVK_TO_PK1_QUANTIFIED_CONSTRUCTOR_FRONTIER_STATUS.md`
- `docs/status/TWOVK_TO_PK1_STATEMENT_STATUS.md`
- `docs/status/TWOVK_TO_PK1_STRUCTURAL_RECURSION_PROOF_BEARING_QUANTIFIER_STATUS.md`
- `docs/status/UNGUARDED_FO_FORMULA_RADIUS_CONSTRUCTION_GAP_2026_06_20.md`
- `tools/verify_existential_body_witness_locality_transport_type_shell.py`
- `tools/verify_existential_body_witness_transport_inhabitance_failure_lock.py`
- `tools/verify_existential_constructor_definition_inspection.py`
- `tools/verify_existential_constructor_frontier_from_body_invariance_package_status.py`
- `tools/verify_existential_ex_body_to_quantified_radius_witness_constructor_stopping_point.py`
- `tools/verify_existential_locality_radius_constructor_missing_theorem_status.py`
- `tools/verify_formula_radius_construction_gate_structural_recursion_edge.py`
- `tools/verify_full_unguarded_fo_pk1_route_gap_rank.py`
- `tools/verify_pk1_quantified_constructor_branch_frontier_status.py`
- `tools/verify_pk1_target_theorem_statement_shell.py`
- `tools/verify_twovk_bridge_target_shell.py`
- `tools/verify_twovk_to_pk1_formula_radius_gate_structural_recursion_status.py`
- `tools/verify_twovk_to_pk1_frontier_formula_radius_gate_status.py`
- `tools/verify_twovk_to_pk1_quantified_constructor_frontier_status.py`
- `tools/verify_twovk_to_pk1_statement_status.py`
- `tools/verify_twovk_to_pk1_structural_recursion_proof_bearing_quantifier_status.py`

Boundary: supersession-notes only; old historical artifacts and docs are preserved unchanged; no external finite-model-theory closure is claimed.
