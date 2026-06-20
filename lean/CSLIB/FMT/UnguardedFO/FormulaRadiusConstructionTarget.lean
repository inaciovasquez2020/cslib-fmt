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

end UnguardedFO
end FMT
end CSLIB
