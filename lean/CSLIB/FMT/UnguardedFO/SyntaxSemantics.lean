/-!
# Unguarded first-order syntax and semantics

This module adds only the first general-FMT frontier layer: unguarded
first-order relational syntax, assignments, structures, and satisfaction.

It does not prove Gaifman locality, unguarded FO locality, Fagin's theorem,
the 0-1 Law, or any global finite-model-theory closure theorem.
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

/--
Unguarded first-order formulas with `n` free variables.

The constructor `ex` binds one new de Bruijn variable at index `0`, while
old variables are shifted into successor positions.
-/
inductive Formula (σ : RelLanguage) : Nat → Type where
  | top {n : Nat} : Formula σ n
  | bot {n : Nat} : Formula σ n
  | eq {n : Nat} : Fin n → Fin n → Formula σ n
  | rel {n : Nat} : (R : σ.Rel) → (Fin (σ.arity R) → Fin n) → Formula σ n
  | neg {n : Nat} : Formula σ n → Formula σ n
  | conj {n : Nat} : Formula σ n → Formula σ n → Formula σ n
  | disj {n : Nat} : Formula σ n → Formula σ n → Formula σ n
  | ex {n : Nat} : Formula σ (n + 1) → Formula σ n

/-- A sentence is a formula with no free variables. -/
abbrev Sentence (σ : RelLanguage) : Type :=
  Formula σ 0

/-- Extend an assignment by a newly-bound variable at de Bruijn index `0`. -/
def extendAssignment {α : Type} {n : Nat}
    (ρ : Fin n → α) (x : α) : Fin (n + 1) → α
  | ⟨0, _⟩ => x
  | ⟨Nat.succ i, h⟩ => ρ ⟨i, Nat.lt_of_succ_lt_succ h⟩

/-- The empty assignment for closed formulas. -/
def emptyAssignment {α : Type} : Fin 0 → α :=
  fun i => nomatch i

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

/-- Closed-formula satisfaction. -/
def Satisfies {σ : RelLanguage} (M : RelStructure σ) (φ : Sentence σ) : Prop :=
  Holds M emptyAssignment φ

@[simp] theorem holds_top {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) :
    Holds M ρ (Formula.top : Formula σ n) := by
  trivial

@[simp] theorem holds_bot {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) :
    ¬ Holds M ρ Formula.bot := by
  intro h
  exact h

@[simp] theorem holds_eq {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) (x y : Fin n) :
    Holds M ρ (Formula.eq x y) ↔ ρ x = ρ y := by
  rfl

@[simp] theorem holds_conj {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) (φ ψ : Formula σ n) :
    Holds M ρ (Formula.conj φ ψ) ↔ Holds M ρ φ ∧ Holds M ρ ψ := by
  rfl

@[simp] theorem holds_disj {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) (φ ψ : Formula σ n) :
    Holds M ρ (Formula.disj φ ψ) ↔ Holds M ρ φ ∨ Holds M ρ ψ := by
  rfl

@[simp] theorem holds_ex {σ : RelLanguage} (M : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) (φ : Formula σ (n + 1)) :
    Holds M ρ (Formula.ex φ) ↔ ∃ x : M.carrier, Holds M (extendAssignment ρ x) φ := by
  rfl

end UnguardedFO
end FMT
end CSLIB
