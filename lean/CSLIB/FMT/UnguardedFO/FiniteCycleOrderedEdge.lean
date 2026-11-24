import CSLIB.FMT.UnguardedFO.FiniteCycleSimpleGraph

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable {c L : Nat} (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)]

/-- Canonically order the two endpoints of the successor edge. -/
def cycleOrderedEdge (v : CycleVertex c L) :
    OrderedEdge (cycleSimpleGraph c L hL) :=
  if h : v < cycleSuccessor c L v then
    ⟨(v, cycleSuccessor c L v), h, cycleSimpleGraph_successor_adj c L hL v⟩
  else
    ⟨(cycleSuccessor c L v, v), lt_of_le_of_ne (le_of_not_gt h)
      (cycleSimpleGraph_successor_adj c L hL v).ne.symm,
      (cycleSimpleGraph_successor_adj c L hL v).symm⟩

theorem cycleOrderedEdge_endpoints (v : CycleVertex c L) :
    ((cycleOrderedEdge hL v).val.1 = v ∧
      (cycleOrderedEdge hL v).val.2 = cycleSuccessor c L v) ∨
    ((cycleOrderedEdge hL v).val.2 = v ∧
      (cycleOrderedEdge hL v).val.1 = cycleSuccessor c L v) := by
  by_cases h : v < cycleSuccessor c L v
  · left
    simp [cycleOrderedEdge, h]
  · right
    simp [cycleOrderedEdge, h]

theorem cycleOrderedEdge_injective :
    Function.Injective (cycleOrderedEdge (c := c) hL) := by
  intro u v huv
  have hu := cycleOrderedEdge_endpoints hL u
  have hv := cycleOrderedEdge_endpoints hL v
  rw [huv] at hu
  apply cycleSuccessor_edge_index_unique c L hL u v
  rcases hu with hu | hu <;> rcases hv with hv | hv
  · exact Or.inl ⟨hu.1.symm.trans hv.1, hu.2.symm.trans hv.2⟩
  · exact Or.inr ⟨hu.1.symm.trans hv.2, hu.2.symm.trans hv.1⟩
  · exact Or.inr ⟨hu.1.symm.trans hv.2, hu.2.symm.trans hv.1⟩
  · exact Or.inl ⟨hu.1.symm.trans hv.1, hu.2.symm.trans hv.2⟩

theorem cycleOrderedEdge_surjective :
    Function.Surjective (cycleOrderedEdge (c := c) hL) := by
  intro e
  obtain ⟨w, hw⟩ := cycleSimpleGraph_edge_exists c L hL e.val.1 e.val.2 e.property.2
  refine ⟨w, ?_⟩
  rcases hw with hw | hw
  · have h : w < cycleSuccessor c L w := by
      rw [← hw.1, ← hw.2]
      exact e.property.1
    apply Subtype.ext
    simp only [cycleOrderedEdge, dif_pos h]
    exact Prod.ext hw.1.symm hw.2.symm
  · have h : ¬ w < cycleSuccessor c L w := by
      rw [← hw.1, ← hw.2]
      exact not_lt_of_ge e.property.1.le
    apply Subtype.ext
    simp only [cycleOrderedEdge, dif_neg h]
    exact Prod.ext hw.2.symm hw.1.symm

/-- A bijection to the exact ordered-edge type of URF, without assuming
a particular choice of vertex linear order. -/
noncomputable def cycleEdgeEquiv :
    CycleVertex c L ≃ OrderedEdge (cycleSimpleGraph c L hL) :=
  Equiv.ofBijective (cycleOrderedEdge hL)
    ⟨cycleOrderedEdge_injective hL, cycleOrderedEdge_surjective hL⟩

/-- The sign compensates for the arbitrary canonical vertex order. -/
def cycleEdgeSign (K : Type*) [Field K] (v : CycleVertex c L) : K :=
  if v < cycleSuccessor c L v then 1 else -1

theorem cycleEdgeSign_mul_self (K : Type*) [Field K] (v : CycleVertex c L) :
    cycleEdgeSign K v * cycleEdgeSign K v = 1 := by
  by_cases h : v < cycleSuccessor c L v <;> simp [cycleEdgeSign, h]

/-- Signed coordinate permutation, with an explicit inverse. -/
noncomputable def cycleEdgeChainEquiv (K : Type*) [Field K] :
    (CycleVertex c L → K) ≃ₗ[K] (OrderedEdge (cycleSimpleGraph c L hL) → K) where
  toFun z e := cycleEdgeSign K ((cycleEdgeEquiv hL).symm e) *
    z ((cycleEdgeEquiv hL).symm e)
  invFun w v := cycleEdgeSign K v * w (cycleEdgeEquiv hL v)
  left_inv z := by
    funext v
    simp only [Equiv.symm_apply_apply]
    rw [← mul_assoc, cycleEdgeSign_mul_self, one_mul]
  right_inv w := by
    funext e
    simp only [Equiv.apply_symm_apply]
    rw [← mul_assoc, cycleEdgeSign_mul_self, one_mul]
  map_add' z w := by
    funext e
    simp only [Pi.add_apply, mul_add]
  map_smul' a z := by
    funext e
    simp only [Pi.smul_apply, smul_eq_mul]
    ring

theorem cycleEdgeChainEquiv_at (K : Type*) [Field K]
    (z : CycleVertex c L → K) (v : CycleVertex c L) :
    cycleEdgeChainEquiv hL K z (cycleEdgeEquiv hL v) =
      cycleEdgeSign K v * z v := by
  change cycleEdgeSign K ((cycleEdgeEquiv hL).symm (cycleEdgeEquiv hL v)) *
      z ((cycleEdgeEquiv hL).symm (cycleEdgeEquiv hL v)) = _
  rw [Equiv.symm_apply_apply]

#print axioms cycleOrderedEdge_endpoints
#print axioms cycleOrderedEdge_injective
#print axioms cycleOrderedEdge_surjective
#print axioms cycleEdgeEquiv
#print axioms cycleEdgeChainEquiv
#print axioms cycleEdgeChainEquiv_at

end CSLIB.FMT.UnguardedFO
