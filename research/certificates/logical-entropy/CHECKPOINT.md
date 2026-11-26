# Logical entropy integration

## Historical indexed checkpoint

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

At that checkpoint, ordered-edge SimpleGraph representation interoperability and the manuscript were open.
Independent novelty review is not a required completion milestone, by author direction.
No originality or external endorsement is claimed. No merge is authorized by this record.

The current integration ports URF-core PR #603 at
`d5916b12a6eb2df34fb150ce2e804236f077e7c7`. The exact source digests are
in [urf-source.sha256](urf-source.sha256).

## Signed incidence and entropy

For the graph interpreting the cyclic EF witness relation, the orientation of
a canonical ordered edge may differ from the successor direction. The signed
coordinate change intertwines the graph boundary and the indexed
predecessor-minus-current boundary. A nonzero edge coefficient stays nonzero
under this transport. Therefore the span of kernel vectors supported in
induced closed one-balls transfers to the graph incidence kernel.

The logical entropy is the weighted conditional Shannon entropy of the
uniform dual sample given its restriction to that span. Each witness cycle
has length at least four. Its induced closed one-ball contains no cycle, and
the formal support argument proves that the full observation span is zero.
The conditioning channel consequently has a single output and the
conditional entropy equals the entropy of the full uniform dual in these witnesses.
Channels with nonzero local cycle spans are a separate research question.
Support here requires **both endpoints** of every active edge to lie in one
closed one-ball. A bound on the **number** of active edges describes a
different subspace construction.

## Logical and metric scopes

The logical vocabulary has one binary undirected adjacency relation and
logical equality. Its formulas are unguarded first-order formulas over
vertices. There are no additional built-in relation, constant, or function
symbols. Atoms have quantifier rank zero, negation preserves rank, binary
Boolean connectives take the maximum, and existential binding adds one.
`RankEquivalent G H r` means the two structures agree on every closed
sentence with quantifier rank at most `r`. The finite-cycle witnesses use an
explicit rank-indexed back-and-forth argument with bounded displacements.

The radius minimax problem instead observes a multiset of rooted induced
graph neighborhoods, with one entry per vertex. Its target is the
**unconditional** Shannon entropy of the uniform law on the graph
incidence kernel over the finite field. The radius parameter is a graph
distance, independently of the quantifier rank in the logical separation.
For total order `N` and minimum cycle length `L`, the attained error is
`(floor(N/L)-1) * log(|K|) / 2` when `N ≥ L ≥ max(3, 2*r+2)`.

The bounded-displacement argument belongs to classical finite-model locality
and EF methods. Hanf's work is the source of neighborhood-count locality.
Gaifman gives the complementary locality framework for first-order
formulas. Fagin, Stockmeyer, and Vardi adapt Hanf's method to finite
structures and discuss graph connectivity. Libkin gives a standard account
of these approaches. The witnesses here are cycles and the argument uses
elementary cyclic displacements. The formalization establishes the stated
scope without a priority claim or external endorsement.

- William Hanf, “Model-Theoretic Methods in the Study of Elementary Logic,”
  in *The Theory of Models*, edited by J. W. Addison, L. Henkin, and A. Tarski,
  North-Holland, 1965, pp. 132–145. [Publisher volume](https://www.sciencedirect.com/science/book/9780720422337)
- Haim Gaifman, “On Local and Non-Local Properties,” *Logic Colloquium ’81*,
  North-Holland, 1982, pp. 105–135. [Publisher DOI](https://doi.org/10.1016/S0049-237X(08)71879-2)
- Ronald Fagin, Larry J. Stockmeyer, and Moshe Y. Vardi, “On Monadic NP vs
  Monadic co-NP,” *Information and Computation* 120(1), 1995, pp. 78–92.
  [Publisher article](https://www.sciencedirect.com/science/article/pii/S0890540185711005)
- Leonid Libkin, *Elements of Finite Model Theory*, Springer, 2004, chapter 4.
  [Publisher book](https://link.springer.com/book/10.1007/978-3-662-07003-1)

## Replay

Run from the repository root using the committed manifest.

```sh
sha256sum -c research/certificates/logical-entropy/source.sha256
lake build FMT CslibFmt
lake env lean --root=research/certificates/logical-entropy research/certificates/logical-entropy/Audit.lean > audit.log
python3 research/certificates/logical-entropy/check_axioms.py research/certificates/logical-entropy/Audit.lean audit.log
```
