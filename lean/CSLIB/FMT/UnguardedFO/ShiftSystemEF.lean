import CSLIB.FMT.UnguardedFO.RankBoundedEF

namespace CSLIB.FMT.UnguardedFO

/-- Integer translations; finite oriented cycles are intended instances. -/
structure ShiftSystem where
  carrier : Type
  shift : Int → carrier → carrier
  shift_zero : ∀ x, shift 0 x = x
  shift_add : ∀ a b x, shift a (shift b x) = shift (a+b) x

def shiftRadius : Nat → Int
  | 0 => 1
  | r+1 => shiftRadius r + shiftRadius r

theorem shiftRadius_pos (r : Nat) : 1 ≤ shiftRadius r := by
  induction r with
  | zero => decide
  | succ r ih =>
      change 1 ≤ shiftRadius r + shiftRadius r
      omega

def FreeAt (A : ShiftSystem) (t : Int) : Prop :=
  ∀ x d, -t ≤ d → d ≤ t → (A.shift d x = x ↔ d = 0)

def FreshAt (A : ShiftSystem) (n : Nat) (t : Int) : Prop :=
  ∀ ρ : Fin n → A.carrier, ∃ x : A.carrier,
    ∀ i d, -t ≤ d → d ≤ t → A.shift d (ρ i) ≠ x

def ShiftAgreement (A B : ShiftSystem) {n : Nat}
    (ρ : Fin n → A.carrier) (τ : Fin n → B.carrier) (t : Int) : Prop :=
  ∀ i j d, -t ≤ d → d ≤ t →
    (A.shift d (ρ i) = ρ j ↔ B.shift d (τ i) = τ j)

theorem ShiftAgreement.symm {A B : ShiftSystem} {n : Nat}
    {ρ : Fin n → A.carrier} {τ : Fin n → B.carrier} {t : Int}
    (h : ShiftAgreement A B ρ τ t) : ShiftAgreement B A τ ρ t := by
  intro i j d hl hu
  exact (h i j d hl hu).symm

theorem shift_target_iff (A : ShiftSystem) (a d : Int) (u v : A.carrier) :
    A.shift d u = A.shift a v ↔ A.shift (-a+d) u = v := by
  constructor
  · intro h
    calc
      A.shift (-a+d) u = A.shift (-a) (A.shift d u) := (A.shift_add _ _ _).symm
      _ = A.shift (-a) (A.shift a v) := congrArg (A.shift (-a)) h
      _ = v := by
        rw [A.shift_add]
        have he : -a+a = 0 := by omega
        rw [he, A.shift_zero]
  · intro h
    calc
      A.shift d u = A.shift a (A.shift (-a+d) u) := by
        rw [A.shift_add]
        have he : a+(-a+d) = d := by omega
        rw [he]
      _ = A.shift a v := congrArg (A.shift a) h

theorem shift_reverse (A : ShiftSystem) (d : Int) (u v : A.carrier) :
    A.shift d u = v ↔ A.shift (-d) v = u := by
  have h := shift_target_iff A d 0 v u
  rw [A.shift_zero] at h
  have he : -d + 0 = -d := by omega
  rw [he] at h
  exact (eq_comm : A.shift d u = v ↔ v = A.shift d u).trans h

theorem extend_shiftAgreement (A B : ShiftSystem) {n : Nat}
    (ρ : Fin n → A.carrier) (τ : Fin n → B.carrier)
    (x : A.carrier) (y : B.carrier) (t : Int)
    (ht : 0 ≤ t)
    (h : ShiftAgreement A B ρ τ (t+t))
    (fa : FreeAt A t) (fb : FreeAt B t)
    (hn : ∀ i d, -t ≤ d → d ≤ t →
      (A.shift d (ρ i) = x ↔ B.shift d (τ i) = y)) :
    ShiftAgreement A B (extendAssignment ρ x) (extendAssignment τ y) t := by
  intro i j d hl hu
  refine Fin.cases ?_ (fun i => ?_) i
  · refine Fin.cases ?_ (fun j => ?_) j
    · change (A.shift d x = x ↔ B.shift d y = y)
      exact (fa x d hl hu).trans (fb y d hl hu).symm
    · change (A.shift d x = ρ j ↔ B.shift d y = τ j)
      exact (shift_reverse A d x (ρ j)).trans
        ((hn j (-d) (by omega) (by omega)).trans
          (shift_reverse B d y (τ j)).symm)
  · refine Fin.cases ?_ (fun j => ?_) j
    · change (A.shift d (ρ i) = x ↔ B.shift d (τ i) = y)
      exact hn i d hl hu
    · change (A.shift d (ρ i) = ρ j ↔ B.shift d (τ i) = τ j)
      exact h i j d (by omega) (by omega)

/-- The near/far extension lemma. Freshness is needed only in the response system. -/
theorem shiftAgreement_forward (A B : ShiftSystem) {n : Nat}
    (ρ : Fin n → A.carrier) (τ : Fin n → B.carrier)
    (t : Int) (ht : 0 ≤ t)
    (h : ShiftAgreement A B ρ τ (t+t))
    (fa : FreeAt A t) (fb : FreeAt B t) (fresh : FreshAt B n t)
    (x : A.carrier) :
    ∃ y : B.carrier, ShiftAgreement A B
      (extendAssignment ρ x) (extendAssignment τ y) t := by
  classical
  by_cases near : ∃ i : Fin n, ∃ a : Int, -t ≤ a ∧ a ≤ t ∧ A.shift a (ρ i) = x
  · obtain ⟨i, a, al, au, ha⟩ := near
    refine ⟨B.shift a (τ i), ?_⟩
    apply extend_shiftAgreement A B ρ τ x (B.shift a (τ i)) t ht h fa fb
    intro j d dl du
    rw [← ha]
    exact (shift_target_iff A a d (ρ j) (ρ i)).trans
      ((h j i (-a+d) (by omega) (by omega)).trans
        (shift_target_iff B a d (τ j) (τ i)).symm)
  · obtain ⟨y, hy⟩ := fresh τ
    refine ⟨y, ?_⟩
    apply extend_shiftAgreement A B ρ τ x y t ht h fa fb
    intro j d dl du
    exact ⟨fun he => False.elim (near ⟨j, d, dl, du, he⟩),
      fun he => False.elim (hy j d dl du he)⟩

abbrev shiftGraphLanguage : RelLanguage := ⟨Unit, fun _ => 2⟩

def shiftGraph (A : ShiftSystem) : RelStructure shiftGraphLanguage where
  carrier := A.carrier
  interp := fun _ a => A.shift 1 (a 0) = a 1 ∨ A.shift (-1) (a 0) = a 1

theorem shiftAgreement_atomic (A B : ShiftSystem) {n : Nat}
    {ρ : Fin n → A.carrier} {τ : Fin n → B.carrier} {t : Int}
    (ht : 1 ≤ t) (h : ShiftAgreement A B ρ τ t) :
    AtomicAgreement (shiftGraph A) (shiftGraph B) ρ τ := by
  constructor
  · intro i j
    have hz := h i j 0 (by omega) (by omega)
    simpa only [A.shift_zero, B.shift_zero] using hz
  · intro R args
    change (A.shift 1 (ρ (args 0)) = ρ (args 1) ∨
      A.shift (-1) (ρ (args 0)) = ρ (args 1)) ↔
      (B.shift 1 (τ (args 0)) = τ (args 1) ∨
      B.shift (-1) (τ (args 0)) = τ (args 1))
    exact or_congr (h (args 0) (args 1) 1 (by omega) (by omega))
      (h (args 0) (args 1) (-1) (by omega) (by omega))

/-- A reusable winning-strategy theorem with explicit geometric obligations.
No claim that these obligations hold for concrete cycles is made here. -/
theorem shiftAgreement_wins (A B : ShiftSystem) (budget : Nat)
    (fa : ∀ s, s ≤ budget → FreeAt A (shiftRadius s))
    (fb : ∀ s, s ≤ budget → FreeAt B (shiftRadius s))
    (freshA : ∀ n s, n+s < budget → FreshAt A n (shiftRadius s))
    (freshB : ∀ n s, n+s < budget → FreshAt B n (shiftRadius s))
    {r n : Nat} {ρ : Fin n → A.carrier} {τ : Fin n → B.carrier}
    (hbudget : n+r ≤ budget) (h : ShiftAgreement A B ρ τ (shiftRadius r)) :
    RankBackAndForth (shiftGraph A) (shiftGraph B) r ρ τ := by
  induction r generalizing n with
  | zero =>
      exact shiftAgreement_atomic A B (shiftRadius_pos 0) h
  | succ r ih =>
      have ht := shiftRadius_pos r
      have hr : r ≤ budget := by omega
      have hn : n+r < budget := by omega
      change AtomicAgreement (shiftGraph A) (shiftGraph B) ρ τ ∧
        (∀ x : A.carrier, ∃ y : B.carrier,
          RankBackAndForth (shiftGraph A) (shiftGraph B) r
            (extendAssignment ρ x) (extendAssignment τ y)) ∧
        (∀ y : B.carrier, ∃ x : A.carrier,
          RankBackAndForth (shiftGraph A) (shiftGraph B) r
            (extendAssignment ρ x) (extendAssignment τ y))
      refine ⟨shiftAgreement_atomic A B (shiftRadius_pos (r+1)) h, ?_, ?_⟩
      · intro x
        obtain ⟨y, hy⟩ := shiftAgreement_forward A B ρ τ (shiftRadius r)
          (by omega) h (fa r hr) (fb r hr) (freshB n r hn) x
        refine ⟨y, ?_⟩
        apply ih
        · omega
        · exact hy
      · intro y
        obtain ⟨x, hx⟩ := shiftAgreement_forward B A τ ρ (shiftRadius r)
          (by omega) h.symm (fb r hr) (fa r hr) (freshA n r hn) y
        refine ⟨x, ?_⟩
        apply ih
        · omega
        · exact hx.symm

theorem shiftGraphs_rankEquivalent (A B : ShiftSystem) (r : Nat)
    (fa : ∀ s, s ≤ r → FreeAt A (shiftRadius s))
    (fb : ∀ s, s ≤ r → FreeAt B (shiftRadius s))
    (freshA : ∀ n s, n+s < r → FreshAt A n (shiftRadius s))
    (freshB : ∀ n s, n+s < r → FreshAt B n (shiftRadius s)) :
    RankEquivalent (shiftGraph A) (shiftGraph B) r := by
  apply rankBackAndForth_implies_rankEquivalent
  apply shiftAgreement_wins A B r fa fb freshA freshB
  · omega
  · intro i
    exact Fin.elim0 i

#print axioms shiftAgreement_forward
#print axioms shiftAgreement_wins
#print axioms shiftGraphs_rankEquivalent

end CSLIB.FMT.UnguardedFO
