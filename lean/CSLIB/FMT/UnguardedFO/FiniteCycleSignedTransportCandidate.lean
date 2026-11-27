import CSLIB.FMT.UnguardedFO.FiniteCycleOrderedEdgeEquivCandidate

/-!
Isolated signed linear edge reindexing for the finite cyclic SimpleGraph witness.
Source target: cslib-fmt PR #196 (Lean 4.30.0-rc1; Mathlib 0c154d6).
NOT_RUN until pinned GitHub Actions has compiled and audited this exact file.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)]

/-- Sign of a directed successor edge relative to canonical graph orientation. -/
private noncomputable def cycleEdgeSign (v : CycleVertex c L) : K :=
  if v < cycleSuccessor c L v then 1 else -1

private theorem cycleEdgeSign_mul_self (v : CycleVertex c L) :
    cycleEdgeSign K c L v * cycleEdgeSign K c L v = 1 := by
  unfold cycleEdgeSign
  split_ifs <;> ring

/-- Reindex edge coefficients through the verified edge bijection, flipping
signs exactly when the canonical orientation reverses a successor edge. -/
noncomputable def cycleSignedTransport :
    (CycleVertex c L → K) ≃ₗ[K]
      (OrderedEdge (cycleSimpleGraph c L hL) → K) where
  toFun z e :=
    cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
      z ((cycleOrderedEdgeEquiv c L hL).symm e)
  invFun z v :=
    cycleEdgeSign K c L v * z ((cycleOrderedEdgeEquiv c L hL) v)
  left_inv z := by
    funext v
    change cycleEdgeSign K c L v *
        (cycleEdgeSign K c L
          ((cycleOrderedEdgeEquiv c L hL).symm
            ((cycleOrderedEdgeEquiv c L hL) v)) *
          z ((cycleOrderedEdgeEquiv c L hL).symm
            ((cycleOrderedEdgeEquiv c L hL) v))) = z v
    rw [Equiv.symm_apply_apply]
    rw [← mul_assoc, cycleEdgeSign_mul_self]
    exact one_mul _
  right_inv z := by
    funext e
    change cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        (cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
          z ((cycleOrderedEdgeEquiv c L hL)
            ((cycleOrderedEdgeEquiv c L hL).symm e))) = z e
    rw [Equiv.apply_symm_apply]
    rw [← mul_assoc, cycleEdgeSign_mul_self]
    exact one_mul _
  map_add' z w := by
    funext e
    change cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        (z ((cycleOrderedEdgeEquiv c L hL).symm e) +
          w ((cycleOrderedEdgeEquiv c L hL).symm e)) =
      cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        z ((cycleOrderedEdgeEquiv c L hL).symm e) +
      cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        w ((cycleOrderedEdgeEquiv c L hL).symm e)
    exact mul_add _ _ _
  map_smul' a z := by
    funext e
    change cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        (a * z ((cycleOrderedEdgeEquiv c L hL).symm e)) =
      a * (cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
        z ((cycleOrderedEdgeEquiv c L hL).symm e))
    ring

/-- A nonzero edge coefficient stays nonzero after signed reindexing. -/
theorem cycleSignedTransport_ne_zero_iff (z : CycleVertex c L → K)
    (e : OrderedEdge (cycleSimpleGraph c L hL)) :
    cycleSignedTransport K c L hL z e ≠ 0 ↔
      z ((cycleOrderedEdgeEquiv c L hL).symm e) ≠ 0 := by
  change (cycleEdgeSign K c L ((cycleOrderedEdgeEquiv c L hL).symm e) *
    z ((cycleOrderedEdgeEquiv c L hL).symm e) ≠ 0) ↔ _
  unfold cycleEdgeSign
  split_ifs <;> simp

#print axioms CSLIB.FMT.UnguardedFO.cycleSignedTransport
#print axioms CSLIB.FMT.UnguardedFO.cycleSignedTransport_ne_zero_iff

end CSLIB.FMT.UnguardedFO
