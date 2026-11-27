import CSLIB.FMT.UnguardedFO.FiniteCycleConcreteEntropyCandidate

/-! Upper cutoff: a component coordinate circulation has support at most L,
and transported coordinate circulations span the concrete cycle kernel.
This isolated file is NOT_VERIFIED until its CI gate succeeds. -/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

attribute [local instance] Classical.propDecidable

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

private noncomputable def concreteCoordinateEquiv :
    (Fin c → K) ≃ₗ[K]
      LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)) :=
  (cycleKernelEquiv K c L).symm.trans (cycleConcreteKernelEquiv K c L hL)

private theorem coordinate_support_le (i : Fin c) (a : K) :
    (Finset.univ.filter (fun e : OrderedEdge (cycleSimpleGraph c L hL) =>
      ((concreteCoordinateEquiv K c L hL) (Pi.single i a)).val e ≠ 0)).card ≤ L := by
  classical
  let E := cycleOrderedEdgeEquiv c L hL
  let z := (concreteCoordinateEquiv K c L hL) (Pi.single i a)
  have component (e : {e : OrderedEdge (cycleSimpleGraph c L hL) // z.val e ≠ 0}) :
      (E.symm e.val).1 = i := by
    have hnonzero : z.val (E (E.symm e.val)) ≠ 0 := by
      simpa only [Equiv.apply_symm_apply] using e.property
    have hindexed := (cycleConcreteKernel_support_transport (K := K)
      c L hL z (E.symm e.val)).mp hnonzero
    rw [cycleBoundary_component_constant
      ((cycleConcreteKernelEquiv K c L hL).symm z)
      (E.symm e.val).1 (E.symm e.val).2] at hindexed
    have hq : (cycleConcreteKernelEquiv K c L hL).symm z =
        (cycleKernelEquiv K c L).symm (Pi.single i a) := by
      change (cycleConcreteKernelEquiv K c L hL).symm
        (cycleConcreteKernelEquiv K c L hL
          ((cycleKernelEquiv K c L).symm (Pi.single i a))) = _
      exact (cycleConcreteKernelEquiv K c L hL).symm_apply_apply _
    rw [hq] at hindexed
    have hcoordinate : (Pi.single i a : Fin c → K) (E.symm e.val).1 ≠ 0 := by
      change (Pi.single i a : Fin c → K) (E.symm e.val).1 ≠ 0 at hindexed
      exact hindexed
    by_contra hne
    exact hcoordinate (by simp [Pi.single_apply, hne])
  let f : {e : OrderedEdge (cycleSimpleGraph c L hL) // z.val e ≠ 0} →
      ZMod L := fun e => (E.symm e.val).2
  have hinj : Function.Injective f := by
    intro e₁ e₂ heq
    apply Subtype.ext
    apply E.symm.injective
    apply Prod.ext
    · exact (component e₁).trans (component e₂).symm
    · exact heq
  have hcard : Fintype.card
      {e : OrderedEdge (cycleSimpleGraph c L hL) // z.val e ≠ 0} ≤
      Fintype.card (ZMod L) :=
    Fintype.card_le_of_injective f hinj
  simpa only [z, Fintype.card_subtype, ZMod.card] using hcard

/-- At any edge-support cutoff at least L, component cycles span all cycles. -/
theorem cycleConcreteBoundedSupport_eq_top (cutoff : Nat) (hcut : L ≤ cutoff) :
    boundedSupportCycleSpace (K := K) (cycleSimpleGraph c L hL) cutoff = ⊤ := by
  classical
  let E := concreteCoordinateEquiv K c L hL
  let S := boundedSupportCycleSpace (K := K) (cycleSimpleGraph c L hL) cutoff
  have hsingle (i : Fin c) (a : K) : E (Pi.single i a) ∈ S := by
    apply Submodule.subset_span
    exact le_trans (coordinate_support_le K c L hL i a) hcut
  apply le_antisymm
  · exact le_top
  · intro z hz
    let a : Fin c → K := E.symm z
    have hsum : (∑ i : Fin c, Pi.single i (a i)) = a := by
      funext j
      simpa only [Finset.sum_apply] using (Fintype.sum_pi_single j a)
    have hmem : E a ∈ S := by
      rw [← hsum, map_sum]
      exact Submodule.sum_mem S (fun i _ => hsingle i (a i))
    simpa only [a, LinearEquiv.apply_symm_apply] using hmem

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteBoundedSupport_eq_top

end CSLIB.FMT.UnguardedFO
