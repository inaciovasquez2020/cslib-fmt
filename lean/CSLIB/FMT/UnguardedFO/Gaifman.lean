/-!
# Gaifman graph and distance for arbitrary finite relational structures

This module adds the second general-FMT frontier layer after unguarded
first-order syntax and semantics.

It defines relation-tuple incidence, Gaifman adjacency, Gaifman walks,
bounded Gaifman distance, connectedness, and a finite relational-structure
wrapper.

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

/-- Same-relation-tuple incidence is symmetric. -/
theorem same_relation_tuple_symmetric {σ : RelLanguage} (M : RelStructure σ)
    {x y : M.carrier} :
    SameRelationTuple M x y → SameRelationTuple M y x := by
  intro h
  rcases h with ⟨R, tuple, hrel, hx, hy⟩
  exact ⟨R, tuple, hrel, hy, hx⟩

/--
Gaifman adjacency: two distinct elements occur together in some interpreted
relation tuple.
-/
def GaifmanAdjacent {σ : RelLanguage} (M : RelStructure σ)
    (x y : M.carrier) : Prop :=
  x ≠ y ∧ SameRelationTuple M x y

/-- Gaifman adjacency is symmetric. -/
theorem gaifman_adjacent_symmetric {σ : RelLanguage} (M : RelStructure σ)
    {x y : M.carrier} :
    GaifmanAdjacent M x y → GaifmanAdjacent M y x := by
  intro h
  rcases h with ⟨hne, hsame⟩
  exact ⟨Ne.symm hne, same_relation_tuple_symmetric M hsame⟩

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

/-- Two elements are connected in the Gaifman graph. -/
def GaifmanConnected {σ : RelLanguage} (M : RelStructure σ)
    (x y : M.carrier) : Prop :=
  ∃ n : Nat, GaifmanWalk M x y n

/-- Every element has Gaifman distance at most any radius from itself. -/
theorem gaifman_distanceLe_refl {σ : RelLanguage} (M : RelStructure σ)
    (x : M.carrier) (r : Nat) :
    GaifmanDistanceLe M x x r := by
  exact ⟨0, Nat.zero_le r, GaifmanWalk.nil x⟩

/-- Every element is Gaifman-connected to itself. -/
theorem gaifman_connected_refl {σ : RelLanguage} (M : RelStructure σ)
    (x : M.carrier) :
    GaifmanConnected M x x := by
  exact ⟨0, GaifmanWalk.nil x⟩

/-- A finite relational structure, represented by a list covering the carrier. -/
structure FiniteRelStructure (σ : RelLanguage) where
  toRelStructure : RelStructure σ
  carrierList : List toRelStructure.carrier
  carrier_mem : ∀ x : toRelStructure.carrier, x ∈ carrierList

/-- Gaifman adjacency for a finite relational structure. -/
def FiniteRelStructure.gaifmanAdjacent {σ : RelLanguage}
    (M : FiniteRelStructure σ)
    (x y : M.toRelStructure.carrier) : Prop :=
  GaifmanAdjacent M.toRelStructure x y

/-- Bounded Gaifman distance for a finite relational structure. -/
def FiniteRelStructure.gaifmanDistanceLe {σ : RelLanguage}
    (M : FiniteRelStructure σ)
    (x y : M.toRelStructure.carrier) (r : Nat) : Prop :=
  GaifmanDistanceLe M.toRelStructure x y r

/-- Reflexivity of bounded Gaifman distance for finite relational structures. -/
theorem finite_gaifman_distanceLe_refl {σ : RelLanguage}
    (M : FiniteRelStructure σ)
    (x : M.toRelStructure.carrier) (r : Nat) :
    M.gaifmanDistanceLe x x r := by
  exact gaifman_distanceLe_refl M.toRelStructure x r

end UnguardedFO
end FMT
end CSLIB
