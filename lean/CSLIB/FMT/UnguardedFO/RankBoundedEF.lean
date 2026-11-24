import CSLIB.FMT.UnguardedFO.SyntaxSemantics

namespace CSLIB.FMT.UnguardedFO

/-- Quantifier rank, with Boolean operations costing no rounds. -/
def quantifierRank {σ : RelLanguage} {n : Nat} : Formula σ n → Nat
  | .top | .bot | .eq _ _ | .rel _ _ => 0
  | .neg φ => quantifierRank φ
  | .conj φ ψ | .disj φ ψ => max (quantifierRank φ) (quantifierRank ψ)
  | .ex φ => Nat.succ (quantifierRank φ)

/-- Equality and all relation atoms agree across two structures. -/
def AtomicAgreement {σ : RelLanguage} (M N : RelStructure σ)
    {n : Nat} (ρ : Fin n → M.carrier) (τ : Fin n → N.carrier) : Prop :=
  (∀ i j, (ρ i = ρ j ↔ τ i = τ j)) ∧
  (∀ (R : σ.Rel) (args : Fin (σ.arity R) → Fin n),
    M.interp R (fun i => ρ (args i)) ↔ N.interp R (fun i => τ (args i)))

/-- Duplicator's bounded back-and-forth winning condition.
The budget decreases on every extension; no unrestricted extension is assumed. -/
def RankBackAndForth {σ : RelLanguage} (M N : RelStructure σ) :
    (r : Nat) → {n : Nat} → (Fin n → M.carrier) → (Fin n → N.carrier) → Prop
  | 0, _, ρ, τ => AtomicAgreement M N ρ τ
  | r+1, _, ρ, τ =>
      AtomicAgreement M N ρ τ ∧
      (∀ x : M.carrier, ∃ y : N.carrier,
        RankBackAndForth M N r (extendAssignment ρ x) (extendAssignment τ y)) ∧
      (∀ y : N.carrier, ∃ x : M.carrier,
        RankBackAndForth M N r (extendAssignment ρ x) (extendAssignment τ y))

theorem rankBackAndForth_atomic {σ : RelLanguage} {M N : RelStructure σ}
    {r n : Nat} {ρ : Fin n → M.carrier} {τ : Fin n → N.carrier}
    (h : RankBackAndForth M N r ρ τ) : AtomicAgreement M N ρ τ := by
  cases r with
  | zero => exact h
  | succ r => exact h.1

/-- Soundness of the finite-round back-and-forth condition for actual FO semantics. -/
theorem rankBackAndForth_preserves_formula {σ : RelLanguage}
    (M N : RelStructure σ) {n : Nat} (φ : Formula σ n)
    {r : Nat} {ρ : Fin n → M.carrier} {τ : Fin n → N.carrier}
    (hr : quantifierRank φ ≤ r) (h : RankBackAndForth M N r ρ τ) :
    Holds M ρ φ ↔ Holds N τ φ := by
  induction φ generalizing r with
  | top => exact Iff.rfl
  | bot => exact Iff.rfl
  | eq i j => exact (rankBackAndForth_atomic h).1 i j
  | rel R args => exact (rankBackAndForth_atomic h).2 R args
  | neg φ ih =>
      change (¬ Holds M ρ φ) ↔ (¬ Holds N τ φ)
      exact not_congr (ih hr h)
  | conj φ ψ ihφ ihψ =>
      change (Holds M ρ φ ∧ Holds M ρ ψ) ↔
        (Holds N τ φ ∧ Holds N τ ψ)
      exact and_congr
        (ihφ (Nat.le_trans (Nat.le_max_left _ _) hr) h)
        (ihψ (Nat.le_trans (Nat.le_max_right _ _) hr) h)
  | disj φ ψ ihφ ihψ =>
      change (Holds M ρ φ ∨ Holds M ρ ψ) ↔
        (Holds N τ φ ∨ Holds N τ ψ)
      exact or_congr
        (ihφ (Nat.le_trans (Nat.le_max_left _ _) hr) h)
        (ihψ (Nat.le_trans (Nat.le_max_right _ _) hr) h)
  | ex φ ih =>
      cases r with
      | zero => exact False.elim (Nat.not_succ_le_zero _ hr)
      | succ r =>
          have hb : quantifierRank φ ≤ r := Nat.le_of_succ_le_succ hr
          change (∃ x : M.carrier, Holds M (extendAssignment ρ x) φ) ↔
            (∃ y : N.carrier, Holds N (extendAssignment τ y) φ)
          constructor
          · rintro ⟨x, hx⟩
            obtain ⟨y, hy⟩ := h.2.1 x
            exact ⟨y, (ih hb hy).mp hx⟩
          · rintro ⟨y, hy⟩
            obtain ⟨x, hx⟩ := h.2.2 y
            exact ⟨x, (ih hb hx).mpr hy⟩

def RankEquivalent {σ : RelLanguage} (M N : RelStructure σ) (r : Nat) : Prop :=
  ∀ φ : Sentence σ, quantifierRank φ ≤ r → (Satisfies M φ ↔ Satisfies N φ)

theorem rankBackAndForth_implies_rankEquivalent {σ : RelLanguage}
    (M N : RelStructure σ) (r : Nat)
    (h : RankBackAndForth M N r emptyAssignment emptyAssignment) :
    RankEquivalent M N r := by
  intro φ hr
  exact rankBackAndForth_preserves_formula M N φ hr h

#print axioms rankBackAndForth_atomic
#print axioms rankBackAndForth_preserves_formula
#print axioms rankBackAndForth_implies_rankEquivalent

end CSLIB.FMT.UnguardedFO
