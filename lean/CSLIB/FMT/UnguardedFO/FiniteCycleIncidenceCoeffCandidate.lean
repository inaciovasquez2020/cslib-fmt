import CSLIB.FMT.UnguardedFO.FiniteCycleSignedTransportCandidate

/-!
Exact coefficient bridge between indexed successor-edge signs and the
canonically oriented SimpleGraph incidence matrix.
Lean compilation and axiom audit are required before any VERIFIED claim.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)]

private theorem cycleOrderedEdgeEquiv_val (w : CycleVertex c L) :
    ((cycleOrderedEdgeEquiv c L hL) w).val =
      if w < cycleSuccessor c L w then
        (w, cycleSuccessor c L w)
      else (cycleSuccessor c L w, w) := by
  change ((cycleOrderedEdgeIndex c L hL) w).val = _
  by_cases h : w < cycleSuccessor c L w <;>
    simp [cycleOrderedEdgeIndex, h]

/-- Matrix incidence after signed reindexing gives the original directed
edge's contribution: +1 at its successor and -1 at its source. -/
theorem cycleSignedIncidenceCoeff (v w : CycleVertex c L) :
    simpleGraphIncidence (K := K) (cycleSimpleGraph c L hL) v
        ((cycleOrderedEdgeEquiv c L hL) w) *
      (if w < cycleSuccessor c L w then (1 : K) else -1) =
    (if v = cycleSuccessor c L w then (1 : K) else 0) -
      (if v = w then (1 : K) else 0) := by
  have hne : w ≠ cycleSuccessor c L w := by
    intro he
    have hloop : (cycleSimpleGraph c L hL).Adj w w := Or.inl he.symm
    exact (cycleSimpleGraph c L hL).loopless.irrefl w hloop
  have hval := cycleOrderedEdgeEquiv_val c L hL w
  by_cases ho : w < cycleSuccessor c L w
  · have hpair : ((cycleOrderedEdgeEquiv c L hL) w).val =
        (w, cycleSuccessor c L w) := by simpa [ho] using hval
    by_cases hvw : v = w
    · subst v
      simp [simpleGraphIncidence, hpair, ho, hne, hne.symm]
    · by_cases hvs : v = cycleSuccessor c L w
      · subst v
        simp [simpleGraphIncidence, hpair, ho, hne, hne.symm, hvw]
      · simp [simpleGraphIncidence, hpair, ho, hvw, hvs]
  · have hpair : ((cycleOrderedEdgeEquiv c L hL) w).val =
        (cycleSuccessor c L w, w) := by simpa [ho] using hval
    by_cases hvw : v = w
    · subst v
      simp [simpleGraphIncidence, hpair, ho, hne, hne.symm]
    · by_cases hvs : v = cycleSuccessor c L w
      · subst v
        simp [simpleGraphIncidence, hpair, ho, hne, hne.symm, hvw]
      · simp [simpleGraphIncidence, hpair, ho, hvw, hvs]

#print axioms CSLIB.FMT.UnguardedFO.cycleSignedIncidenceCoeff

end CSLIB.FMT.UnguardedFO
