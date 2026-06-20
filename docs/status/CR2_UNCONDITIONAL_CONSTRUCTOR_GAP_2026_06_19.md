# CR2_UNCONDITIONAL_CONSTRUCTOR_GAP_2026_06_19

## Status

`Cr2` is not yet an unconditional closure input.

## Weakest missing lemma

```lean
theorem cr2_unconditional_constructor
    {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    (r : Nat) (a : α) (b : β) :
    Cr2 𝒜 ℬ r a b
Reason
Cr2 currently projects the existing restricted guarded-locality input surface, but no theorem constructs Cr2 for arbitrary structures, radius, and points without new hypotheses.
Retained bounded result
Cr2 conditionally discharges the bounded/restricted guarded-locality input surface.
Unconditional closure blocker
An internal proof of cr2_unconditional_constructor is required before Cr2 can be used as an unconditional closure input.
Nonclaims
No arbitrary Cr2 witness is constructed.
No unguarded FO locality theorem is claimed.
No full Gaifman locality theorem is claimed.
No Fagin theorem or 0-1 Law result is claimed.
No global finite-model-theory final theorem is claimed.
No external-validation result is claimed.
Boundary locks
- BOUNDARY := ¬ Fagin theorem
- BOUNDARY := ¬ 0-1 Law
- BOUNDARY := ¬ full Gaifman locality
- BOUNDARY := ¬ unguarded FO locality
- BOUNDARY := ¬ global finite-model-theory final theorem
- BOUNDARY := ¬ external validation claim
