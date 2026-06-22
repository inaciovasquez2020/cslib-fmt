# Existential constructor downstream reuse check

STATUS := EXISTENTIAL_CONSTRUCTOR_DOWNSTREAM_REUSE_CHECK_ONLY

OBJECT := existential_constructor_downstream_reuse_check

This records one downstream reuse check for the current existential-constructor frontier.

The check is intentionally bounded. It only verifies that the downstream status layer names and depends on the existing existential-constructor surface objects:

- `existential_locality_radius_constructor`
- `concrete_quantifier_locality_transport_named_interface`
- `existential_constructor_obligation_gap_package_status`

It does not prove the missing constructor.

MISSING_OBJECT := existential_ex_body_to_quantified_radius_witness_constructor
