import CSLIB.FMT.UnguardedFO.FiniteCycleLocal
import CSLIB.FMT.UnguardedFO.SignedSuccessorIncidence

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
    constructor
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

/-- Cyclic translation is a permutation even before choosing an edge order. -/
def cycleSuccessorPerm (c L : Nat) : Equiv.Perm (CycleVertex c L) where
  toFun := cycleSuccessor c L
  invFun v := (v.1, v.2 - 1)
  left_inv v := by
    change (v.1, ((1 : ℤ) : ZMod L) + v.2 - 1) = v
    rw [Int.cast_one, add_comm (1 : ZMod L), add_sub_cancel_right]
  right_inv v := by
    change (v.1, ((1 : ℤ) : ZMod L) + (v.2 - 1)) = v
    rw [Int.cast_one, add_comm (1 : ZMod L), sub_add_cancel]

def cycleSuccessorEdges (c L : Nat) (hL : 4 ≤ L) :
    SuccessorEdges (cycleSimpleGraph c L hL) where
  next := cycleSuccessorPerm c L
  adj := cycleSimpleGraph_successor_adj c L hL
  unique u v h := cycleSuccessor_edge_index_unique c L hL u v (Or.inr h)
  cover := cycleSimpleGraph_edge_exists c L hL

section
variable (K : Type*) [Field K] (c L : Nat) [NeZero L]
variable [LinearOrder (CycleVertex c L)] (hL : 4 ≤ L)

theorem cycleSimpleGraph_boundary_intertwines
    (z : CycleVertex c L → K) (v : CycleVertex c L) :
    simpleGraphBoundary (cycleSimpleGraph c L hL)
        ((cycleSuccessorEdges c L hL).signedEdges K z) v = cycleBoundary K c L z v :=
  (cycleSuccessorEdges c L hL).boundary_intertwines K z v

noncomputable def cycleSimpleGraphKernelEquiv :
    LinearMap.ker (cycleBoundary K c L) ≃ₗ[K]
      LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)) :=
  (cycleSuccessorEdges c L hL).kernelEquiv K (cycleBoundary K c L) (fun _ _ => rfl)

noncomputable def cycleSimpleGraphCirculationEquiv :
    LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)) ≃ₗ[K]
      (Fin c → K) :=
  (cycleSimpleGraphKernelEquiv K c L hL).symm.trans (cycleKernelEquiv K c L)

theorem cycleSimpleGraphKernel_finrank :
    Module.finrank K (LinearMap.ker
      (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) = c :=
  (cycleSimpleGraphKernelEquiv K c L hL).finrank_eq.symm.trans (cycleKernel_finrank K c L)

def CycleGraphBallSupported (v : CycleVertex c L)
    (z : LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) : Prop :=
  ∀ e : OrderedEdge (cycleSimpleGraph c L hL), z.val e ≠ 0 →
    (e.val.1 = v ∨ (cycleSimpleGraph c L hL).Adj v e.val.1) ∧
    (e.val.2 = v ∨ (cycleSimpleGraph c L hL).Adj v e.val.2)

theorem cycleSimpleGraph_ballSupported_iff (v : CycleVertex c L)
    (z : LinearMap.ker (cycleBoundary K c L)) :
    CycleGraphBallSupported K c L hL v (cycleSimpleGraphKernelEquiv K c L hL z) ↔
      CycleBallSupported v z := by
  let S := cycleSuccessorEdges c L hL
  have hn (u : CycleVertex c L) :
      (cycleSimpleGraphKernelEquiv K c L hL z).val (S.edgeEquiv u) ≠ 0 ↔ z.val u ≠ 0 :=
    S.signedEdges_ne_zero_iff K z.val u
  have he (u : CycleVertex c L) :
      (cycleClosedBall c L v (S.edgeEquiv u).val.1 ∧
        cycleClosedBall c L v (S.edgeEquiv u).val.2) ↔
      (cycleClosedBall c L v u ∧ cycleClosedBall c L v (cycleSuccessor c L u)) := by
    have ht : (S.edgeEquiv u).val = (u, cycleSuccessor c L u) ∨
        (S.edgeEquiv u).val = (cycleSuccessor c L u, u) := S.endpoints u
    rcases ht with ht | ht
    · rw [ht]
    · rw [ht, and_comm]
  constructor
  · intro h u hu
    exact (he u).mp (h (S.edgeEquiv u) ((hn u).mpr hu))
  · intro h e hz
    obtain ⟨u, rfl⟩ := S.edgeEquiv.surjective e
    exact (he u).mpr (h u ((hn u).mp hz))

end

#print axioms cycleSimpleGraph_interp
#print axioms cycleSimpleGraph_successor_adj
#print axioms cycleSuccessor_edge_index_unique
#print axioms cycleSimpleGraph_edge_exists
#print axioms cycleSimpleGraph_boundary_intertwines
#print axioms cycleSimpleGraphKernelEquiv
#print axioms cycleSimpleGraphCirculationEquiv
#print axioms cycleSimpleGraphKernel_finrank
#print axioms cycleSimpleGraph_ballSupported_iff

end CSLIB.FMT.UnguardedFO
