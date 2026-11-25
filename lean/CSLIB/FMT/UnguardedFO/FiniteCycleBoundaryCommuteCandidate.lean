import CSLIB.FMT.UnguardedFO.FiniteCycleIncidenceCoeffCandidate

/-!
Core finite-cycle boundary-intertwining identity. Imported prerequisites have
separate Lean/axiom receipts. No axioms or sorry are introduced.
NOT_RUN until pinned Lean CI compiles this exact candidate.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)]

/-- Cyclic successor is a permutation with predecessor as its inverse. -/
private def cycleSuccessorEquiv : CycleVertex c L ≃ CycleVertex c L where
  toFun := cycleSuccessor c L
  invFun v := (v.1, v.2 - 1)
  left_inv := by
    intro ⟨i, x⟩
    apply Prod.ext
    · rfl
    · change (1 : ZMod L) + x - 1 = x
      abel
  right_inv := by
    intro ⟨i, x⟩
    apply Prod.ext
    · rfl
    · change (1 : ZMod L) + (x - 1) = x
      abel

private theorem cycleSignedTransport_at_index (z : CycleVertex c L → K)
    (w : CycleVertex c L) :
    cycleSignedTransport K c L hL z ((cycleOrderedEdgeEquiv c L hL) w) =
      (if w < cycleSuccessor c L w then (1 : K) else -1) * z w := by
  change
    (if (cycleOrderedEdgeEquiv c L hL).symm
          ((cycleOrderedEdgeEquiv c L hL) w) <
        cycleSuccessor c L ((cycleOrderedEdgeEquiv c L hL).symm
          ((cycleOrderedEdgeEquiv c L hL) w))
      then (1 : K) else -1) *
      z ((cycleOrderedEdgeEquiv c L hL).symm
        ((cycleOrderedEdgeEquiv c L hL) w)) = _
  simp only [Equiv.symm_apply_apply]

private theorem cycleIncoming_sum (z : CycleVertex c L → K)
    (v : CycleVertex c L) :
    (∑ w : CycleVertex c L,
        if v = cycleSuccessor c L w then z w else 0) =
      z (v.1, v.2 - 1) := by
  let e : CycleVertex c L ≃ CycleVertex c L := cycleSuccessorEquiv c L
  calc
    _ = ∑ u : CycleVertex c L, if v = u then z (e.symm u) else 0 := by
      apply Fintype.sum_equiv e
      intro w
      change (if v = e w then z w else 0) =
        (if v = e w then z (e.symm (e w)) else 0)
      rw [e.symm_apply_apply]
    _ = z (v.1, v.2 - 1) := by
      simp [e, cycleSuccessorEquiv]

/-- After orientation correction, the ordinary SimpleGraph incidence
boundary agrees at every vertex with the original indexed edge boundary. -/
theorem cycleSignedTransport_boundary (z : CycleVertex c L → K) :
    simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)
      (cycleSignedTransport K c L hL z) =
    cycleBoundary K c L z := by
  funext v
  change (simpleGraphIncidence (K := K) (cycleSimpleGraph c L hL)).mulVec
      (cycleSignedTransport K c L hL z) v =
        z (v.1, v.2 - 1) - z v
  rw [Matrix.mulVec_apply_eq_sum]
  have hsum :
      (∑ e : OrderedEdge (cycleSimpleGraph c L hL),
        simpleGraphIncidence (K := K) (cycleSimpleGraph c L hL) v e *
          cycleSignedTransport K c L hL z e) =
        ∑ w : CycleVertex c L,
          (if v = cycleSuccessor c L w then z w else 0) -
            (if v = w then z w else 0) := by
    rw [← Equiv.sum_comp (cycleOrderedEdgeEquiv c L hL)
      (fun e => simpleGraphIncidence (K := K) (cycleSimpleGraph c L hL) v e *
        cycleSignedTransport K c L hL z e)]
    apply Finset.sum_congr rfl
    intro w hw
    rw [cycleSignedTransport_at_index (K := K) c L hL z w]
    rw [← mul_assoc, cycleSignedIncidenceCoeff (K := K) c L hL v w]
    by_cases hvw : v = w <;>
      by_cases hvs : v = cycleSuccessor c L w <;>
      simp [hvw, hvs]
  rw [hsum, Finset.sum_sub_distrib]
  rw [cycleIncoming_sum (c := c) (L := L) z v]
  simp

#print axioms CSLIB.FMT.UnguardedFO.cycleSignedTransport_boundary

end CSLIB.FMT.UnguardedFO
