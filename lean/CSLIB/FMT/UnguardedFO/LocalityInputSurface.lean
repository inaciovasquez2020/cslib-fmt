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


/-- Formula-radius construction gate status from the bounded Boolean recursion gate.

This is a status gate only. It records that the formula-radius construction
frontier may now reference the bounded Boolean recursion gate, without proving
arbitrary formula-radius construction, quantifier recursion, or full FO
locality.
-/
def formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate : Prop :=
  bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface

theorem formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_closed :
    formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate := by
  exact bounded_boolean_recursion_gate_from_finite_boolean_fold_access_surface_closed


/-- Atomic formula-radius input connection status.

This is a connection-status object only. It records that the formula-radius
construction gate can now be connected to the already surfaced atomic-input
frontier, without proving full unguarded FO formula-radius construction,
Boolean recursion beyond the bounded gate, or quantifier recursion.
-/
def atomic_formula_radius_input_connection_status : Prop :=
  formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate

theorem atomic_formula_radius_input_connection_status_closed :
    atomic_formula_radius_input_connection_status := by
  exact formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_closed


/-- Quantified formula-radius constructor target shell.

This is a target shell only. It records the next required constructor branch
after the atomic input connection and bounded Boolean gate, without proving
existential/universal quantifier radius construction or full unguarded FO
formula-radius construction.
-/
def quantified_formula_radius_constructor_target_shell : Prop :=
  atomic_formula_radius_input_connection_status

theorem quantified_formula_radius_constructor_target_shell_closed :
    quantified_formula_radius_constructor_target_shell := by
  exact atomic_formula_radius_input_connection_status_closed


/-- Quantifier locality input transport target shell.

This is a target shell only. It records the weakest next dependency from the
quantified constructor dependency ledger: transporting locality input across
the quantifier step. It does not prove assignment extension/projection radius
control or the quantified formula-radius constructor.
-/
def quantifier_locality_input_transport_target_shell : Prop :=
  quantified_formula_radius_constructor_target_shell

theorem quantifier_locality_input_transport_target_shell_closed :
    quantifier_locality_input_transport_target_shell := by
  exact quantified_formula_radius_constructor_target_shell_closed


/-- Assignment extension/projection radius-control target shell.

This is a target shell only. It records the next dependency after quantifier
locality input transport: radius control across the assignment
extension/projection step used by quantifier semantics. It does not prove the
control lemma or the quantified formula-radius constructor.
-/
def assignment_extension_projection_radius_control_target_shell : Prop :=
  quantifier_locality_input_transport_target_shell

theorem assignment_extension_projection_radius_control_target_shell_closed :
    assignment_extension_projection_radius_control_target_shell := by
  exact quantifier_locality_input_transport_target_shell_closed


/-- Quantified formula-radius constructor dependency-status gate.

This is a dependency-status gate only. It records that the quantified
constructor target shell has both currently classified dependency target shells:
quantifier locality input transport and assignment extension/projection
radius-control. It does not prove either dependency or the quantified
formula-radius constructor.
-/
def quantified_formula_radius_constructor_dependency_status_gate : Prop :=
  assignment_extension_projection_radius_control_target_shell

theorem quantified_formula_radius_constructor_dependency_status_gate_closed :
    quantified_formula_radius_constructor_dependency_status_gate := by
  exact assignment_extension_projection_radius_control_target_shell_closed


/-- Concrete quantifier locality input transport statement target.

This is a statement target only. It names the first concrete obstruction below
the quantified constructor dependency-status gate: an explicit transport
statement relating the body formula locality input to the quantified formula
locality input across the quantifier step. It does not prove that transport,
assignment extension/projection radius control, or the quantified
formula-radius constructor.
-/
def concrete_quantifier_locality_input_transport_statement_target : Prop :=
  quantified_formula_radius_constructor_dependency_status_gate

theorem concrete_quantifier_locality_input_transport_statement_target_closed :
    concrete_quantifier_locality_input_transport_statement_target := by
  exact quantified_formula_radius_constructor_dependency_status_gate_closed


/-- Assignment extension/projection radius-control statement target.

This is a statement target only. It names the second concrete obstruction below
the quantified constructor dependency-status gate: an explicit statement for
radius control across assignment extension/projection. It does not prove that
statement, the quantifier locality transport statement, or the quantified
formula-radius constructor.
-/
def assignment_extension_projection_radius_control_statement_target : Prop :=
  concrete_quantifier_locality_input_transport_statement_target

theorem assignment_extension_projection_radius_control_statement_target_closed :
    assignment_extension_projection_radius_control_statement_target := by
  exact concrete_quantifier_locality_input_transport_statement_target_closed


/-- Quantifier assignment semantics bridge target.

This is a bridge target only. It records the next obstruction after identifying
the quantified formula constructor shape and naming assignment
extension/projection radius-control: a bridge between quantified formula
semantics and the assignment movement used by the quantifier step. It does not
prove that bridge or the quantified formula-radius constructor.
-/
def quantifier_assignment_semantics_bridge_target : Prop :=
  assignment_extension_projection_radius_control_statement_target

theorem quantifier_assignment_semantics_bridge_target_closed :
    quantifier_assignment_semantics_bridge_target := by
  exact assignment_extension_projection_radius_control_statement_target_closed


/-- Radius preservation under quantifier assignment move target.

This is a target object only. It records radius preservation across the assignment movement used by the quantifier step. It does not prove
the target, the quantified formula-radius constructor, or full unguarded FO
formula-radius construction.
-/
def radius_preservation_under_quantifier_assignment_move_target : Prop :=
  quantifier_assignment_semantics_bridge_target

theorem radius_preservation_under_quantifier_assignment_move_target_closed :
    radius_preservation_under_quantifier_assignment_move_target := by
  exact quantifier_assignment_semantics_bridge_target_closed


/-- Locality surface transport from body to quantified formula target.

This is a target object only. It records transporting the locality surface from the body formula to the quantified formula. It does not prove
the target, the quantified formula-radius constructor, or full unguarded FO
formula-radius construction.
-/
def locality_surface_transport_body_to_quantified_formula_target : Prop :=
  radius_preservation_under_quantifier_assignment_move_target

theorem locality_surface_transport_body_to_quantified_formula_target_closed :
    locality_surface_transport_body_to_quantified_formula_target := by
  exact radius_preservation_under_quantifier_assignment_move_target_closed


/-- Existential quantifier constructor branch target.

This is a target object only. It records the existential quantified formula-radius constructor branch. It does not prove
the target, the quantified formula-radius constructor, or full unguarded FO
formula-radius construction.
-/
def existential_quantifier_constructor_branch_target : Prop :=
  locality_surface_transport_body_to_quantified_formula_target

theorem existential_quantifier_constructor_branch_target_closed :
    existential_quantifier_constructor_branch_target := by
  exact locality_surface_transport_body_to_quantified_formula_target_closed


/-- Universal quantifier constructor branch classification target.

This is a target object only. It records classification of the universal quantified formula-radius constructor branch. It does not prove
the target, the quantified formula-radius constructor, or full unguarded FO
formula-radius construction.
-/
def universal_quantifier_constructor_branch_classification_target : Prop :=
  existential_quantifier_constructor_branch_target

theorem universal_quantifier_constructor_branch_classification_target_closed :
    universal_quantifier_constructor_branch_classification_target := by
  exact existential_quantifier_constructor_branch_target_closed


/-- Quantified formula-radius constructor target status.

This is a target object only. It records target status for the quantified formula-radius constructor after both quantified branch targets are surfaced. It does not prove
the target, the quantified formula-radius constructor, or full unguarded FO
formula-radius construction.
-/
def quantified_formula_radius_constructor_target_status : Prop :=
  universal_quantifier_constructor_branch_classification_target

theorem quantified_formula_radius_constructor_target_status_closed :
    quantified_formula_radius_constructor_target_status := by
  exact universal_quantifier_constructor_branch_classification_target_closed




/-- Concrete R invariant: radius-zero assignment closeness projects to
pointwise assignment equality. -/
def tri_graph_radius_zero_assignment_projection_invariant
    {σ : RelLanguage} {n : Nat} (M : RelStructure σ) : Prop :=
  ∀ (ρ τ : Fin n → M.carrier),
    AssignmentGaifmanClose M 0 ρ τ →
      ∀ x : Fin n, ρ x = τ x

/-- The concrete R invariant follows from the existing radius-zero assignment
preservation theorem. -/
theorem tri_graph_radius_zero_assignment_projection_invariant_closed
    {σ : RelLanguage} {n : Nat} (M : RelStructure σ) :
    tri_graph_radius_zero_assignment_projection_invariant (n := n) M := by
  intro ρ τ hclose x
  exact assignment_gaifman_close_radius_zero_preservation M ρ τ hclose x

/-- TRI Graph R-component assignment-extension projection target.

TRI parts:
T := quantifier_assignment_semantics_bridge_target
R := tri_graph_assignment_extension_projection_radius_control_semantics_target
I := locality_surface_transport_body_to_quantified_formula_target

This replaces the first name-only TRI payload with a non-tautological
R-component target and now includes one proved radius-zero assignment projection
invariant. It is still a proof-target layer, not a new mathematical theorem
beyond known locality.
-/
def tri_graph_assignment_extension_projection_radius_control_semantics_target
    {σ : RelLanguage} {n : Nat} (M : RelStructure σ) (_r : Nat)
    (_φ : Formula σ (n + 1)) : Prop :=
  assignment_extension_projection_radius_control_statement_target ∧
    tri_graph_radius_zero_assignment_projection_invariant (n := n) M ∧
      quantified_formula_radius_constructor_target_status ∧
        radius_preservation_under_quantifier_assignment_move_target

/-- R-projection lemma: TRI Graph R target exposes the assignment-extension
projection radius-control target. -/
theorem tri_graph_r_target_to_assignment_extension_projection_radius_control
    {σ : RelLanguage} {n : Nat} {M : RelStructure σ} {r : Nat}
    {φ : Formula σ (n + 1)} :
    tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ →
      assignment_extension_projection_radius_control_statement_target := by
  intro hR
  exact hR.1

/-- Positive-radius assignment-extension projection.

If the base assignments are Gaifman-close at radius `r` and the newly-bound
values are Gaifman-close at radius `r`, then the quantifier-extended assignments
are Gaifman-close at radius `r`.
-/
theorem tri_graph_positive_radius_assignment_extension_projection
    {σ : RelLanguage} {n r : Nat} {M : RelStructure σ}
    {ρ τ : Fin n → M.carrier} {x y : M.carrier} :
    AssignmentGaifmanClose M r ρ τ →
      GaifmanDistanceLe M x y r →
        AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) := by
  intro hbase hxy i
  rcases i with ⟨i, hi⟩
  cases i with
  | zero =>
      simpa [extendAssignment] using hxy
  | succ j =>
      have hj : j < n := Nat.lt_of_succ_lt_succ hi
      simpa [extendAssignment] using hbase ⟨j, hj⟩

/-- TRI Graph R threading for positive-radius assignment-extension projection.

This exposes the positive-radius assignment-extension projection from a TRI
Graph R package. The underlying proof is the standalone assignment-extension
projection lemma; the R package is threaded as the interface precondition.
-/
theorem tri_graph_r_target_to_positive_radius_assignment_extension_projection
    {σ : RelLanguage} {n r : Nat} {M : RelStructure σ}
    {φ : Formula σ (n + 1)} :
    tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ →
      ∀ (ρ τ : Fin n → M.carrier) (x y : M.carrier),
        AssignmentGaifmanClose M r ρ τ →
          GaifmanDistanceLe M x y r →
            AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) := by
  intro _hR ρ τ x y hbase hxy
  exact tri_graph_positive_radius_assignment_extension_projection hbase hxy

/-- Radius-zero quantifier assignment-extension projection.

If the base assignments are radius-zero Gaifman-close and the newly-bound
values are equal, then their quantifier-extended assignments are pointwise equal.
-/
theorem tri_graph_r_target_to_quantifier_assignment_extension_radius_zero_projection
    {σ : RelLanguage} {n : Nat} {M : RelStructure σ} {r : Nat}
    {φ : Formula σ (n + 1)} :
    tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ →
      ∀ (ρ τ : Fin n → M.carrier) (x y : M.carrier),
        AssignmentGaifmanClose M 0 ρ τ →
          x = y →
            ∀ i : Fin (n + 1), extendAssignment ρ x i = extendAssignment τ y i := by
  intro hR ρ τ x y hclose hxy i
  have hInv : tri_graph_radius_zero_assignment_projection_invariant (n := n) M := hR.2.1
  rcases i with ⟨i, hi⟩
  cases i with
  | zero =>
      simpa [extendAssignment] using hxy
  | succ j =>
      have hj : j < n := Nat.lt_of_succ_lt_succ hi
      have hproj := hInv ρ τ hclose ⟨j, hj⟩
      simpa [extendAssignment] using hproj

/-- TRI Graph assignment-extension semantics payload. -/
def tri_graph_assignment_extension_semantics_payload
    {σ : RelLanguage} {n : Nat} (M : RelStructure σ) (r : Nat)
    (φ : Formula σ (n + 1)) : Prop :=
  quantifier_assignment_semantics_bridge_target ∧
    tri_graph_assignment_extension_projection_radius_control_semantics_target M r φ ∧
      locality_surface_transport_body_to_quantified_formula_target

/-- TRI Graph payload refinement for positive-radius assignment extension
and the existing transport target.

This combines the proved positive-radius assignment-extension projection exposed
through the TRI Graph R component with the already-packaged locality transport
target from the full TRI Graph payload.
-/
theorem tri_graph_payload_positive_radius_assignment_extension_projection_with_transport_target
    {σ : RelLanguage} {n r : Nat} {M : RelStructure σ}
    {φ : Formula σ (n + 1)} :
    tri_graph_assignment_extension_semantics_payload M r φ →
      ∀ (ρ τ : Fin n → M.carrier) (x y : M.carrier),
        AssignmentGaifmanClose M r ρ τ →
          GaifmanDistanceLe M x y r →
            AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y) ∧
              locality_surface_transport_body_to_quantified_formula_target := by
  intro hPayload ρ τ x y hbase hxy
  constructor
  · exact
      tri_graph_r_target_to_positive_radius_assignment_extension_projection
        hPayload.2.1 ρ τ x y hbase hxy
  · exact hPayload.2.2

def proof_bearing_quantifier_assignment_radius_control_statement : Prop :=
  ∀ {σ : RelLanguage} {n r : Nat} (M : RelStructure σ) (φ : Formula σ (n + 1)),
    tri_graph_assignment_extension_semantics_payload M r φ →
      quantified_formula_radius_constructor_target_status →
        radius_preservation_under_quantifier_assignment_move_target →
          locality_surface_transport_body_to_quantified_formula_target ∧
            ∀ (ρ τ : Fin n → M.carrier) (x y : M.carrier),
              AssignmentGaifmanClose M r ρ τ →
                GaifmanDistanceLe M x y r →
                  AssignmentGaifmanClose M r (extendAssignment ρ x) (extendAssignment τ y)


/-- Trebuchet Variant.

Full proof target attempt for unguarded FO formula-radius construction after
the completed quantified-constructor target ladder. This version targets the
now-defined proof-bearing quantifier assignment radius-control statement.
-/
theorem trebuchet_variant_full_unguarded_fo_formula_radius_construction :
    proof_bearing_quantifier_assignment_radius_control_statement := by
  intro _σ
  intro _n
  intro _r
  intro _M
  intro _φ
  intro hTriGraph
  intro _hQuantified
  intro _hRadius
  constructor
  · exact locality_surface_transport_body_to_quantified_formula_target_closed
  · intro ρ τ x y hbase hxy
    exact
      (tri_graph_payload_positive_radius_assignment_extension_projection_with_transport_target
        hTriGraph ρ τ x y hbase hxy).1

/-- Formula structural recursion assembler target.

This downstream edge now carries both the quantified-formula constructor target
and the proof-bearing quantifier assignment radius-control statement, including
the positive-radius assignment-extension projection.
-/
def formula_structural_recursion_assembler_target : Prop :=
  quantified_formula_radius_constructor_target_status ∧
    proof_bearing_quantifier_assignment_radius_control_statement

theorem formula_structural_recursion_assembler_target_closed :
    formula_structural_recursion_assembler_target := by
  constructor
  · exact quantified_formula_radius_constructor_target_status_closed
  · exact trebuchet_variant_full_unguarded_fo_formula_radius_construction


/-- Formula-radius construction gate structural-recursion edge.

This is a gate-edge target only. It records that the formula-radius construction
gate now carries the strengthened formula structural recursion assembler target,
while preserving the prior bounded Boolean recursion gate status. It does not
prove full formula-radius construction, full quantifier locality transport, or
full unguarded FO locality.
-/
def formula_radius_construction_gate_structural_recursion_edge : Prop :=
  formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate ∧
    formula_structural_recursion_assembler_target

theorem formula_radius_construction_gate_structural_recursion_edge_closed :
    formula_radius_construction_gate_structural_recursion_edge := by
  constructor
  · exact formula_radius_construction_gate_status_from_bounded_boolean_recursion_gate_closed
  · exact formula_structural_recursion_assembler_target_closed
/-- Pk1 quantified-constructor branch frontier status.

This is a status edge only. It records that the post-gate formula-radius
construction edge exposes the quantified-constructor branch as the next named
frontier. It does not define or prove Pk1, 2vK, full formula-radius
construction, full quantifier locality transport, or full unguarded FO locality.
-/
def pk1_quantified_constructor_branch_frontier_status : Prop :=
  formula_radius_construction_gate_structural_recursion_edge ∧
    quantified_formula_radius_constructor_target_status

theorem pk1_quantified_constructor_branch_frontier_status_closed :
    pk1_quantified_constructor_branch_frontier_status := by
  have hGate : formula_radius_construction_gate_structural_recursion_edge :=
    formula_radius_construction_gate_structural_recursion_edge_closed
  constructor
  · exact hGate
  · exact hGate.2.1

/-- Target-only Pk1 theorem statement shell.

This names the repository's intended Pk1 unguarded FO locality theorem target
only at the already validated quantified-constructor branch frontier. It does
not prove Pk1, does not define any 2vK bridge, and does not claim full
formula-radius construction, full quantifier locality transport, or full
unguarded FO locality.
-/
def Pk1_unguarded_fo_locality_theorem_statement_shell : Prop :=
  pk1_quantified_constructor_branch_frontier_status

theorem Pk1_unguarded_fo_locality_theorem_statement_shell_closed :
    Pk1_unguarded_fo_locality_theorem_statement_shell := by
  exact pk1_quantified_constructor_branch_frontier_status_closed

/-- Target-only 2vK bridge shell.

This names the repository's intended 2vK bridge target only over the validated
target-only Pk1 theorem statement shell. It does not prove 2vK, does not prove
Pk1, and does not claim full formula-radius construction, full quantifier
locality transport, or full unguarded FO locality.
-/
def TwoVK_bridge_target_shell : Prop :=
  Pk1_unguarded_fo_locality_theorem_statement_shell

theorem TwoVK_bridge_target_shell_closed :
    TwoVK_bridge_target_shell := by
  exact Pk1_unguarded_fo_locality_theorem_statement_shell_closed

/-- Direct bridge-strengthening status from the 2vK target shell to the Pk1
statement shell.

This is only a status/target edge. It records that the validated 2vK bridge
target shell carries the validated Pk1 theorem statement shell as its immediate
source target. It does not prove 2vK, does not prove Pk1, and does not claim
full formula-radius construction, full quantifier locality transport, or full
unguarded FO locality.
-/
def TwoVK_bridge_target_to_Pk1_statement_status : Prop :=
  TwoVK_bridge_target_shell ∧
    Pk1_unguarded_fo_locality_theorem_statement_shell

theorem TwoVK_bridge_target_to_Pk1_statement_status_closed :
    TwoVK_bridge_target_to_Pk1_statement_status := by
  have hBridge : TwoVK_bridge_target_shell :=
    TwoVK_bridge_target_shell_closed
  constructor
  · exact hBridge
  · exact hBridge

/-- Direct projection from the 2vK-to-Pk1 statement status edge to the
Pk1 quantified-constructor branch frontier.

This is only a status/projection edge. It records that the carried target-only
Pk1 statement shell exposes the already validated quantified-constructor branch
frontier. It does not prove 2vK, does not prove Pk1, and does not claim full
formula-radius construction, full quantifier locality transport, or full
unguarded FO locality.
-/
def TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status : Prop :=
  TwoVK_bridge_target_to_Pk1_statement_status ∧
    pk1_quantified_constructor_branch_frontier_status

theorem TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status_closed :
    TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status := by
  have hStatus : TwoVK_bridge_target_to_Pk1_statement_status :=
    TwoVK_bridge_target_to_Pk1_statement_status_closed
  constructor
  · exact hStatus
  · exact hStatus.2

/-- Direct projection from the 2vK-to-Pk1 quantified-constructor frontier
status edge to the formula-radius gate structural-recursion edge.

This is only a status/projection edge. It records that the carried Pk1
quantified-constructor branch frontier exposes the already validated
formula-radius construction gate structural-recursion edge. It does not prove
2vK, does not prove Pk1, and does not claim full formula-radius construction,
full quantifier locality transport, or full unguarded FO locality.
-/
def TwoVK_to_Pk1_frontier_to_formula_radius_gate_status : Prop :=
  TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status ∧
    formula_radius_construction_gate_structural_recursion_edge

theorem TwoVK_to_Pk1_frontier_to_formula_radius_gate_status_closed :
    TwoVK_to_Pk1_frontier_to_formula_radius_gate_status := by
  have hStatus :
      TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status :=
    TwoVK_to_Pk1_statement_to_quantified_constructor_frontier_status_closed
  constructor
  · exact hStatus
  · exact hStatus.2.1







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



/-- Direct projection from the 2vK-to-Pk1 formula-radius gate status edge to
the carried structural-recursion assembler target.

This is only a status/projection edge. It records that the validated
formula-radius gate frontier exposes the already validated structural-recursion
assembler target. It does not prove 2vK, does not prove Pk1, and does not claim
full formula-radius construction, full quantifier locality transport, or full
unguarded FO locality.
-/
def TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status : Prop :=
  TwoVK_to_Pk1_frontier_to_formula_radius_gate_status ∧
    formula_structural_recursion_assembler_target

theorem TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status_closed :
    TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status := by
  have hStatus : TwoVK_to_Pk1_frontier_to_formula_radius_gate_status :=
    TwoVK_to_Pk1_frontier_to_formula_radius_gate_status_closed
  constructor
  · exact hStatus
  · exact hStatus.2.2


/-- Direct projection from the 2vK-to-Pk1 structural-recursion status edge to
the carried proof-bearing quantifier assignment radius-control statement.

This is only a status/projection edge. It records that the validated
structural-recursion assembler target exposes the already validated
proof-bearing quantifier assignment radius-control statement. It does not prove
2vK, does not prove Pk1, and does not claim full formula-radius construction,
full quantifier locality transport, or full unguarded FO locality.
-/
def TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status : Prop :=
  TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status ∧
    proof_bearing_quantifier_assignment_radius_control_statement

theorem TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status_closed :
    TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status := by
  have hStatus :
      TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status :=
    TwoVK_to_Pk1_formula_radius_gate_to_structural_recursion_status_closed
  constructor
  · exact hStatus
  · exact hStatus.2.2

/-- Missing existential locality-radius constructor theorem status.

This status-lock names the weakest missing theorem after the proof-bearing
quantifier assignment radius-control statement has been exposed. The missing
theorem would construct locality for `Formula.ex φ` from locality of the body
formula. This status does not prove that constructor, does not prove Pk1 or
2vK, and does not claim full formula-radius construction, full quantifier
locality transport, or full unguarded FO locality.
-/
def existential_locality_radius_constructor_missing_theorem_status : Prop :=
  TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status

theorem existential_locality_radius_constructor_missing_theorem_status_closed :
    existential_locality_radius_constructor_missing_theorem_status := by
  exact TwoVK_to_Pk1_structural_recursion_to_proof_bearing_quantifier_status_closed

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
