Zero-One Law 0-Ary Relation Negative-Boundary Receipt — 2026-07-05
Status
ZERO_ARY_RELATION_NEGATIVE_BOUNDARY_RECEIPT_RECORDED
Counterexample
Let the vocabulary be:
L = {P}
arity(P) = 0
Let the sentence be:
phi = P
A 0-ary relation symbol is a sentence-level Boolean parameter. Under the independent Bernoulli random model, P is true with probability 1/2 and false with probability 1/2.
Therefore, for every n:
Pr[A_n satisfies P] = 1/2
So:
lim_n Pr[A_n satisfies P] = 1/2
But:
1/2 not in {0,1}
Consequence
The positive-arity condition in the structural 0-1 law receipt is necessary.
The admissible theorem surface must exclude random 0-ary relation symbols, or else treat them deterministically outside the random relation-tuple model.
Boundary
This receipt does not claim:
0-1 law for random 0-ary relation symbols
global vocabulary closure
Lean-formal counterexample theorem closure
claim about deterministic 0-ary symbols
