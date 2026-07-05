# Zero-One Law Back-and-Forth Completeness Receipt — 2026-07-05

## Status

`T_EXT_COMPLETENESS_BACK_AND_FORTH_RECEIPT_RECORDED`

## Scope

This receipt records the structural completeness argument for the extension theory `T_ext` used in the classical finite-relational first-order 0-1 law.

The surface is restricted to:

```text
finite relational vocabularies
positive arity relation symbols
first-order logic with equality
complete one-point extension axioms
countable models of T_ext
Back-and-forth object
Let M and N be countable models of T_ext.
A finite partial isomorphism is a finite injective map
f : A -> B
where A subset M, B subset N, and all relation facts among tuples from A are preserved and reflected by f.
Forward step

This is the forward extension step.
Given a finite partial isomorphism f : A -> B and an element a in M:
if a in A:
  f already covers a
else:
  record the complete signed atomic one-point type of a over A
  transport that type along f to B
  use the matching extension axiom in N
  choose b in N \ B realizing the transported type
  extend f by a |-> b
The extended map remains a finite partial isomorphism because the one-point type is complete over all relation atoms involving the new element.
Backward step
The same argument applies with M and N exchanged.
Given b in N, the extension axioms in M produce a fresh matching preimage.
Countable construction
Enumerate:
M = {m_0, m_1, ...}
N = {n_0, n_1, ...}
Alternate forward and backward steps:
cover m_0
cover n_0
cover m_1
cover n_1
...
The union of the resulting chain of finite partial isomorphisms is a total isomorphism:
M ≅ N
Completeness consequence
Since any two countable models of T_ext are isomorphic, T_ext is countably categorical.
The completeness surface recorded here is:
for every first-order sentence phi,
T_ext proves phi or T_ext proves not phi
Boundary
This receipt does not claim:
Lean-formal T_ext completeness theorem closure
Lean-formal Fagin theorem closure
global finite-model-theory closure
0-1 law for 0-ary relation symbols
0-1 law for vocabularies with functions or constants
