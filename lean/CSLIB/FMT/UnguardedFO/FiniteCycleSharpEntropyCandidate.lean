import CSLIB.FMT.UnguardedFO.FiniteCycleUpperCutoffCandidate

/-!
Upper cutoff entropy branch for the concrete graph model.
The source-locked workflow must compile and check #print axioms before promotion.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

attribute [local instance] Classical.propDecidable

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

/-- Once the support cutoff includes a whole component cycle, nothing remains hidden. -/
theorem cycleConcreteObservation_finrank_zero (cutoff : Nat) (hcut : L ≤ cutoff) :
    Module.finrank K (LinearMap.ker
      (graphObservation
        (concreteGraphChain (K := K) (cycleSimpleGraph c L hL) cutoff))) = 0 := by
  rw [graphObservation_hidden_finrank]
  change Module.finrank K
      (LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) -
    Module.finrank K
      (boundedSupportCycleSpace (K := K) (cycleSimpleGraph c L hL) cutoff) = 0
  rw [cycleConcreteBoundedSupport_eq_top K c L hL cutoff hcut]
  simp

/-- Actual finite probability-weighted conditional entropy is zero above cutoff. -/
theorem cycleConcreteEntropy_upper_zero [Fintype K]
    (cutoff : Nat) (hcut : L ≤ cutoff) :
    cycleConcreteEntropy K c L hL cutoff = 0 := by
  classical
  unfold cycleConcreteEntropy
  let G := concreteGraphChain (K := K) (cycleSimpleGraph c L hL) cutoff
  letI : Finite (graphCycles G) :=
    Finite.of_injective (fun z : graphCycles G => z.val) Subtype.val_injective
  letI : Finite (Module.Dual K (graphCycles G)) :=
    Finite.of_injective (fun f : Module.Dual K (graphCycles G) => (fun x => f x))
      (by intro f g hh; ext x; exact congrFun hh x)
  letI : Fintype (Module.Dual K (graphCycles G)) := Fintype.ofFinite _
  letI : Finite G.localCycles :=
    Finite.of_injective (fun z : G.localCycles => z.val) Subtype.val_injective
  letI : Finite (Module.Dual K G.localCycles) :=
    Finite.of_injective (fun f : Module.Dual K G.localCycles => (fun x => f x))
      (by intro f g hh; ext x; exact congrFun hh x)
  letI : Fintype (Module.Dual K G.localCycles) := Fintype.ofFinite _
  letI : Fintype (LinearMap.ker (graphObservation G)) := Fintype.ofFinite _
  calc
    _ = Real.log (Fintype.card (LinearMap.ker (graphObservation G))) := by
      simpa only [← Nat.card_eq_fintype_card] using
        linear_uniform_conditional_entropy_exact_candidate (graphObservation G)
    _ = Real.log ((Fintype.card K ^ (0 : Nat) : Nat) : ℝ) := by
      have h := Module.card_eq_pow_finrank (K := K)
        (V := ↥(LinearMap.ker (graphObservation G)))
      rw [cycleConcreteObservation_finrank_zero K c L hL cutoff hcut] at h
      rw [h]
    _ = 0 := by simp

/-- The two regimes of the concrete cycle observation form a sharp threshold. -/
theorem cycleConcreteEntropy_sharp [Fintype K] (cutoff : Nat) :
    cycleConcreteEntropy K c L hL cutoff =
      if cutoff < L then (c : ℝ) * Real.log (Fintype.card K) else 0 := by
  split_ifs with h
  · exact cycleConcreteEntropy_exact K c L hL cutoff h
  · exact cycleConcreteEntropy_upper_zero K c L hL cutoff (Nat.le_of_not_gt h)

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteObservation_finrank_zero
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteEntropy_upper_zero
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteEntropy_sharp

end CSLIB.FMT.UnguardedFO
