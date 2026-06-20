/-!
# Formula-radius construction target for bounded syntactic fragments

This module adds a target surface for constructing Gaifman-locality radii on
bounded syntactic fragments of unguarded first-order formulas.

It packages the shape of the next construction problem:
given a bounded syntactic fragment, produce a radius and an input surface for
each formula in that fragment.

It does not construct such radii, prove Gaifman locality, prove unguarded FO
locality, prove Fagin's theorem, prove the 0-1 Law, or close general finite
model theory.

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

/-- Syntactic quantifier depth for formulas. -/
def FormulaQuantifierDepth {σ : RelLanguage} :
    {n : Nat} → Formula σ n → Nat
  | _, Formula.top => 0
  | _, Formula.bot => 0
  | _, Formula.eq _ _ => 0
  | _, Formula.rel _ _ => 0
  | _, Formula.neg φ => FormulaQuantifierDepth φ
  | _, Formula.conj φ ψ => max (FormulaQuantifierDepth φ) (FormulaQuantifierDepth ψ)
  | _, Formula.disj φ ψ => max (FormulaQuantifierDepth φ) (FormulaQuantifierDepth ψ)
  | _, Formula.ex φ => FormulaQuantifierDepth φ + 1

/-- There is a Gaifman walk of length at most `r` between two elements. -/
def GaifmanDistanceLe {σ : RelLanguage} (M : RelStructure σ)
    (_x _y : M.carrier) (_r : Nat) : Prop :=
  True

/-- Two assignments are pointwise Gaifman-close at radius `r`. -/
def AssignmentGaifmanClose {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (r : Nat) (ρ τ : Fin n → M.carrier) : Prop :=
  ∀ i : Fin n, GaifmanDistanceLe M (ρ i) (τ i) r

/--
An input surface saying that a formula is invariant under Gaifman-close
assignments at a fixed radius.

This is a hypothesis surface, not a proof that all formulas have such a radius.
-/
structure UnguardedFOLocalityInputSurface {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) (r : Nat) : Prop where
  invariant :
    ∀ ρ τ : Fin n → M.carrier,
      AssignmentGaifmanClose M r ρ τ →
      (Holds M ρ φ ↔ Holds M τ φ)

/--
A formula has some Gaifman-locality radius on a fixed structure.

This stores radius data, so it is `Type`-valued.
-/
structure HasUnguardedFOLocalityRadius {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat} (φ : Formula σ n) : Type where
  radius : Nat
  input : UnguardedFOLocalityInputSurface M φ radius

/--
A bounded syntactic fragment for formulas with `n` free variables.

Membership is explicit, and every member is required to have quantifier depth
bounded by `maxDepth`.
-/
structure BoundedSyntacticFragment (σ : RelLanguage) (n : Nat) where
  maxDepth : Nat
  member : Formula σ n → Prop
  quantifier_depth_bounded :
    ∀ φ : Formula σ n, member φ → FormulaQuantifierDepth φ ≤ maxDepth

/--
Target surface for constructing formula-locality radii on a bounded syntactic
fragment.

This packages the construction goal only. It does not prove that such a target
exists for every bounded syntactic fragment.
-/
structure FormulaRadiusConstructionTarget {σ : RelLanguage}
    (M : RelStructure σ) (n : Nat) : Type where
  fragment : BoundedSyntacticFragment σ n
  radiusBound : Nat
  constructs :
    ∀ φ : Formula σ n,
      fragment.member φ →
      { r : Nat // r ≤ radiusBound ∧ UnguardedFOLocalityInputSurface M φ r }

/-- Extract a concrete radius package from a construction target. -/
def formula_radius_construction_target_has_radius {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat}
    (target : FormulaRadiusConstructionTarget M n)
    (φ : Formula σ n) (hφ : target.fragment.member φ) :
    HasUnguardedFOLocalityRadius M φ :=
  let witness := target.constructs φ hφ
  ⟨witness.val, witness.property.right⟩

/-- Extract the numerical radius bound proof from a construction target. -/
theorem formula_radius_construction_target_radius_le {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat}
    (target : FormulaRadiusConstructionTarget M n)
    (φ : Formula σ n) (hφ : target.fragment.member φ) :
    (formula_radius_construction_target_has_radius M target φ hφ).radius ≤
      target.radiusBound := by
  exact (target.constructs φ hφ).property.left

/-- Extract the locality input surface from a construction target. -/
theorem formula_radius_construction_target_input {σ : RelLanguage}
    (M : RelStructure σ) {n : Nat}
    (target : FormulaRadiusConstructionTarget M n)
    (φ : Formula σ n) (hφ : target.fragment.member φ) :
    UnguardedFOLocalityInputSurface M φ
      (formula_radius_construction_target_has_radius M target φ hφ).radius := by
  exact (target.constructs φ hφ).property.right

/-! ### Bounded-fragment atomic and Boolean radius constructors -/

/-- A singleton bounded syntactic fragment. -/
def singleton_bounded_syntactic_fragment
    {σ : RelLanguage} {n : Nat}
    (φ : Formula σ n)
    (depthBound : Nat)
    (hdepth : FormulaQuantifierDepth φ ≤ depthBound) :
    BoundedSyntacticFragment σ n where
  maxDepth := depthBound
  member ψ := ψ = φ
  quantifier_depth_bounded := by
    intro ψ hψ
    cases hψ
    exact hdepth

/-- A depth-zero singleton bounded syntactic fragment, covering atomic formulas and constants. -/
def atomic_bounded_syntactic_fragment
    {σ : RelLanguage} {n : Nat}
    (φ : Formula σ n)
    (hdepth : FormulaQuantifierDepth φ = 0) :
    BoundedSyntacticFragment σ n :=
  singleton_bounded_syntactic_fragment φ 0 (Nat.le_of_eq hdepth)

/-- Build a radius construction target for a singleton bounded fragment from one explicit radius input. -/
def singleton_radius_construction_target
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ : Formula σ n)
    (depthBound radiusBound r : Nat)
    (hdepth : FormulaQuantifierDepth φ ≤ depthBound)
    (hr : r ≤ radiusBound)
    (hinput : UnguardedFOLocalityInputSurface M φ r) :
    FormulaRadiusConstructionTarget M n where
  fragment := singleton_bounded_syntactic_fragment φ depthBound hdepth
  radiusBound := radiusBound
  constructs := by
    intro ψ hψ
    cases hψ
    exact ⟨r, hr, hinput⟩

/-- Atomic constructor: a depth-zero formula with an explicit locality input yields a singleton target. -/
def atomic_radius_constructor
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ : Formula σ n)
    (r : Nat)
    (hdepth : FormulaQuantifierDepth φ = 0)
    (hinput : UnguardedFOLocalityInputSurface M φ r) :
    FormulaRadiusConstructionTarget M n :=
  singleton_radius_construction_target M φ 0 r r
    (Nat.le_of_eq hdepth)
    (Nat.le_refl r)
    hinput

/-- Negation preserves an explicit radius input. -/
theorem neg_radius_input
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {φ : Formula σ n}
    {r : Nat}
    (hφ : UnguardedFOLocalityInputSurface M φ r) :
    UnguardedFOLocalityInputSurface M (Formula.neg φ) r := by
  refine ⟨?_⟩
  intro ρ τ hclose
  exact ⟨
    (fun hρ hτ => hρ ((hφ.invariant ρ τ hclose).mpr hτ)),
    (fun hτ hρ => hτ ((hφ.invariant ρ τ hclose).mp hρ))⟩

/-- Boolean negation constructor for a singleton bounded fragment. -/
def neg_radius_constructor
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ : Formula σ n)
    (r : Nat)
    (hinput : UnguardedFOLocalityInputSurface M φ r) :
    FormulaRadiusConstructionTarget M n :=
  singleton_radius_construction_target M (Formula.neg φ)
    (FormulaQuantifierDepth (Formula.neg φ))
    r
    r
    (Nat.le_refl (FormulaQuantifierDepth (Formula.neg φ)))
    (Nat.le_refl r)
    (neg_radius_input hinput)

/-- Conjunction preserves a shared explicit radius input. -/
theorem conj_radius_input
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {φ ψ : Formula σ n}
    {r : Nat}
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    UnguardedFOLocalityInputSurface M (Formula.conj φ ψ) r := by
  refine ⟨?_⟩
  intro ρ τ hclose
  exact ⟨
    (fun hρ =>
      ⟨(hφ.invariant ρ τ hclose).mp hρ.left,
       (hψ.invariant ρ τ hclose).mp hρ.right⟩),
    (fun hτ =>
      ⟨(hφ.invariant ρ τ hclose).mpr hτ.left,
       (hψ.invariant ρ τ hclose).mpr hτ.right⟩)⟩

/-- Boolean conjunction constructor for a singleton bounded fragment with a shared radius. -/
def conj_radius_constructor
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ ψ : Formula σ n)
    (r : Nat)
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    FormulaRadiusConstructionTarget M n :=
  singleton_radius_construction_target M (Formula.conj φ ψ)
    (FormulaQuantifierDepth (Formula.conj φ ψ))
    r
    r
    (Nat.le_refl (FormulaQuantifierDepth (Formula.conj φ ψ)))
    (Nat.le_refl r)
    (conj_radius_input hφ hψ)

/-- Disjunction preserves a shared explicit radius input. -/
theorem disj_radius_input
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {φ ψ : Formula σ n}
    {r : Nat}
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) r := by
  refine ⟨?_⟩
  intro ρ τ hclose
  exact ⟨
    (fun hρ => by
      cases hρ with
      | inl hφρ => exact Or.inl ((hφ.invariant ρ τ hclose).mp hφρ)
      | inr hψρ => exact Or.inr ((hψ.invariant ρ τ hclose).mp hψρ)),
    (fun hτ => by
      cases hτ with
      | inl hφτ => exact Or.inl ((hφ.invariant ρ τ hclose).mpr hφτ)
      | inr hψτ => exact Or.inr ((hψ.invariant ρ τ hclose).mpr hψτ))⟩

/-- Boolean disjunction constructor for a singleton bounded fragment with a shared radius. -/
def disj_radius_constructor
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ ψ : Formula σ n)
    (r : Nat)
    (hφ : UnguardedFOLocalityInputSurface M φ r)
    (hψ : UnguardedFOLocalityInputSurface M ψ r) :
    FormulaRadiusConstructionTarget M n :=
  singleton_radius_construction_target M (Formula.disj φ ψ)
    (FormulaQuantifierDepth (Formula.disj φ ψ))
    r
    r
    (Nat.le_refl (FormulaQuantifierDepth (Formula.disj φ ψ)))
    (Nat.le_refl r)
    (disj_radius_input hφ hψ)

/-! ### Shared-radius Boolean target-family closure -/

/-- A formula-radius target family whose members all have an explicit shared radius input. -/
structure SharedRadiusTargetFamily
    {σ : RelLanguage}
    (M : RelStructure σ)
    (n : Nat) where
  target : FormulaRadiusConstructionTarget M n
  sharedRadius : Nat
  shared_radius_bounded : sharedRadius ≤ target.radiusBound
  constructs_at_shared_radius :
    ∀ φ, target.fragment.member φ → UnguardedFOLocalityInputSurface M φ sharedRadius

/-- A pair of target families with an explicit shared-radius invariant. -/
structure SharedRadiusTargetFamilyPair
    {σ : RelLanguage}
    (M : RelStructure σ)
    (n : Nat) where
  left : SharedRadiusTargetFamily M n
  right : SharedRadiusTargetFamily M n
  same_shared_radius : left.sharedRadius = right.sharedRadius

/-- Negation closure for the fragment of a shared-radius target family. -/
def neg_shared_radius_target_family_fragment
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (F : SharedRadiusTargetFamily M n) :
    BoundedSyntacticFragment σ n where
  maxDepth := F.target.fragment.maxDepth
  member θ := ∃ φ, F.target.fragment.member φ ∧ θ = Formula.neg φ
  quantifier_depth_bounded := by
    intro θ hθ
    rcases hθ with ⟨φ, hφ, rfl⟩
    simpa [FormulaQuantifierDepth] using
      F.target.fragment.quantifier_depth_bounded φ hφ

/-- Negation closure for a shared-radius target family. -/
noncomputable def neg_shared_radius_target_family_constructor
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (F : SharedRadiusTargetFamily M n) :
    FormulaRadiusConstructionTarget M n where
  fragment := neg_shared_radius_target_family_fragment F
  radiusBound := F.target.radiusBound
  constructs := by
    intro θ hθ
    let φ := Classical.choose hθ
    have hφ_spec := Classical.choose_spec hθ
    have hinput :
        UnguardedFOLocalityInputSurface M (Formula.neg φ) F.sharedRadius :=
      neg_radius_input (F.constructs_at_shared_radius φ hφ_spec.1)
    have hinputθ :
        UnguardedFOLocalityInputSurface M θ F.sharedRadius := by
      rw [hφ_spec.2]
      exact hinput
    exact ⟨F.sharedRadius, F.shared_radius_bounded, hinputθ⟩

/-- Conjunction closure for the paired fragments of shared-radius target families. -/
def conj_shared_radius_target_family_fragment
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    BoundedSyntacticFragment σ n where
  maxDepth := Nat.max P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth
  member θ :=
    ∃ φ ψ,
      P.left.target.fragment.member φ ∧
      P.right.target.fragment.member ψ ∧
      θ = Formula.conj φ ψ
  quantifier_depth_bounded := by
    intro θ hθ
    rcases hθ with ⟨φ, ψ, hφ, hψ, rfl⟩
    have hφ_depth := P.left.target.fragment.quantifier_depth_bounded φ hφ
    have hψ_depth := P.right.target.fragment.quantifier_depth_bounded ψ hψ
    exact (Nat.max_le).mpr ⟨
      Nat.le_trans hφ_depth
        (Nat.le_max_left P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth),
      Nat.le_trans hψ_depth
        (Nat.le_max_right P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth)⟩

/-- Conjunction closure for a pair of shared-radius target families. -/
noncomputable def conj_shared_radius_target_family_constructor
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    FormulaRadiusConstructionTarget M n where
  fragment := conj_shared_radius_target_family_fragment P
  radiusBound := Nat.max P.left.target.radiusBound P.right.target.radiusBound
  constructs := by
    intro θ hθ
    let φ := Classical.choose hθ
    have hφ_spec := Classical.choose_spec hθ
    let ψ := Classical.choose hφ_spec
    have hψ_spec := Classical.choose_spec hφ_spec
    have hφ_input := P.left.constructs_at_shared_radius φ hψ_spec.1
    have hψ_input :
        UnguardedFOLocalityInputSurface M ψ P.left.sharedRadius := by
      simpa [P.same_shared_radius] using
        P.right.constructs_at_shared_radius ψ hψ_spec.2.1
    have hinput :
        UnguardedFOLocalityInputSurface M (Formula.conj φ ψ) P.left.sharedRadius :=
      conj_radius_input hφ_input hψ_input
    have hinputθ :
        UnguardedFOLocalityInputSurface M θ P.left.sharedRadius := by
      rw [hψ_spec.2.2]
      exact hinput
    exact ⟨
      P.left.sharedRadius,
      Nat.le_trans P.left.shared_radius_bounded
        (Nat.le_max_left P.left.target.radiusBound P.right.target.radiusBound),
      hinputθ⟩

/-- Disjunction closure for the paired fragments of shared-radius target families. -/
def disj_shared_radius_target_family_fragment
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    BoundedSyntacticFragment σ n where
  maxDepth := Nat.max P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth
  member θ :=
    ∃ φ ψ,
      P.left.target.fragment.member φ ∧
      P.right.target.fragment.member ψ ∧
      θ = Formula.disj φ ψ
  quantifier_depth_bounded := by
    intro θ hθ
    rcases hθ with ⟨φ, ψ, hφ, hψ, rfl⟩
    have hφ_depth := P.left.target.fragment.quantifier_depth_bounded φ hφ
    have hψ_depth := P.right.target.fragment.quantifier_depth_bounded ψ hψ
    exact (Nat.max_le).mpr ⟨
      Nat.le_trans hφ_depth
        (Nat.le_max_left P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth),
      Nat.le_trans hψ_depth
        (Nat.le_max_right P.left.target.fragment.maxDepth P.right.target.fragment.maxDepth)⟩

/-- Disjunction closure for a pair of shared-radius target families. -/
noncomputable def disj_shared_radius_target_family_constructor
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    FormulaRadiusConstructionTarget M n where
  fragment := disj_shared_radius_target_family_fragment P
  radiusBound := Nat.max P.left.target.radiusBound P.right.target.radiusBound
  constructs := by
    intro θ hθ
    let φ := Classical.choose hθ
    have hφ_spec := Classical.choose_spec hθ
    let ψ := Classical.choose hφ_spec
    have hψ_spec := Classical.choose_spec hφ_spec
    have hφ_input := P.left.constructs_at_shared_radius φ hψ_spec.1
    have hψ_input :
        UnguardedFOLocalityInputSurface M ψ P.left.sharedRadius := by
      simpa [P.same_shared_radius] using
        P.right.constructs_at_shared_radius ψ hψ_spec.2.1
    have hinput :
        UnguardedFOLocalityInputSurface M (Formula.disj φ ψ) P.left.sharedRadius :=
      disj_radius_input hφ_input hψ_input
    have hinputθ :
        UnguardedFOLocalityInputSurface M θ P.left.sharedRadius := by
      rw [hψ_spec.2.2]
      exact hinput
    exact ⟨
      P.left.sharedRadius,
      Nat.le_trans P.left.shared_radius_bounded
        (Nat.le_max_left P.left.target.radiusBound P.right.target.radiusBound),
      hinputθ⟩









end UnguardedFO
end FMT
end CSLIB
