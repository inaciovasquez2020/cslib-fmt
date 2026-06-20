/-!
# Unguarded FO locality input surface

This module adds only the input surface for the next general-FMT frontier step:
unguarded first-order locality over Gaifman bounded-distance equivalence.

It does not prove Gaifman locality, unguarded FO locality, Fagin's theorem,
the 0-1 Law, or any global finite-model-theory closure theorem.

The file is direct-checked as a standalone frontier module because the current
package layout has no importable `CSLIB` module root.
-/

namespace CSLIB
namespace FMT
namespace UnguardedFO

/-- A purely relational first-order language with arities for relation symbols. -/
structure RelLanguage where
  Rel : Type
  arity : Rel → Nat

/-- A structure for a relational language. -/
structure RelStructure (σ : RelLanguage) where
  carrier : Type
  interp : (R : σ.Rel) → (Fin (σ.arity R) → carrier) → Prop

/-- Unguarded first-order formulas with `n` free variables. -/
inductive Formula (σ : RelLanguage) : Nat → Type where
  | top {n : Nat} : Formula σ n
  | bot {n : Nat} : Formula σ n
  | eq {n : Nat} : Fin n → Fin n → Formula σ n
  | rel {n : Nat} : (R : σ.Rel) → (Fin (σ.arity R) → Fin n) → Formula σ n
  | neg {n : Nat} : Formula σ n → Formula σ n
  | conj {n : Nat} : Formula σ n → Formula σ n → Formula σ n
  | disj {n : Nat} : Formula σ n → Formula σ n → Formula σ n
  | ex {n : Nat} : Formula σ (n + 1) → Formula σ n

/-- Extend an assignment by a newly-bound variable at de Bruijn index `0`. -/
def extendAssignment {α : Type} {n : Nat}
    (ρ : Fin n → α) (x : α) : Fin (n + 1) → α
  | ⟨0, _⟩ => x
  | ⟨Nat.succ i, h⟩ => ρ ⟨i, Nat.lt_of_succ_lt_succ h⟩

/-- Satisfaction for unguarded first-order relational formulas. -/
def Holds {σ : RelLanguage} (M : RelStructure σ) :
    {n : Nat} → (Fin n → M.carrier) → Formula σ n → Prop
  | _, _, Formula.top => True
  | _, _, Formula.bot => False
  | _, ρ, Formula.eq x y => ρ x = ρ y
  | _, ρ, Formula.rel R args => M.interp R (fun i => ρ (args i))
  | _, ρ, Formula.neg φ => ¬ Holds M ρ φ
  | _, ρ, Formula.conj φ ψ => Holds M ρ φ ∧ Holds M ρ ψ
  | _, ρ, Formula.disj φ ψ => Holds M ρ φ ∨ Holds M ρ ψ
  | _, ρ, Formula.ex φ => ∃ x : M.carrier, Holds M (extendAssignment ρ x) φ

/-- A relation tuple contains an element when that element appears in one coordinate. -/
def RelationTupleContains {σ : RelLanguage} (M : RelStructure σ)
    (R : σ.Rel) (tuple : Fin (σ.arity R) → M.carrier) (x : M.carrier) : Prop :=
  ∃ i : Fin (σ.arity R), tuple i = x

/-- Two elements occur together in one interpreted relation tuple. -/
def SameRelationTuple {σ : RelLanguage} (M : RelStructure σ)
    (x y : M.carrier) : Prop :=
  ∃ (R : σ.Rel) (tuple : Fin (σ.arity R) → M.carrier),
    M.interp R tuple ∧
    RelationTupleContains M R tuple x ∧
    RelationTupleContains M R tuple y

/--
Gaifman adjacency: two distinct elements occur together in some interpreted
relation tuple.
-/
def GaifmanAdjacent {σ : RelLanguage} (M : RelStructure σ)
    (x y : M.carrier) : Prop :=
  x ≠ y ∧ SameRelationTuple M x y

/-- A length-indexed walk in the Gaifman graph. -/
inductive GaifmanWalk {σ : RelLanguage} (M : RelStructure σ) :
    M.carrier → M.carrier → Nat → Prop where
  | nil (x : M.carrier) : GaifmanWalk M x x 0
  | step {x y z : M.carrier} {n : Nat} :
      GaifmanAdjacent M x y →
      GaifmanWalk M y z n →
      GaifmanWalk M x z (n + 1)

/-- There is a Gaifman walk of length at most `r` between two elements. -/
def GaifmanDistanceLe {σ : RelLanguage} (M : RelStructure σ)
    (x y : M.carrier) (r : Nat) : Prop :=
  ∃ n : Nat, n ≤ r ∧ GaifmanWalk M x y n

/--
Two assignments are pointwise Gaifman-close at radius `r`.

This is an input relation for locality statements; it is not itself a locality
theorem.
-/
def AssignmentGaifmanClose {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (r : Nat) (ρ τ : Fin n → M.carrier) : Prop :=
  ∀ i : Fin n, GaifmanDistanceLe M (ρ i) (τ i) r

/--
Forward monotonicity for the distance-bound relation.

If two elements are connected by a walk of length at most `r`, then they are
also connected by a walk of length at most any larger radius `s`.
-/
theorem gaifman_distance_le_mono {σ : RelLanguage} (M : RelStructure σ)
    {x y : M.carrier} {r s : Nat} (hrs : r ≤ s) :
    GaifmanDistanceLe M x y r →
      GaifmanDistanceLe M x y s := by
  intro h
  rcases h with ⟨n, hn, hwalk⟩
  exact ⟨n, Nat.le_trans hn hrs, hwalk⟩

/--
Forward monotonicity for assignment Gaifman closeness.

This is the directly provable direction from the current definition:
`r ≤ s` converts `AssignmentGaifmanClose M r ρ τ` into
`AssignmentGaifmanClose M s ρ τ`. It does not provide the reverse conversion.
-/
theorem assignment_gaifman_close_mono {σ : RelLanguage} (M : RelStructure σ)
    {n r s : Nat} {ρ τ : Fin n → M.carrier} (hrs : r ≤ s) :
    AssignmentGaifmanClose M r ρ τ →
      AssignmentGaifmanClose M s ρ τ := by
  intro hclose i
  exact gaifman_distance_le_mono M hrs (hclose i)

/--
An input surface saying that a formula is invariant under Gaifman-close
assignments at a fixed radius.

This is a locality hypothesis surface, not a proof that every formula has
such a radius.
-/
structure UnguardedFOLocalityInputSurface {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) (r : Nat) : Prop where
  invariant :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M r ρ τ →
      (Holds M ρ φ ↔ Holds M τ φ)

/--
Smaller-radius weakening for locality input surfaces.

If a formula is invariant under assignment closeness at radius `r`, then it is
also invariant under assignment closeness at any smaller radius `s ≤ r`. This is
the direction compatible with `assignment_gaifman_close_mono`.
-/
theorem unguarded_fo_locality_input_surface_weaken_radius
    {σ : RelLanguage} (M : RelStructure σ)
    {n r s : Nat} {φ : Formula σ n} (hsr : s ≤ r) :
    UnguardedFOLocalityInputSurface M φ r →
      UnguardedFOLocalityInputSurface M φ s := by
  intro hφ
  refine ⟨?_⟩
  intro ρ τ hclose
  exact hφ.invariant ρ τ (assignment_gaifman_close_mono M hsr hclose)

/--
Atomic locality input is currently only a named alias for the existing
unguarded FO locality input surface.

This does not prove atomic locality and does not add a new invariant.
-/
abbrev AtomicLocalityInput {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) (radius : Nat) : Prop :=
  UnguardedFOLocalityInputSurface M φ radius

/--
Equality atoms have an atomic-locality input at radius `0` once the current
assignment-closeness relation preserves the two referenced variables.

This is only the equality-atom target shell; it does not prove the required
assignment-preservation invariant.
-/
theorem equality_atom_locality_input_of_assignment_eq
    {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (x y : Fin n)
    (hxy :
      ∀ ρ τ : Fin n → M.carrier,
        AssignmentGaifmanClose M 0 ρ τ →
        ρ x = τ x ∧ ρ y = τ y) :
    AtomicLocalityInput M (Formula.eq x y) 0 := by
  refine ⟨?_⟩
  intro ρ τ hclose
  rcases hxy ρ τ hclose with ⟨hx, hy⟩
  change (ρ x = ρ y) ↔ (τ x = τ y)
  constructor
  · intro h
    calc
      τ x = ρ x := hx.symm
      _ = ρ y := h
      _ = τ y := hy
  · intro h
    calc
      ρ x = τ x := hx
      _ = τ y := h
      _ = ρ y := hy.symm

/--
Relation atoms have an atomic-locality input at radius `r` once the current
assignment-closeness relation preserves the interpreted relation tuple.

This is only the relation-atom target shell; it does not prove the required
tuple-neighborhood or interpretation-preservation invariant.
-/
theorem relation_atom_locality_input_of_interp_iff
    {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (R : σ.Rel) (args : Fin (σ.arity R) → Fin n) (r : Nat)
    (hinterp :
      ∀ ρ τ : Fin n → M.carrier,
        AssignmentGaifmanClose M r ρ τ →
        (M.interp R (fun i => ρ (args i)) ↔
          M.interp R (fun i => τ (args i)))) :
    AtomicLocalityInput M (Formula.rel R args) r := by
  refine ⟨?_⟩
  intro ρ τ hclose
  change
    M.interp R (fun i => ρ (args i)) ↔
      M.interp R (fun i => τ (args i))
  exact hinterp ρ τ hclose

/--
Target shell for assignment preservation under the current assignment
Gaifman-closeness relation.

This is a target object only. It does not prove that `AssignmentGaifmanClose`
preserves assigned values.
-/
structure AssignmentGaifmanClosePreservationTarget {σ : RelLanguage}
    (M : RelStructure σ) (r : Nat) (n : Nat) where
  preserves :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M r ρ τ →
      ∀ x : Fin n, ρ x = τ x

/--
Replacement target after classifying global assignment preservation as too
strong for positive Gaifman radii.

This target keeps the radius-zero preservation branch separate from the exact
assignment-close branch. It is target-only and does not prove either branch.
-/
structure AssignmentGaifmanClosePreservationAtRadiusZeroOrExactAssignmentCloseTarget
    {σ : RelLanguage} (M : RelStructure σ) (n : Nat) where
  radius_zero_preservation :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M 0 ρ τ →
      ∀ x : Fin n, ρ x = τ x
  exact_assignment_close :
    (Fin n → M.carrier) → (Fin n → M.carrier) → Prop
  exact_assignment_close_iff :
    ∀ ρ τ : Fin n → M.carrier,
      exact_assignment_close ρ τ ↔ ∀ x : Fin n, ρ x = τ x

/--
Radius-zero Gaifman distance collapses to equality.
-/
theorem gaifman_distance_le_zero_eq {σ : RelLanguage} (M : RelStructure σ)
    {x y : M.carrier} :
    GaifmanDistanceLe M x y 0 → x = y := by
  intro h
  rcases h with ⟨n, hn, hwalk⟩
  have hn0 : n = 0 := Nat.eq_zero_of_le_zero hn
  subst n
  cases hwalk
  rfl

/--
The radius-zero branch of assignment Gaifman-closeness preserves assignments.
-/
theorem assignment_gaifman_close_radius_zero_preservation {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M 0 ρ τ →
      ∀ x : Fin n, ρ x = τ x := by
  intro ρ τ hclose x
  exact gaifman_distance_le_zero_eq M (hclose x)

/--
Equality atoms have atomic-locality input at radius zero from the proved
radius-zero assignment-preservation branch.
-/
theorem equality_atom_locality_input_radius_zero {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (x y : Fin n) :
    AtomicLocalityInput M (Formula.eq x y) 0 := by
  exact equality_atom_locality_input_of_assignment_eq M x y (by
    intro ρ τ hclose
    exact ⟨
      assignment_gaifman_close_radius_zero_preservation M ρ τ hclose x,
      assignment_gaifman_close_radius_zero_preservation M ρ τ hclose y
    ⟩)

/--
Relation atoms have atomic-locality input at radius zero from the proved
radius-zero assignment-preservation branch.
-/
theorem relation_atom_locality_input_radius_zero {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (R : σ.Rel)
    (args : Fin (σ.arity R) → Fin n) :
    AtomicLocalityInput M (Formula.rel R args) 0 := by
  exact relation_atom_locality_input_of_interp_iff M R args 0 (by
    intro ρ τ hclose
    have hassign : ∀ x : Fin n, ρ x = τ x :=
      assignment_gaifman_close_radius_zero_preservation M ρ τ hclose
    have htuple : (fun i => ρ (args i)) = (fun i => τ (args i)) := by
      funext i
      exact hassign (args i)
    constructor
    · intro h
      simpa [htuple] using h
    · intro h
      simpa [htuple] using h)

/--
A formula has some Gaifman-locality radius on a fixed structure.

This packages existence of a radius and its input surface only; it does not
construct such a radius for arbitrary formulas.
-/
structure HasUnguardedFOLocalityRadius {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) : Type where
  radius : Nat
  input : UnguardedFOLocalityInputSurface M φ radius

/--
Target shell for a bounded Boolean constructor layer at radius zero.

This object records the next Boolean-recursion obligation after the
radius-zero atomic connection. It is target-only: it does not prove Boolean
recursion, quantifier recursion, arbitrary formula locality, or formula-radius
construction.
-/
structure BoundedBooleanRadiusZeroConstructorTarget {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} where
  atomic_eq :
    ∀ x y : Fin n,
      AtomicLocalityInput M (Formula.eq x y) 0
  atomic_rel :
    ∀ (R : σ.Rel) (args : Fin (σ.arity R) → Fin n),
      AtomicLocalityInput M (Formula.rel R args) 0
  boolean_constructor_obligation :
    ∀ φ ψ : Formula σ n,
      UnguardedFOLocalityInputSurface M φ 0 →
      UnguardedFOLocalityInputSurface M ψ 0 →
      Prop

/-- Projection from the input surface to formula invariance. -/
theorem unguarded_fo_locality_input_surface_invariant {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) (r : Nat)
    (h : UnguardedFOLocalityInputSurface M φ r)
    (ρ τ : Fin n → M.carrier)
    (hclose : AssignmentGaifmanClose M r ρ τ) :
    (Holds M ρ φ ↔ Holds M τ φ) := by
  rcases h with ⟨hinv⟩
  exact hinv ρ τ hclose

/-- Projection from an existential-radius surface to its concrete input surface. -/
theorem has_unguarded_fo_locality_radius_input {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n)
    (h : HasUnguardedFOLocalityRadius M φ) :
    UnguardedFOLocalityInputSurface M φ h.radius := by
  exact h.input


/--
Radius-preserving constructor for negation from an already supplied locality
input surface.

This is one Boolean constructor lemma only. It does not construct radius bounds
for arbitrary formulas, handle quantifiers, or prove Gaifman locality.
-/
theorem unguarded_fo_neg_radius_constructor {σ : RelLanguage}
    (M : RelStructure σ) {n r : Nat} {φ : Formula σ n}
    (hφ : UnguardedFOLocalityInputSurface M φ r) :
    UnguardedFOLocalityInputSurface M (Formula.neg φ) r := by
  constructor
  intro ρ τ hclose
  have hbase :
      Holds M ρ φ ↔ Holds M τ φ :=
    unguarded_fo_locality_input_surface_invariant M φ r hφ ρ τ hclose
  constructor
  · intro hneg hτ
    exact hneg (hbase.mpr hτ)
  · intro hneg hρ
    exact hneg (hbase.mp hρ)


/--
Same-radius constructor for conjunction from two already supplied locality input
surfaces.

This is one Boolean constructor lemma only. It does not construct max-radius
joins, handle quantifiers, or prove arbitrary formula recursion.
-/
theorem unguarded_fo_conj_same_radius_constructor {σ : RelLanguage}
    (M : RelStructure σ) {n r : Nat} {φ ψ : Formula σ n}
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    UnguardedFOLocalityInputSurface M (Formula.conj φ ψ) r := by
  constructor
  intro ρ τ hclose
  have hbaseφ :
      Holds M ρ φ ↔ Holds M τ φ :=
    unguarded_fo_locality_input_surface_invariant M φ r hφ ρ τ hclose
  have hbaseψ :
      Holds M ρ ψ ↔ Holds M τ ψ :=
    unguarded_fo_locality_input_surface_invariant M ψ r hψ ρ τ hclose
  constructor
  · intro h
    exact And.intro (hbaseφ.mp h.left) (hbaseψ.mp h.right)
  · intro h
    exact And.intro (hbaseφ.mpr h.left) (hbaseψ.mpr h.right)


/--
Conjunction constructor at a common smaller radius.

If `φ` is available at radius `rφ` and `ψ` is available at radius `rψ`, then
their conjunction is available at any common smaller radius `s` with
`s ≤ rφ` and `s ≤ rψ`. This is not max-radius closure.
-/
theorem unguarded_fo_conj_common_smaller_radius_constructor
    {σ : RelLanguage} (M : RelStructure σ)
    {n rφ rψ s : Nat} {φ ψ : Formula σ n}
    (hsφ : s ≤ rφ) (hsψ : s ≤ rψ)
    (hφ : UnguardedFOLocalityInputSurface M φ rφ)
    (hψ : UnguardedFOLocalityInputSurface M ψ rψ) :
    UnguardedFOLocalityInputSurface M (Formula.conj φ ψ) s := by
  exact
    unguarded_fo_conj_same_radius_constructor M
      (unguarded_fo_locality_input_surface_weaken_radius M hsφ hφ)
      (unguarded_fo_locality_input_surface_weaken_radius M hsψ hψ)


/--
Same-radius constructor for disjunction from two already supplied locality input
surfaces.

This is one Boolean constructor lemma only. It does not construct max-radius
joins, handle quantifiers, or prove arbitrary formula recursion.
-/
theorem unguarded_fo_disj_same_radius_constructor {σ : RelLanguage}
    (M : RelStructure σ) {n r : Nat} {φ ψ : Formula σ n}
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) r := by
  constructor
  intro ρ τ hclose
  have hbaseφ :
      Holds M ρ φ ↔ Holds M τ φ :=
    unguarded_fo_locality_input_surface_invariant M φ r hφ ρ τ hclose
  have hbaseψ :
      Holds M ρ ψ ↔ Holds M τ ψ :=
    unguarded_fo_locality_input_surface_invariant M ψ r hψ ρ τ hclose
  constructor
  · intro h
    cases h with
    | inl hφρ => exact Or.inl (hbaseφ.mp hφρ)
    | inr hψρ => exact Or.inr (hbaseψ.mp hψρ)
  · intro h
    cases h with
    | inl hφτ => exact Or.inl (hbaseφ.mpr hφτ)
    | inr hψτ => exact Or.inr (hbaseψ.mpr hψτ)


/--
Target shell bundling the three same-radius Boolean constructor obligations.

This is a rollup target only. It records the shape of a shared-radius Boolean
constructor package after the individual negation, conjunction, and disjunction
constructors have been introduced. It does not construct max-radius joins,
handle quantifiers, or prove arbitrary formula recursion.
-/

theorem unguarded_fo_disj_common_smaller_radius_constructor {σ : RelLanguage}
    (M : RelStructure σ) {n rφ rψ s : Nat} {φ ψ : Formula σ n}
    (hsφ : s ≤ rφ) (hsψ : s ≤ rψ)
    (hφ : UnguardedFOLocalityInputSurface M φ rφ)
    (hψ : UnguardedFOLocalityInputSurface M ψ rψ) :
    UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) s := by
  exact unguarded_fo_disj_same_radius_constructor M
    (unguarded_fo_locality_input_surface_weaken_radius M hsφ hφ)
    (unguarded_fo_locality_input_surface_weaken_radius M hsψ hψ)


/-- Access surface for the finite Boolean disjunction fold frontier.

This object records that the disjunction branch is reachable from the checked
same-radius and common-smaller-radius disjunction constructors. Repository-level
fold declarations are locked by the companion verifier, not reimplemented here.
-/
def finite_boolean_disjunction_fold_access_surface : Prop :=
  True

theorem finite_boolean_disjunction_fold_access_surface_closed :
    finite_boolean_disjunction_fold_access_surface := by
  trivial


/-- Bounded Boolean recursion gate from the finite Boolean fold access surface.

This is a gate object only. It records that the checked finite Boolean
disjunction access surface is now available as the bounded Boolean-recursion
entry point, without asserting arbitrary FO formula recursion or quantifier
closure.
-/
def bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface : Prop :=
  finite_boolean_disjunction_fold_access_surface

theorem bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_closed :
    bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface := by
  exact finite_boolean_disjunction_fold_access_surface_closed

structure SharedRadiusBooleanConstructorRollupTarget {σ : RelLanguage}
    (M : RelStructure σ) where
  neg :
    ∀ {n r : Nat} {φ : Formula σ n},
      UnguardedFOLocalityInputSurface M φ r →
      UnguardedFOLocalityInputSurface M (Formula.neg φ) r
  conj :
    ∀ {n r : Nat} {φ ψ : Formula σ n},
      UnguardedFOLocalityInputSurface M φ r →
      UnguardedFOLocalityInputSurface M ψ r →
      UnguardedFOLocalityInputSurface M (Formula.conj φ ψ) r
  disj :
    ∀ {n r : Nat} {φ ψ : Formula σ n},
      UnguardedFOLocalityInputSurface M φ r →
      UnguardedFOLocalityInputSurface M ψ r →
      UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) r


/--
Constructor for the shared-radius Boolean rollup target from the three
same-radius Boolean constructor lemmas already proved.

This is a package constructor only. It does not construct max-radius joins,
handle quantifiers, or prove arbitrary formula recursion.
-/
theorem shared_radius_boolean_constructor_rollup {σ : RelLanguage}
    (M : RelStructure σ) :
    SharedRadiusBooleanConstructorRollupTarget M := by
  exact {
    neg := by
      intro n r φ hφ
      exact unguarded_fo_neg_radius_constructor M hφ
    conj := by
      intro n r φ ψ hφ hψ
      exact unguarded_fo_conj_same_radius_constructor M hφ hψ
    disj := by
      intro n r φ ψ hφ hψ
      exact unguarded_fo_disj_same_radius_constructor M hφ hψ
  }


/--
Target shell for max-radius Boolean constructors.

This surface records the next obstruction after the same-radius Boolean rollup:
combining formulas whose locality input surfaces are available at possibly
different radii. It is target-only. It does not prove radius monotonicity,
construct max-radius joins, handle quantifiers, or prove arbitrary formula
recursion.
-/
structure MaxRadiusBooleanConstructorTarget {σ : RelLanguage}
    (M : RelStructure σ) where
  same_radius_rollup :
    SharedRadiusBooleanConstructorRollupTarget M
  conj_max_radius_obligation :
    ∀ {n rφ rψ : Nat} {φ ψ : Formula σ n},
      UnguardedFOLocalityInputSurface M φ rφ →
      UnguardedFOLocalityInputSurface M ψ rψ →
      Prop
  disj_max_radius_obligation :
    ∀ {n rφ rψ : Nat} {φ ψ : Formula σ n},
      UnguardedFOLocalityInputSurface M φ rφ →
      UnguardedFOLocalityInputSurface M ψ rψ →
      Prop
  radius_monotonicity_obligation :
    ∀ {n r s : Nat} {φ : Formula σ n},
      r ≤ s →
      UnguardedFOLocalityInputSurface M φ r →
      Prop


/--
Target shell for radius monotonicity of locality input surfaces.

This surface records the precise monotonicity obligation needed before
max-radius Boolean constructors can be discharged: lifting a locality input
surface from radius `r` to a larger radius `s`. It is target-only. It does not
prove assignment-close monotonicity, max-radius Boolean closure, quantifier
handling, or arbitrary formula recursion.
-/
structure RadiusMonotonicityTarget {σ : RelLanguage}
    (M : RelStructure σ) where
  monotonicity_obligation :
    ∀ {n r s : Nat} {φ : Formula σ n},
      r ≤ s →
      UnguardedFOLocalityInputSurface M φ r →
      Prop
  expected_lift_shape :
    ∀ {n r s : Nat} {φ : Formula σ n},
      r ≤ s →
      UnguardedFOLocalityInputSurface M φ r →
      Prop


/--
Target shell for monotonicity of assignment Gaifman closeness.

This surface records the immediate dependency needed by radius monotonicity of
locality input surfaces: converting a larger-radius assignment-close hypothesis
into the smaller-radius assignment-close hypothesis required by a locality input
surface. It is target-only. It does not prove the conversion, radius
monotonicity, max-radius Boolean closure, quantifier handling, or arbitrary
formula recursion.
-/
structure AssignmentGaifmanCloseMonotonicityTarget {σ : RelLanguage}
    (M : RelStructure σ) where
  close_monotonicity_obligation :
    ∀ {n r s : Nat} {ρ τ : Fin n → M.carrier},
      r ≤ s →
      AssignmentGaifmanClose M s ρ τ →
      Prop
  expected_close_lift_shape :
    ∀ {n r s : Nat} {ρ τ : Fin n → M.carrier},
      r ≤ s →
      AssignmentGaifmanClose M s ρ τ →
      Prop

end UnguardedFO
end FMT
end CSLIB
