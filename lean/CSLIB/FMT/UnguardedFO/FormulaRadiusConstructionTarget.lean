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

/-- Extract a locality-radius witness from the negated shared-radius family constructor. -/
noncomputable def neg_shared_radius_target_family_has_radius
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (F : SharedRadiusTargetFamily M n)
    (θ : Formula σ n)
    (hθ : (neg_shared_radius_target_family_fragment F).member θ) :
    HasUnguardedFOLocalityRadius M θ :=
  formula_radius_construction_target_has_radius
    M
    (neg_shared_radius_target_family_constructor F)
    θ
    hθ


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

/-! ### Shared-radius family introductions -/

/-- Introduce a shared-radius target family from one explicit singleton radius input. -/
def singleton_shared_radius_target_family
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ : Formula σ n)
    (depthBound r : Nat)
    (hdepth : FormulaQuantifierDepth φ ≤ depthBound)
    (hinput : UnguardedFOLocalityInputSurface M φ r) :
    SharedRadiusTargetFamily M n where
  target := singleton_radius_construction_target M φ depthBound r r
    hdepth
    (Nat.le_refl r)
    hinput
  sharedRadius := r
  shared_radius_bounded := Nat.le_refl r
  constructs_at_shared_radius := by
    intro ψ hψ
    cases hψ
    exact hinput

/-- Introduce a shared-radius target family from an explicit atomic singleton input. -/
def atomic_shared_radius_target_family
    {σ : RelLanguage}
    (M : RelStructure σ)
    {n : Nat}
    (φ : Formula σ n)
    (r : Nat)
    (hdepth : FormulaQuantifierDepth φ = 0)
    (hinput : UnguardedFOLocalityInputSurface M φ r) :
    SharedRadiusTargetFamily M n :=
  singleton_shared_radius_target_family M φ 0 r
    (Nat.le_of_eq hdepth)
    hinput

/-- Introduce a shared-radius target family from a negation constructor output. -/
noncomputable def neg_shared_radius_target_family
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (F : SharedRadiusTargetFamily M n) :
    SharedRadiusTargetFamily M n where
  target := neg_shared_radius_target_family_constructor F
  sharedRadius := F.sharedRadius
  shared_radius_bounded := F.shared_radius_bounded
  constructs_at_shared_radius := by
    intro θ hθ
    change (neg_shared_radius_target_family_fragment F).member θ at hθ
    let φ := Classical.choose hθ
    have hφ_spec := Classical.choose_spec hθ
    have hinput :
        UnguardedFOLocalityInputSurface M (Formula.neg φ) F.sharedRadius :=
      neg_radius_input (F.constructs_at_shared_radius φ hφ_spec.1)
    have hinputθ :
        UnguardedFOLocalityInputSurface M θ F.sharedRadius := by
      rw [hφ_spec.2]
      exact hinput
    exact hinputθ

/-- Introduce a shared-radius target family from a conjunction constructor output. -/
noncomputable def conj_shared_radius_target_family
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    SharedRadiusTargetFamily M n where
  target := conj_shared_radius_target_family_constructor P
  sharedRadius := P.left.sharedRadius
  shared_radius_bounded :=
    Nat.le_trans P.left.shared_radius_bounded
      (Nat.le_max_left P.left.target.radiusBound P.right.target.radiusBound)
  constructs_at_shared_radius := by
    intro θ hθ
    change (conj_shared_radius_target_family_fragment P).member θ at hθ
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
    exact hinputθ

/-- Introduce a shared-radius target family from a disjunction constructor output. -/
noncomputable def disj_shared_radius_target_family
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    (P : SharedRadiusTargetFamilyPair M n) :
    SharedRadiusTargetFamily M n where
  target := disj_shared_radius_target_family_constructor P
  sharedRadius := P.left.sharedRadius
  shared_radius_bounded :=
    Nat.le_trans P.left.shared_radius_bounded
      (Nat.le_max_left P.left.target.radiusBound P.right.target.radiusBound)
  constructs_at_shared_radius := by
    intro θ hθ
    change (disj_shared_radius_target_family_fragment P).member θ at hθ
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
    exact hinputθ

/-! ### Finite Boolean expression fold under an explicit shared-radius environment -/

/-- Explicit finite Boolean expression syntax over an index type. -/
inductive FiniteBooleanFamilyExpr (ι : Type) where
  | atom : ι -> FiniteBooleanFamilyExpr ι
  | neg : FiniteBooleanFamilyExpr ι -> FiniteBooleanFamilyExpr ι
  | conj : FiniteBooleanFamilyExpr ι -> FiniteBooleanFamilyExpr ι -> FiniteBooleanFamilyExpr ι
  | disj : FiniteBooleanFamilyExpr ι -> FiniteBooleanFamilyExpr ι -> FiniteBooleanFamilyExpr ι

/--
Fold an explicit finite Boolean expression over an indexed shared-radius environment.

The subtype packages the evaluated family together with the invariant that its shared
radius is the environment radius.
-/
noncomputable def finite_boolean_family_fold_with_radius
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius) :
    FiniteBooleanFamilyExpr ι ->
      {F : SharedRadiusTargetFamily M n // F.sharedRadius = sharedRadius}
  | FiniteBooleanFamilyExpr.atom i =>
      ⟨env i, henv i⟩
  | FiniteBooleanFamilyExpr.neg e =>
      let F := finite_boolean_family_fold_with_radius env sharedRadius henv e
      ⟨neg_shared_radius_target_family F.1, by
        change F.1.sharedRadius = sharedRadius
        exact F.2⟩
  | FiniteBooleanFamilyExpr.conj e₁ e₂ =>
      let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv e₁
      let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv e₂
      let P : SharedRadiusTargetFamilyPair M n := {
        left := F₁.1
        right := F₂.1
        same_shared_radius := by
          rw [F₁.2, F₂.2]
      }
      ⟨conj_shared_radius_target_family P, by
        change P.left.sharedRadius = sharedRadius
        exact F₁.2⟩
  | FiniteBooleanFamilyExpr.disj e₁ e₂ =>
      let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv e₁
      let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv e₂
      let P : SharedRadiusTargetFamilyPair M n := {
        left := F₁.1
        right := F₂.1
        same_shared_radius := by
          rw [F₁.2, F₂.2]
      }
      ⟨disj_shared_radius_target_family P, by
        change P.left.sharedRadius = sharedRadius
        exact F₁.2⟩

/-- The shared-radius target family obtained by folding an explicit finite Boolean expression. -/
noncomputable def finite_boolean_family_fold
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    SharedRadiusTargetFamily M n :=
  (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1

/-- The finite Boolean fold preserves the explicit shared-radius invariant. -/
theorem finite_boolean_family_fold_shared_radius
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv expr).sharedRadius = sharedRadius :=
  (finite_boolean_family_fold_with_radius env sharedRadius henv expr).2













/-! ### Finite Boolean fold-output fragment-membership lemmas -/

/-- Atom fold outputs preserve the indexed family fragment membership. -/
theorem finite_boolean_family_fold_atom_fragment_member
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (i : ι)
    (φ : Formula σ n)
    (hφ : (env i).target.fragment.member φ) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.atom i)).target.fragment.member φ := by
  simpa [finite_boolean_family_fold, finite_boolean_family_fold_with_radius] using hφ

/-- Negation fold outputs preserve membership for the generated negated formula. -/
theorem finite_boolean_family_fold_neg_fragment_member
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι)
    (φ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv expr).target.fragment.member φ) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.neg expr)).target.fragment.member (Formula.neg φ) := by
  change
    (neg_shared_radius_target_family_fragment
      (finite_boolean_family_fold env sharedRadius henv expr)).member (Formula.neg φ)
  exact ⟨φ, hφ, rfl⟩

/-- Conjunction fold outputs preserve membership for the generated conjoined formula. -/
theorem finite_boolean_family_fold_conj_fragment_member
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι)
    (φ ψ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv left).target.fragment.member φ)
    (hψ :
      (finite_boolean_family_fold env sharedRadius henv right).target.fragment.member ψ) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right)).target.fragment.member
        (Formula.conj φ ψ) := by
  let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
  let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
  let P : SharedRadiusTargetFamilyPair M n :=
    { left := F₁.1
      right := F₂.1
      same_shared_radius := by rw [F₁.2, F₂.2] }
  change (conj_shared_radius_target_family_fragment P).member (Formula.conj φ ψ)
  exact ⟨φ, ψ, hφ, hψ, rfl⟩

/-- Disjunction fold outputs preserve membership for the generated disjoined formula. -/
theorem finite_boolean_family_fold_disj_fragment_member
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι)
    (φ ψ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv left).target.fragment.member φ)
    (hψ :
      (finite_boolean_family_fold env sharedRadius henv right).target.fragment.member ψ) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right)).target.fragment.member
        (Formula.disj φ ψ) := by
  let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
  let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
  let P : SharedRadiusTargetFamilyPair M n :=
    { left := F₁.1
      right := F₂.1
      same_shared_radius := by rw [F₁.2, F₂.2] }
  change (disj_shared_radius_target_family_fragment P).member (Formula.disj φ ψ)
  exact ⟨φ, ψ, hφ, hψ, rfl⟩



/- Finite Boolean fold expression-indexed radius and target access lemmas. -/

/-- Access the first projection of the expression-indexed fold-with-radius package. -/
theorem finite_boolean_family_fold_with_radius_value_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1 =
      finite_boolean_family_fold env sharedRadius henv expr := by
  rfl

/-- Access the shared radius carried by an expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_radius_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv expr).sharedRadius = sharedRadius := by
  exact (finite_boolean_family_fold_with_radius env sharedRadius henv expr).2

/-- Any two expression-indexed finite Boolean fold outputs share the explicit fold radius. -/
theorem finite_boolean_family_fold_pair_radius_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv left).sharedRadius =
      (finite_boolean_family_fold env sharedRadius henv right).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv left,
    finite_boolean_family_fold_radius_access env sharedRadius henv right,
  ]

/-- Access the target projection of an expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_target_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv expr).target =
      (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1.target := by
  rfl

/-- Access the target fragment projection of an expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_target_fragment_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv expr).target.fragment =
      (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1.target.fragment := by
  rfl



/- Finite Boolean fold expression-indexed constructor access lemmas. -/

/-- Access the atom constructor case of the expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_atom_constructor_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (i : ι) :
    finite_boolean_family_fold env sharedRadius henv (FiniteBooleanFamilyExpr.atom i) =
      env i := by
  rfl

/-- Access the negation constructor case of the expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_neg_constructor_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    finite_boolean_family_fold env sharedRadius henv (FiniteBooleanFamilyExpr.neg expr) =
      neg_shared_radius_target_family
        (finite_boolean_family_fold env sharedRadius henv expr) := by
  rfl

/-- Access the conjunction constructor case of the expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_conj_constructor_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
    let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
    let P : SharedRadiusTargetFamilyPair M n :=
      { left := F₁.1
        right := F₂.1
        same_shared_radius := by rw [F₁.2, F₂.2] }
    finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right) =
        conj_shared_radius_target_family P := by
  rfl

/-- Access the disjunction constructor case of the expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_disj_constructor_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
    let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
    let P : SharedRadiusTargetFamilyPair M n :=
      { left := F₁.1
        right := F₂.1
        same_shared_radius := by rw [F₁.2, F₂.2] }
    finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right) =
        disj_shared_radius_target_family P := by
  rfl



/- Finite Boolean fold expression-indexed shared-radius input access lemmas. -/

/-- Access the atom input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_atom_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (i : ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.atom i)).sharedRadius =
        (env i).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.atom i),
    henv i,
  ]

/-- Access the negation input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_neg_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.neg expr)).sharedRadius =
        (finite_boolean_family_fold env sharedRadius henv expr).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.neg expr),
    finite_boolean_family_fold_radius_access env sharedRadius henv expr,
  ]

/-- Access the left conjunction input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_conj_left_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right)).sharedRadius =
        (finite_boolean_family_fold env sharedRadius henv left).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right),
    finite_boolean_family_fold_radius_access env sharedRadius henv left,
  ]

/-- Access the right conjunction input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_conj_right_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right)).sharedRadius =
        (finite_boolean_family_fold env sharedRadius henv right).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right),
    finite_boolean_family_fold_radius_access env sharedRadius henv right,
  ]

/-- Access the left disjunction input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_disj_left_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right)).sharedRadius =
        (finite_boolean_family_fold env sharedRadius henv left).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right),
    finite_boolean_family_fold_radius_access env sharedRadius henv left,
  ]

/-- Access the right disjunction input shared radius through the expression-indexed fold. -/
theorem finite_boolean_family_fold_disj_right_shared_radius_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right)).sharedRadius =
        (finite_boolean_family_fold env sharedRadius henv right).sharedRadius := by
  rw [
    finite_boolean_family_fold_radius_access env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right),
    finite_boolean_family_fold_radius_access env sharedRadius henv right,
  ]



/- Finite Boolean fold expression-indexed target-fragment input access lemmas. -/

/-- Access the atom input target fragment through the expression-indexed fold. -/
theorem finite_boolean_family_fold_atom_target_fragment_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (i : ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.atom i)).target.fragment =
        (env i).target.fragment := by
  rfl

/-- Access the negation input target fragment through the expression-indexed fold. -/
theorem finite_boolean_family_fold_neg_target_fragment_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.neg expr)).target.fragment =
        neg_shared_radius_target_family_fragment
          (finite_boolean_family_fold env sharedRadius henv expr) := by
  rfl

/-- Access the conjunction input target fragment through the expression-indexed fold. -/
theorem finite_boolean_family_fold_conj_target_fragment_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
    let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
    let P : SharedRadiusTargetFamilyPair M n :=
      { left := F₁.1
        right := F₂.1
        same_shared_radius := by rw [F₁.2, F₂.2] }
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right)).target.fragment =
        conj_shared_radius_target_family_fragment P := by
  rfl

/-- Access the disjunction input target fragment through the expression-indexed fold. -/
theorem finite_boolean_family_fold_disj_target_fragment_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι) :
    let F₁ := finite_boolean_family_fold_with_radius env sharedRadius henv left
    let F₂ := finite_boolean_family_fold_with_radius env sharedRadius henv right
    let P : SharedRadiusTargetFamilyPair M n :=
      { left := F₁.1
        right := F₂.1
        same_shared_radius := by rw [F₁.2, F₂.2] }
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right)).target.fragment =
        disj_shared_radius_target_family_fragment P := by
  rfl



/- Finite Boolean fold expression-indexed target-locality input access lemmas. -/

/-- Access the atom target-locality input through the expression-indexed fold. -/
theorem finite_boolean_family_fold_atom_target_locality_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (i : ι)
    (φ : Formula σ n)
    (hφ : (env i).target.fragment.member φ) :
    UnguardedFOLocalityInputSurface M φ
      (finite_boolean_family_fold env sharedRadius henv
        (FiniteBooleanFamilyExpr.atom i)).sharedRadius := by
  simpa [finite_boolean_family_fold_atom_constructor_access] using
    (env i).constructs_at_shared_radius φ hφ

/-- Access the negation target-locality input through the expression-indexed fold. -/
theorem finite_boolean_family_fold_neg_target_locality_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι)
    (φ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv expr).target.fragment.member φ) :
    UnguardedFOLocalityInputSurface M (Formula.neg φ)
      (finite_boolean_family_fold env sharedRadius henv
        (FiniteBooleanFamilyExpr.neg expr)).sharedRadius := by
  exact
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.neg expr)).constructs_at_shared_radius
        (Formula.neg φ)
        (finite_boolean_family_fold_neg_fragment_member
          env sharedRadius henv expr φ hφ)

/-- Access the conjunction target-locality input through the expression-indexed fold. -/
theorem finite_boolean_family_fold_conj_target_locality_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι)
    (φ ψ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv left).target.fragment.member φ)
    (hψ :
      (finite_boolean_family_fold env sharedRadius henv right).target.fragment.member ψ) :
    UnguardedFOLocalityInputSurface M (Formula.conj φ ψ)
      (finite_boolean_family_fold env sharedRadius henv
        (FiniteBooleanFamilyExpr.conj left right)).sharedRadius := by
  exact
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.conj left right)).constructs_at_shared_radius
        (Formula.conj φ ψ)
        (finite_boolean_family_fold_conj_fragment_member
          env sharedRadius henv left right φ ψ hφ hψ)

/-- Access the disjunction target-locality input through the expression-indexed fold. -/
theorem finite_boolean_family_fold_disj_target_locality_input_access
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (left right : FiniteBooleanFamilyExpr ι)
    (φ ψ : Formula σ n)
    (hφ :
      (finite_boolean_family_fold env sharedRadius henv left).target.fragment.member φ)
    (hψ :
      (finite_boolean_family_fold env sharedRadius henv right).target.fragment.member ψ) :
    UnguardedFOLocalityInputSurface M (Formula.disj φ ψ)
      (finite_boolean_family_fold env sharedRadius henv
        (FiniteBooleanFamilyExpr.disj left right)).sharedRadius := by
  exact
    (finite_boolean_family_fold env sharedRadius henv
      (FiniteBooleanFamilyExpr.disj left right)).constructs_at_shared_radius
        (Formula.disj φ ψ)
        (finite_boolean_family_fold_disj_fragment_member
          env sharedRadius henv left right φ ψ hφ hψ)



/- Compact finite Boolean fold expression-indexed access rollup. -/

/-- Compact access rollup for the expression-indexed finite Boolean fold. -/
theorem finite_boolean_family_fold_access_rollup
    {σ : RelLanguage}
    {M : RelStructure σ}
    {n : Nat}
    {ι : Type}
    (env : ι -> SharedRadiusTargetFamily M n)
    (sharedRadius : Nat)
    (henv : ∀ i, (env i).sharedRadius = sharedRadius)
    (expr : FiniteBooleanFamilyExpr ι) :
    (finite_boolean_family_fold env sharedRadius henv expr).sharedRadius = sharedRadius ∧
    (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1 =
      finite_boolean_family_fold env sharedRadius henv expr ∧
    (finite_boolean_family_fold env sharedRadius henv expr).target =
      (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1.target ∧
    (finite_boolean_family_fold env sharedRadius henv expr).target.fragment =
      (finite_boolean_family_fold_with_radius env sharedRadius henv expr).1.target.fragment := by
  exact
    ⟨ finite_boolean_family_fold_radius_access env sharedRadius henv expr
    , finite_boolean_family_fold_with_radius_value_access env sharedRadius henv expr
    , finite_boolean_family_fold_target_access env sharedRadius henv expr
    , finite_boolean_family_fold_target_fragment_access env sharedRadius henv expr
    ⟩

end UnguardedFO
end FMT
end CSLIB
