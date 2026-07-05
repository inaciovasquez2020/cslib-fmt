# Exported Theorem Surface Audit Receipt

STATUS := syntactic Lean declaration-surface audit recorded.

## Scope

This receipt records a generated audit over Lean declaration surfaces in `cslib-fmt`.

It classifies declarations into:

```text
definition_or_specification
verified_lemma
conditional_theorem_or_boundary
scaffold_or_example
forbidden_or_untrusted_declaration
Counts
declaration_count := 531
definition_or_specification := 219
verified_lemma := 154
conditional_theorem_or_boundary := 118
scaffold_or_example := 40
forbidden_or_untrusted_declaration := 0
Positive receipt
The repository now has a generated theorem-surface visibility receipt separating definitions/specifications, verified lemmas, conditional theorem or boundary surfaces, scaffolds/examples, and forbidden or untrusted declarations.
Required verifier
python3 tools/verify_exported_theorem_surface_audit_receipt.py
Boundaries
BOUNDARY := ¬ exported_theorem_audit_receipt_implies_global_FMT_closure
BOUNDARY := ¬ exported_theorem_audit_receipt_implies_Fagin_theorem
BOUNDARY := ¬ exported_theorem_audit_receipt_implies_zero_one_law
BOUNDARY := ¬ exported_theorem_audit_receipt_implies_Pk1_route_closure
BOUNDARY := ¬ exported_theorem_audit_receipt_implies_2vK_route_closure
BOUNDARY := ¬ syntactic_declaration_audit_implies_external_acceptance
Non-claims
NOT_CLAIMED :=
- Fagin theorem
- 0-1 Law
- Pk1 route closure
- 2vK route closure
- global finite-model-theory closure
- external acceptance
- semantic final-theorem proof from syntactic declaration classification
