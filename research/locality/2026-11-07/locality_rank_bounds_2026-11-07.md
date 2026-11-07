# Rank-indexed EF locality for one finite relational structure

**Research status (2026-11-07):** mathematical derivations only; **NOT Lean-verified**. Draft research artifact on a separate GitHub research branch; not a Lean-verified theorem or a merge recommendation. Classical Gaifman locality is already known; no novelty assertion is made.

## Setting

Let `M` be a *finite* relational structure over any relational signature with finite arities, and let `a,b` be tuples of equal length in the **same** structure. Let `N_r(a)` denote the induced Gaifman distance-at-most-`r` neighborhood with roots distinguished pointwise. `N_r(a) ≅ N_r(b)` means a root-preserving isomorphism of the complete induced relational structures, not merely a graph isomorphism if there are other relation symbols. Let `EF_q(a,b)` denote `q`-round back-and-forth equivalence with equality and all relation atoms, exactly as defined in CSLIB-FMT.

## Elementary finite counting lemma

Let `A,B ⊆ M` and `e : A ≃ B` preserve a predicate `P` on every element of `A`. If some `x ∈ P` lies outside `A`, there must be `y ∈ P` outside `B`, and conversely.

**Proof:** Suppose `P ⊆ B` but `x ∈ P\A`. Define the self-injection `s : P → P` by `s(z)=e^{-1}(z)`, well-defined because `P ⊆ B` and `e` preserves `P`. Finiteness forces surjectivity. Yet `x∉ A`, so no element maps to `x`, contradiction. The reverse direction applies `e^{-1}`. The argument requires only finiteness of `A` (and hence `B`); if `P ⊆ B` then `P` is automatically finite.

## Rank one: optimal radius 1

If `N_1(a) ≅ N_1(b)`, then `EF_1(a,b)` for the same finite structure. Move inside the root neighborhood via the isomorphism. For an outside move `x`, use the finite counting lemma for the predicate `P_x(z) := ∀R, (R(z,…,z) ↔ R(x,…,x))`, which is preserved by the neighborhood isomorphism. Mixed tuples containing the outside element and a root cannot satisfy a relation: such a tuple would make the outside element Gaifman-adjacent to a root. The same argument works in both directions. This rank-one result remains true if the *rooted neighborhoods* are finite even when the ambient structure is infinite.

## Rank two: radius 3 suffices

Suppose `e:N_3(a)≅N_3(b)`.

* First move `x ∈ N_2(a)`: take `y=e(x)`. The whole pointed `N_1(a,x)` is contained in `N_3(a)`, and the restriction of `e` yields `N_1(a,x)≅N_1(b,y)`. Apply rank one.
* First move `x ∉ N_2(a)`: classify elements by pointed radius-one type `T_x(z) :⇔ N_1(z)≅N_1(x)`. For every `z∈N_2(a)`, the map `e` preserves its whole radius-one ball, so `T_x(z)↔T_x(e(z))`. Finite counting produces `y ∉N_2(b)` of type `T_x`, together with a pointed isomorphism `f:N_1(x)≅N_1(y)`. The root–x and root–y distances are ≥3. Thus `N_1(a)` and `N_1(x)` are disjoint, likewise on the target. Their union carries a *diagonal-type-preserving* bijection defined piecewise using `e` and `f`. The union map need not preserve **cross edges** between its two parts, and we do not claim that it does. It suffices for the one remaining EF round: the original marked roots and `x` have no mixed relation tuples; when the second move lies in either radius-one part, the relevant atomic tuples are preserved by `e` or `f`. If the second move lies outside both parts, finite counting matches its diagonal type outside the target union; mixed atoms with the marked elements are impossible. All equality atoms are preserved. The reverse Spoiler directions are symmetric.

Hence `N_3(a) ≅ N_3(b) → EF_2(a,b)` for finite M. Radius 2 is insufficient: the five-vertex directed-edge graph at edges `{0→1,0→2,1→3,1→4,3→0}` has isomorphic radius-2 rooted neighborhoods at 2 and 4 but not `EF_2` (user's Mac previously passed a small certificate; a second independent local Python implementation agreed).

## Generic recurrence: rank q+1 from rank q

Suppose that for every finite relational structure and all tuples, `N_s(a)≅N_s(b) → EF_q(a,b)` holds for some `s≥1`. Then `N_(3s+1)(a) ≅ N_(3s+1)(b) → EF_(q+1)(a,b)`.

Write `R=3s+1`, `d=2s+1` and let `e:N_R(a)≅N_R(b)`.

* If Spoiler picks `x∈N_d(a)`, match `y=e(x)`. Since every vertex of `N_s(x)` is within `d+s=R` of the original roots, `e` restricts to an isomorphism of the **combined** radius-s neighborhoods `N_s(a,x)≅N_s(b,y)`. By induction, `EF_q(a,x;b,y)`.
* If Spoiler picks `x∉N_d(a)`, apply finite counting to the predicate `T_x(z) :⇔ N_s(z)≅N_s(x)`. Its truth is preserved by `e` on `N_d(a)` because those entire radius-s balls lie in `N_R(a)`. Obtain `y∉N_d(b)` with `N_s(x)≅N_s(y)`. Since both marked new vertices are more than `2s+1` away from their original tuples, the induced unions `N_s(a)∪N_s(x)` and `N_s(b)∪N_s(y)` are **disjoint and have no cross relation tuples**: a crossing tuple would provide a Gaifman edge and a path of length ≤`s+1+s=2s+1`. Glue the restrictions of `e` and the chosen pointed isomorphism `N_s(x)≅N_s(y)` to obtain `N_s(a,x)≅N_s(b,y)`. Apply induction.

The other Spoiler direction is symmetric. For the root of length zero, the same reasoning works with empty neighborhoods.

**Corollary (finite same-structure EF locality):** With `R_1=1`, `R_2=3`, and `R_(q+1)=3R_q+1` for `q≥2`, every `q≥1` satisfies

`N_(R_q)(a) ≅ N_(R_q)(b)  → EF_q(a,b)`.

For `q≥2`, `R_q = (7*3^(q-2)-1)/2`, so `R_2=3`, `R_3=10`, `R_4=31`. This is an explicit, not necessarily optimal, locality radius. This does **not** assert a new proof of classical Gaifman locality, does not apply to arbitrary pairs of different structures without additional global-counting data, and is not a Lean proof.

## Lower bound for all q

For each `q≥1`, let `L=2^(q-1)`. Consider two disjoint directed paths of length L in the same finite graph; add a self-loop **only** at the first path's endpoint. Their initial vertices have isomorphic rooted radius-(L−1) neighborhoods.

Define `Walk_0(u,v):=E(u,v)`, and `Walk_(k+1)(u,v):=∃z (Walk_k(u,z)∧Walk_k(z,v))`. This has quantifier rank `k+1` and states the existence of a walk of length `2^(k+1)`. The rank-q formula `∃y (E(y,y)∧Walk_(q−1)(u,y))` distinguishes the two roots. Hence any uniform rank-q locality radius is at least `2^(q−1)` for directed graphs with loops. For `q=2`, the explicit five-vertex radius-2 separator strengthens the lower bound from 2 to 3, proving radius-three optimal at rank two.

For `q=3`, the path example uses 10 vertices and edges `0→1→2→3→4`, `5→6→7→8→9`, and loop `4→4`. A direct evaluation of the rank-three formula gives `True` at root 0, `False` at root 5. An independent exact recursive EF-type audit returned `EF_2=True`, `EF_3=False`, and radius-three isomorphism `True`.

## Status and unresolved obligation

- `MATHEMATICAL_DERIVATION := COMPLETE` for the claims above, subject to independent review.
- `LEAN_VERIFIED := NO` for new all-rank theorem and finite counting lemma.
- `MAC_MATHLIB_IMPORT := INCOMPLETE_TIMEOUT`; no new build initiated.
- `REPOSITORY_SCOPE := research branch only; main unchanged; no promotion of these drafts`.
- `FORMALIZATION_BLOCKER := construct and verify finite type matching + ball transport + disjoint-union relation preservation`.

The supplied standalone abstract counting file is `FiniteNeighborhoodOutside.lean` (SHA-256 `0570d1fa44b159caadc43e46644dcc1c80a91540b2de48276e65ae41462466c3`), which remains **uncompiled**.
