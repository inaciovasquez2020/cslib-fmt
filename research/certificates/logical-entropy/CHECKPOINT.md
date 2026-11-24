# Logical entropy separation — verified checkpoint

- Verified commit: `bd2ac6f76279ff974250d6efafb93cedfc31cb09`
- Verification: https://github.com/inaciovasquez2020/cslib-fmt/actions/runs/45452648854
- Toolchain: Lean 4.30.0-rc1
- Mathlib: 0c154d67103f74be3a0f2c509f72ccbf5be9f2a7
- CI: 10/10 passed at checkpoint.
- Axioms: propext, Classical.choice, Quot.sound only for all six audited declarations.

Theorems: cycleObservation_finrank, cycleEntropy_exact, witnessLength_bounds,
cycleOrder_eq_card, logicalEntropy_witnesses, logicalEntropy_estimator_lower_bound.

Scope: indexed oriented cyclic edge-chain model with actual conditional Shannon entropy.
For every rank r and gap parameter m over a finite field, equal-order rank-equivalent
cyclic witnesses have entropy difference m log |K|. Every rank-invariant estimator
has worst-case error at least half that gap.

Remaining: ordered-edge SimpleGraph representation interoperability; manuscript.
Independent novelty review is not a required completion milestone, by author direction.
No originality or external endorsement is claimed. No merge is authorized by this record.
