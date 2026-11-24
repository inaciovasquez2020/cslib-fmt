import Mathlib
import CSLIB.FMT.UnguardedFO.ShiftSystemEF

namespace CSLIB.FMT.UnguardedFO

/-- c copies of the cyclic translation system of length L. -/
def cycleShift (c L : Nat) : ShiftSystem where
  carrier := Fin c × ZMod L
  shift := fun d x => (x.1, (d : ZMod L) + x.2)
  shift_zero := by intro x; simp
  shift_add := by intro a b x; simp [Int.cast_add, add_assoc]

theorem cycleShift_free (c L : Nat) (t : Int) (hL : t < (L : Int)) :
    FreeAt (cycleShift c L) t := by
  intro x d hdlo hdhi
  constructor
  · intro h
    have he : (d : ZMod L) + x.2 = x.2 := congrArg Prod.snd h
    have hz : (d : ZMod L) = 0 := by
      exact add_right_cancel (he.trans (zero_add x.2).symm)
    have hv := (ZMod.intCast_zmod_eq_zero_iff_dvd d L).mp hz
    by_cases hp : 0 ≤ d
    · exact Int.eq_zero_of_dvd_of_nonneg_of_lt hp (by omega) hv
    · have hn : -d = 0 := Int.eq_zero_of_dvd_of_nonneg_of_lt
        (by omega) (by omega) (dvd_neg.mpr hv)
      omega
  · intro h
    subst d
    exact (cycleShift c L).shift_zero x

/-- Counting the image of the forbidden signed-displacement domain. -/
theorem cycleShift_fresh (c L n : Nat) [NeZero L] (t : Int)
    (ht : 0 ≤ t)
    (hcard : (n : Int) * (2*t+1) < (c : Int) * (L : Int)) :
    FreshAt (cycleShift c L) n t := by
  classical
  intro ρ
  let f : Fin n × Set.Icc (-t) t → Fin c × ZMod L :=
    fun p => (cycleShift c L).shift p.2.val (ρ p.1)
  by_contra hn
  push_neg at hn
  have hs : Function.Surjective f := by
    intro y
    obtain ⟨i,d,hl,hu,he⟩ := hn y
    exact ⟨(i, ⟨d, hl, hu⟩), he⟩
  have hc := Fintype.card_le_of_surjective f hs
  rw [Fintype.card_prod, Fintype.card_prod, Fintype.card_fin,
    Fintype.card_fin, ZMod.card] at hc
  have hi : (Fintype.card (Set.Icc (-t) t) : Int) = 2*t+1 := by
    rw [Int.card_fintype_Icc_of_le (a := -t) (b := t) (by omega)]
    omega
  have hh : (c : Int) * (L : Int) ≤
      (n : Int) * (Fintype.card (Set.Icc (-t) t) : Int) := by
    exact_mod_cast hc
  rw [hi] at hh
  omega

theorem shiftRadius_mono {s r : Nat} (h : s ≤ r) :
    shiftRadius s ≤ shiftRadius r := by
  induction r with
  | zero => have he : s = 0 := by omega
            simp [he]
  | succ r ih =>
      by_cases he : s = r+1
      · simp [he]
      · have hb : s ≤ r := by omega
        have hp := shiftRadius_pos r
        have hm := ih hb
        change shiftRadius s ≤ shiftRadius r + shiftRadius r
        omega

/-- The bound is an explicit size inequality, not a logical-equivalence hypothesis. -/
theorem cycleShift_rankEquivalent (c L C M r : Nat)
    [NeZero L] [NeZero M]
    (hL : shiftRadius r < (L : Int))
    (hM : shiftRadius r < (M : Int))
    (hc : (r : Int) * (2*shiftRadius r+1) < (c : Int)*(L : Int))
    (hC : (r : Int) * (2*shiftRadius r+1) < (C : Int)*(M : Int)) :
    RankEquivalent (shiftGraph (cycleShift c L)) (shiftGraph (cycleShift C M)) r := by
  apply shiftGraphs_rankEquivalent
  · intro s hs
    exact cycleShift_free c L _ (lt_of_le_of_lt (shiftRadius_mono hs) hL)
  · intro s hs
    exact cycleShift_free C M _ (lt_of_le_of_lt (shiftRadius_mono hs) hM)
  · intro n s hs
    have hm := shiftRadius_mono (show s ≤ r by omega)
    have hp := shiftRadius_pos s
    have hn : (n : Int) ≤ (r : Int) := by omega
    have hnn : 0 ≤ (n : Int) := by omega
    have hrr : 0 ≤ (r : Int) := by omega
    apply cycleShift_fresh c L n _ (by omega)
    calc
      (n : Int)*(2*shiftRadius s+1) ≤ (r : Int)*(2*shiftRadius s+1) :=
        mul_le_mul_of_nonneg_right hn (by omega)
      _ ≤ (r : Int)*(2*shiftRadius r+1) :=
        mul_le_mul_of_nonneg_left (by omega) hrr
      _ < _ := hc
  · intro n s hs
    have hm := shiftRadius_mono (show s ≤ r by omega)
    have hp := shiftRadius_pos s
    have hn : (n : Int) ≤ (r : Int) := by omega
    have hrr : 0 ≤ (r : Int) := by omega
    apply cycleShift_fresh C M n _ (by omega)
    calc
      (n : Int)*(2*shiftRadius s+1) ≤ (r : Int)*(2*shiftRadius s+1) :=
        mul_le_mul_of_nonneg_right hn (by omega)
      _ ≤ (r : Int)*(2*shiftRadius r+1) :=
        mul_le_mul_of_nonneg_left (by omega) hrr
      _ < _ := hC

/-- Equal-order one-cycle versus c-cycle separation, for every sufficiently large length. -/
theorem oneCycle_manyCycles_rankEquivalent (c L r : Nat)
    (hc : 1 ≤ c) (hL : 4 ≤ L)
    (hr : shiftRadius r < (L : Int))
    (hsize : (r : Int)*(2*shiftRadius r+1) < (L : Int)) :
    RankEquivalent (shiftGraph (cycleShift 1 (c*L))) (shiftGraph (cycleShift c L)) r := by
  have hp : 0 < L := by omega
  have hcp : 0 < c := by omega
  letI : NeZero L := ⟨by omega⟩
  letI : NeZero (c*L) := ⟨Nat.ne_of_gt (Nat.mul_pos hcp hp)⟩
  have hle : L ≤ c*L := by
    simpa using Nat.mul_le_mul_right L hc
  have hlei : (L : Int) ≤ (c : Int)*(L : Int) := by exact_mod_cast hle
  apply cycleShift_rankEquivalent
  · push_cast
    omega
  · exact hr
  · push_cast
    omega
  · omega

#print axioms cycleShift_free
#print axioms cycleShift_fresh
#print axioms cycleShift_rankEquivalent
#print axioms oneCycle_manyCycles_rankEquivalent

end CSLIB.FMT.UnguardedFO
