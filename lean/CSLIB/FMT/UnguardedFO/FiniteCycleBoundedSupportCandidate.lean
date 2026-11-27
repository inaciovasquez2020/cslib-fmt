import CSLIB.FMT.UnguardedFO.FiniteCycleComponentSupportCandidate

/-!
Exact minimum nonzero edge support for concrete disjoint cycle graphs, followed
by vanishing of the genuine bounded-support observation subspace when cutoff<L.
Unverified until pinned CI compiler and #print axioms pass.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

attribute [local instance] Classical.propDecidable

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

/-- Every nonzero circulation in a disjoint union of L-cycles uses
at least L ordinary undirected edges. -/
theorem cycleConcreteKernel_support_ge_length
    (z : LinearMap.ker (simpleGraphBoundary (K := K)
      (cycleSimpleGraph c L hL))) (hz : z ≠ 0) :
    L ≤ (Finset.univ.filter (fun e : OrderedEdge (cycleSimpleGraph c L hL) =>
      z.val e ≠ 0)).card := by
  classical
  have hex : ∃ e : OrderedEdge (cycleSimpleGraph c L hL), z.val e ≠ 0 := by
    by_contra hn
    push_neg at hn
    apply hz
    apply Subtype.ext
    funext e
    exact hn e
  obtain ⟨e, he⟩ := hex
  let w := (cycleOrderedEdgeEquiv c L hL).symm e
  have hw : z.val ((cycleOrderedEdgeEquiv c L hL) w) ≠ 0 := by
    simpa only [w, Equiv.apply_symm_apply] using he
  obtain ⟨i, x⟩ := w
  have hall (y : ZMod L) :
      z.val ((cycleOrderedEdgeEquiv c L hL) (i, y)) ≠ 0 :=
    (cycleConcreteKernel_component_support_iff (K := K)
      c L hL z i x y).mp hw
  let f : ZMod L →
      {e : OrderedEdge (cycleSimpleGraph c L hL) // z.val e ≠ 0} :=
    fun y => ⟨(cycleOrderedEdgeEquiv c L hL) (i, y), hall y⟩
  have hinj : Function.Injective f := by
    intro x y heq
    have heq' := congrArg Subtype.val heq
    have hxy := (cycleOrderedEdgeEquiv c L hL).injective heq'
    exact congrArg Prod.snd hxy
  have hcard : Fintype.card (ZMod L) ≤
      Fintype.card
        {e : OrderedEdge (cycleSimpleGraph c L hL) // z.val e ≠ 0} :=
    Fintype.card_le_of_injective f hinj
  simpa only [ZMod.card, Fintype.card_subtype] using hcard

/-- For cutoff below the cycle length, bounded-support local cycles are zero.
The cutoff notion is edge cardinality, not radius-one locality. -/
theorem cycleConcreteBoundedSupport_eq_bot (cutoff : Nat)
    (hcut : cutoff < L) :
    boundedSupportCycleSpace (K := K) (cycleSimpleGraph c L hL) cutoff = ⊥ := by
  classical
  apply le_antisymm
  · change Submodule.span K
      {z : LinearMap.ker (simpleGraphBoundary (K := K)
        (cycleSimpleGraph c L hL)) |
        (Finset.univ.filter
          (fun e : OrderedEdge (cycleSimpleGraph c L hL) => z.val e ≠ 0)).card
            ≤ cutoff} ≤ ⊥
    apply Submodule.span_le.mpr
    intro z hz
    have hzero : z = 0 := by
      by_contra hn
      have hge := cycleConcreteKernel_support_ge_length (K := K)
        c L hL z hn
      exact (Nat.not_le_of_gt hcut) (le_trans hge hz)
    simpa only [Submodule.mem_bot] using hzero
  · exact bot_le

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteKernel_support_ge_length
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteBoundedSupport_eq_bot

end CSLIB.FMT.UnguardedFO
