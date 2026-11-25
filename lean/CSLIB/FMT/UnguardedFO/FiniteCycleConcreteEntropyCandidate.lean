import CSLIB.FMT.UnguardedFO.FiniteCycleBoundedSupportCandidate

/-!
The actual finite conditional Shannon entropy for the concrete ordinary
SimpleGraph boundary and bounded-support observation model. This consumes
the separately verified rank, support, and kernel-transport declarations.
NOT_RUN until exact pinned Lean CI and axiom audit complete.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

attribute [local instance] Classical.propDecidable

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

/-- The dual-restriction observation hides exactly c dimensions when the
permitted support size is strictly less than the cycle length. -/
theorem cycleConcreteObservation_finrank (cutoff : Nat) (hcut : cutoff < L) :
    Module.finrank K (LinearMap.ker
      (graphObservation
        (concreteGraphChain (K := K) (cycleSimpleGraph c L hL) cutoff))) = c := by
  rw [graphObservation_hidden_finrank]
  change Module.finrank K
      (LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) -
    Module.finrank K
      (boundedSupportCycleSpace (K := K) (cycleSimpleGraph c L hL) cutoff) = c
  rw [cycleConcreteKernel_finrank K c L hL,
      cycleConcreteBoundedSupport_eq_bot K c L hL cutoff hcut]
  simp

/-- Actual probability-weighted finite conditional Shannon entropy on the
concrete graph observation, not a definitional cycle-rank proxy. -/
noncomputable def cycleConcreteEntropy [Fintype K] (cutoff : Nat) : ℝ := by
  classical
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
  exact ∑ y : Module.Dual K G.localCycles,
    observedMass (uniformFiniteProbability _).mass (graphObservation G) y *
      finiteEntropy (conditionalMass (uniformFiniteProbability _).mass
        (graphObservation G) y)

/-- Exact graph entropy identity in real nats for every finite field. -/
theorem cycleConcreteEntropy_exact [Fintype K]
    (cutoff : Nat) (hcut : cutoff < L) :
    cycleConcreteEntropy K c L hL cutoff =
      (c : ℝ) * Real.log (Fintype.card K) := by
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
    _ = Real.log ((Fintype.card K ^ c : Nat) : ℝ) := by
      have h := Module.card_eq_pow_finrank (K := K)
        (V := ↥(LinearMap.ker (graphObservation G)))
      rw [cycleConcreteObservation_finrank K c L hL cutoff hcut] at h
      rw [h]
    _ = _ := by rw [Nat.cast_pow, Real.log_pow]

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteObservation_finrank
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteEntropy_exact

end CSLIB.FMT.UnguardedFO
