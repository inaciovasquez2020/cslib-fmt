import CSLIB.FMT.UnguardedFO.FiniteCycleLocal
import CSLIB.FMT.UnguardedFO.ImportedSharpCliqueEntropy
import CSLIB.FMT.UnguardedFO.ImportedLogicalEntropyEstimator

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

/-- Actual indexed oriented edge chains of the same cyclic logical carrier,
with the span of closed-one-ball-supported circulations as observations. -/
def cyclePresentation (K : Type) [Field K] (c L : Nat) [NeZero L] :
    GraphChainPresentation K (CycleVertex c L) (CycleVertex c L) where
  boundary := cycleBoundary K c L
  localCycles := cycleLocalSpace K c L

theorem cycleObservation_finrank (K : Type) [Field K] (c L : Nat) [NeZero L]
    (hL : 4 ≤ L) :
    Module.finrank K (LinearMap.ker (graphObservation (cyclePresentation K c L))) = c := by
  rw [graphObservation_hidden_finrank]
  change Module.finrank K (LinearMap.ker (cycleBoundary K c L)) -
    Module.finrank K (cycleLocalSpace K c L) = c
  rw [cycleKernel_finrank, cycleLocalSpace_eq_bot K c L hL]
  set_option synthInstance.maxHeartbeats 200000 in
    simp

/-- Actual weighted conditional Shannon entropy, not a dimension surrogate. -/
noncomputable def cycleEntropy (K : Type) [Field K] [Fintype K]
    (c L : Nat) [NeZero L] : ℝ := by
  classical
  let G := cyclePresentation K c L
  letI : Finite (graphCycles G) := Finite.of_injective (fun z : graphCycles G => z.val) Subtype.val_injective
  letI : Finite (Module.Dual K (graphCycles G)) :=
    Finite.of_injective (fun f : Module.Dual K (graphCycles G) => (fun x => f x))
      (by intro f g h; ext x; exact congrFun h x)
  letI : Fintype (Module.Dual K (graphCycles G)) := Fintype.ofFinite _
  letI : Fintype (Module.Dual K G.localCycles) := Fintype.ofFinite _
  exact ∑ y : Module.Dual K G.localCycles,
    observedMass (uniformFiniteProbability _).mass (graphObservation G) y *
    finiteEntropy (conditionalMass (uniformFiniteProbability _).mass (graphObservation G) y)

theorem cycleEntropy_exact (K : Type) [Field K] [Fintype K]
    (c L : Nat) [NeZero L] (hL : 4 ≤ L) :
    cycleEntropy K c L = (c : ℝ) * Real.log (Fintype.card K) := by
  classical
  unfold cycleEntropy
  let G := cyclePresentation K c L
  letI : Finite (graphCycles G) := Finite.of_injective (fun z : graphCycles G => z.val) Subtype.val_injective
  letI : Finite (Module.Dual K (graphCycles G)) :=
    Finite.of_injective (fun f : Module.Dual K (graphCycles G) => (fun x => f x))
      (by intro f g h; ext x; exact congrFun h x)
  letI : Fintype (Module.Dual K (graphCycles G)) := Fintype.ofFinite _
  letI : Fintype (Module.Dual K G.localCycles) := Fintype.ofFinite _
  letI : Fintype (LinearMap.ker (graphObservation G)) := Fintype.ofFinite _
  calc
    _ = Real.log (Fintype.card (LinearMap.ker (graphObservation G))) := by
      simpa only [← Nat.card_eq_fintype_card] using
        linear_uniform_conditional_entropy_exact_candidate (graphObservation G)
    _ = Real.log ((Fintype.card K ^ c : Nat) : ℝ) := by
      have h := Module.card_eq_pow_finrank (K := K)
        (V := ↥(LinearMap.ker (graphObservation G)))
      rw [cycleObservation_finrank K c L hL] at h
      rw [h]
    _ = _ := by rw [Nat.cast_pow, Real.log_pow]

/-- Positive lengths, with the bound required by the EF strategy. -/
def witnessLength (r : Nat) : Nat :=
  ((r : Int) * (2 * shiftRadius r + 1) + shiftRadius r + 4).toNat

theorem witnessLength_bounds (r : Nat) :
    4 ≤ witnessLength r ∧
    shiftRadius r < (witnessLength r : Int) ∧
    (r : Int) * (2 * shiftRadius r + 1) < (witnessLength r : Int) := by
  have hp := shiftRadius_pos r
  have hn : 0 ≤ (r : Int) * (2 * shiftRadius r + 1) :=
    mul_nonneg (by omega) (by omega)
  unfold witnessLength
  have ht : 0 ≤ (r : Int) * (2 * shiftRadius r + 1) + shiftRadius r + 4 := by omega
  rw [Int.toNat_of_nonneg ht]
  omega

/-- Finite cyclic systems with positive length; no entropy parameter or
logical equivalence is postulated as part of an instance. -/
structure CycleParameters where
  components : Nat
  length : Nat
  positiveLength : 0 < length

instance (p : CycleParameters) : NeZero p.length :=
  ⟨Nat.ne_of_gt p.positiveLength⟩

def cycleStructure (p : CycleParameters) : RelStructure shiftGraphLanguage :=
  shiftGraph (cycleShift p.components p.length)

noncomputable def cycleDeficit (K : Type) [Field K] [Fintype K]
    (p : CycleParameters) : ℝ := cycleEntropy K p.components p.length

def cycleOrder (p : CycleParameters) : Nat := p.components * p.length

theorem cycleOrder_eq_card (p : CycleParameters) :
    Fintype.card (CycleVertex p.components p.length) = cycleOrder p := by
  simp [CycleVertex, cycleOrder, Fintype.card_prod, ZMod.card]

/-- Arbitrary gap m log |K| at every finite quantifier rank, with equal order. -/
theorem logicalEntropy_witnesses (K : Type) [Field K] [Fintype K] (r m : Nat) :
    ∃ G H : CycleParameters,
      4 ≤ G.length ∧ 4 ≤ H.length ∧
      cycleOrder G = cycleOrder H ∧
      RankEquivalent (cycleStructure G) (cycleStructure H) r ∧
      cycleDeficit K H - cycleDeficit K G = (m : ℝ) * Real.log (Fintype.card K) := by
  let L := witnessLength r
  obtain ⟨hL, hr, hs⟩ := witnessLength_bounds r
  have hp : 0 < L := by omega
  have hm : 0 < (m+1 : Nat) := by omega
  let G : CycleParameters := ⟨1, (m+1)*L, Nat.mul_pos hm hp⟩
  let H : CycleParameters := ⟨m+1, L, hp⟩
  have hLG : 4 ≤ G.length := by
    change 4 ≤ (m+1)*L
    have hle : L ≤ (m+1)*L := by
      simpa using Nat.mul_le_mul_right L (show 1 ≤ m+1 by omega)
    omega
  refine ⟨G,H,hLG,hL,?_,?_,?_⟩
  · simp [cycleOrder,G,H]
  · exact oneCycle_manyCycles_rankEquivalent (m+1) L r (by omega) hL hr hs
  · change cycleEntropy K (m+1) L - cycleEntropy K 1 ((m+1)*L) = _
    rw [cycleEntropy_exact K _ _ hL, cycleEntropy_exact K _ _ hLG]
    push_cast
    ring

/-- Estimator impossibility for arbitrary rank-invariant real-valued estimators
on the cyclic family, with an explicit unbounded gap parameter. -/
theorem logicalEntropy_estimator_lower_bound (K : Type) [Field K] [Fintype K]
    (r m : Nat) (A : CycleParameters → ℝ)
    (hInv : ∀ G H, RankEquivalent (cycleStructure G) (cycleStructure H) r → A G = A H) :
    ∃ G H : CycleParameters,
      cycleOrder G = cycleOrder H ∧
      RankEquivalent (cycleStructure G) (cycleStructure H) r ∧
      (m : ℝ) * Real.log (Fintype.card K) / 2 ≤
        max |A G - cycleDeficit K G| |A H - cycleDeficit K H| := by
  obtain ⟨G,H,_,_,he,hr,hgap⟩ := logicalEntropy_witnesses K r m
  refine ⟨G,H,he,hr,?_⟩
  apply LogicalEntropy.entropy_gap_lower_bound
    (fun G H => RankEquivalent (cycleStructure G) (cycleStructure H) r)
    (cycleDeficit K) A hInv G H hr _ _ (by positivity) ?_ hgap
  exact_mod_cast Fintype.card_pos (α := K)

#print axioms cycleObservation_finrank
#print axioms cycleEntropy_exact
#print axioms witnessLength_bounds
#print axioms cycleOrder_eq_card
#print axioms logicalEntropy_witnesses
#print axioms logicalEntropy_estimator_lower_bound

end CSLIB.FMT.UnguardedFO
