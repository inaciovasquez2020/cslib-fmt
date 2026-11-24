import CSLIB.FMT.UnguardedFO.FiniteCycleEntropy

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

/-- The simple graph induced by the exact binary relation of the EF witness. -/
def cycleSimpleGraph (c L : Nat) (hL : 4 ≤ L) : SimpleGraph (CycleVertex c L) where
  Adj := cycleAdjacent c L
  symm := by
    intro u v h
    rcases h with h | h
    · exact Or.inr ((shift_reverse (cycleShift c L) 1 u v).mp h)
    · exact Or.inl (by
        have he := (shift_reverse (cycleShift c L) (-1) u v).mp h
        simpa using he)
  loopless := by
    intro v h
    have hf := cycleShift_free c L 1 (by omega : (1 : Int) < (L : Int))
    rcases h with h | h
    · have hz := (hf v 1 (by omega) (by omega)).mp h
      omega
    · have hz := (hf v (-1) (by omega) (by omega)).mp h
      omega

theorem cycleSimpleGraph_interp (c L : Nat) (hL : 4 ≤ L)
    (a : Fin 2 → CycleVertex c L) :
    (shiftGraph (cycleShift c L)).interp () a ↔
      (cycleSimpleGraph c L hL).Adj (a 0) (a 1) :=
  Iff.rfl

theorem cycleSimpleGraph_successor_adj (c L : Nat) (hL : 4 ≤ L)
    (v : CycleVertex c L) :
    (cycleSimpleGraph c L hL).Adj v (cycleSuccessor c L v) :=
  Or.inl rfl

/-- The unoriented endpoint pair determines its successor-edge index uniquely.
The proof excludes the reversed orientation using the absence of a period two. -/
theorem cycleSuccessor_edge_index_unique (c L : Nat) (hL : 4 ≤ L)
    (u v : CycleVertex c L)
    (h : (u = v ∧ cycleSuccessor c L u = cycleSuccessor c L v) ∨
      (u = cycleSuccessor c L v ∧ cycleSuccessor c L u = v)) :
    u = v := by
  rcases h with h | h
  · exact h.1
  · exfalso
    have he : (cycleShift c L).shift 2 v = v := by
      change (cycleShift c L).shift (1+1) v = v
      rw [← (cycleShift c L).shift_add]
      change cycleSuccessor c L (cycleSuccessor c L v) = v
      rw [← h.1]
      exact h.2
    have hf := cycleShift_free c L 2 (by omega : (2 : Int) < (L : Int))
    have hz := (hf v 2 (by omega) (by omega)).mp he
    omega

/-- Every simple edge is the endpoint pair of a successor edge. -/
theorem cycleSimpleGraph_edge_exists (c L : Nat) (hL : 4 ≤ L)
    (u v : CycleVertex c L) (h : (cycleSimpleGraph c L hL).Adj u v) :
    ∃ w : CycleVertex c L,
      (u = w ∧ v = cycleSuccessor c L w) ∨
      (v = w ∧ u = cycleSuccessor c L w) := by
  rcases h with h | h
  · exact ⟨u, Or.inl ⟨rfl,h.symm⟩⟩
  · have he := (shift_reverse (cycleShift c L) (-1) u v).mp h
    exact ⟨v, Or.inr ⟨rfl, by simpa [cycleSuccessor] using he.symm⟩⟩

#print axioms cycleSimpleGraph_interp
#print axioms cycleSimpleGraph_successor_adj
#print axioms cycleSuccessor_edge_index_unique
#print axioms cycleSimpleGraph_edge_exists

end CSLIB.FMT.UnguardedFO
