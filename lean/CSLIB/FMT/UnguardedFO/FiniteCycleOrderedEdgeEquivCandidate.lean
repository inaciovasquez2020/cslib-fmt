import CSLIB.FMT.UnguardedFO.FiniteCycleSimpleGraph

/-!
First isolated proof obligation for the indexed-to-ordered-edge bridge.
Targets the cslib-fmt Lean 4.30.0-rc1, mathlib 0c154d6 checkout.
NOT_RUN: this file has not been compiled in the user's Mac environment.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)]

/-- An indexed successor edge, expressed using the target graph's canonical
ordered-edge orientation. -/
noncomputable def cycleOrderedEdgeIndex (w : CycleVertex c L) :
    OrderedEdge (cycleSimpleGraph c L hL) := by
  classical
  have hs := cycleSimpleGraph_successor_adj c L hL w
  have hne : w ≠ cycleSuccessor c L w := by
    intro hw
    have hloop : (cycleSimpleGraph c L hL).Adj w w := Or.inl hw.symm
    exact (cycleSimpleGraph c L hL).loopless.irrefl w hloop
  by_cases h : w < cycleSuccessor c L w
  · exact ⟨(w, cycleSuccessor c L w), ⟨h, hs⟩⟩
  · have hlt : cycleSuccessor c L w < w :=
      lt_of_le_of_ne (le_of_not_gt h) hne.symm
    exact ⟨(cycleSuccessor c L w, w),
      ⟨hlt, (cycleSimpleGraph c L hL).symm hs⟩⟩

private theorem cycleOrderedEdgeIndex_injective :
    Function.Injective (cycleOrderedEdgeIndex c L hL) := by
  intro u v he
  have hp := congrArg Subtype.val he
  by_cases hu : u < cycleSuccessor c L u
  · by_cases hv : v < cycleSuccessor c L v
    · have hpair : (u, cycleSuccessor c L u) =
          (v, cycleSuccessor c L v) := by
        simpa [cycleOrderedEdgeIndex, hu, hv] using hp
      exact congrArg Prod.fst hpair
    · have hpair : (u, cycleSuccessor c L u) =
          (cycleSuccessor c L v, v) := by
        simpa [cycleOrderedEdgeIndex, hu, hv] using hp
      exact cycleSuccessor_edge_index_unique c L hL u v
        (Or.inr ⟨congrArg Prod.fst hpair, congrArg Prod.snd hpair⟩)
  · by_cases hv : v < cycleSuccessor c L v
    · have hpair : (cycleSuccessor c L u, u) =
          (v, cycleSuccessor c L v) := by
        simpa [cycleOrderedEdgeIndex, hu, hv] using hp
      exact cycleSuccessor_edge_index_unique c L hL u v
        (Or.inr ⟨congrArg Prod.snd hpair, congrArg Prod.fst hpair⟩)
    · have hpair : (cycleSuccessor c L u, u) =
          (cycleSuccessor c L v, v) := by
        simpa [cycleOrderedEdgeIndex, hu, hv] using hp
      exact congrArg Prod.snd hpair

private theorem cycleOrderedEdgeIndex_surjective :
    Function.Surjective (cycleOrderedEdgeIndex c L hL) := by
  rintro ⟨⟨u, v⟩, he⟩
  obtain ⟨w, hw | hw⟩ := cycleSimpleGraph_edge_exists c L hL u v he.2
  · obtain ⟨hu, hv⟩ := hw
    have hlt : w < cycleSuccessor c L w := by
      calc
        w = u := hu.symm
        _ < v := he.1
        _ = cycleSuccessor c L w := hv
    refine ⟨w, ?_⟩
    apply Subtype.ext
    simp [cycleOrderedEdgeIndex, hlt, hu, hv]
  · obtain ⟨hv, hu⟩ := hw
    have hlt : cycleSuccessor c L w < w := by
      calc
        cycleSuccessor c L w = u := hu.symm
        _ < v := he.1
        _ = w := hv
    have hn : ¬ w < cycleSuccessor c L w := not_lt.mpr (le_of_lt hlt)
    refine ⟨w, ?_⟩
    apply Subtype.ext
    simp [cycleOrderedEdgeIndex, hn, hu, hv]

/-- Each indexed successor edge corresponds to precisely one canonically
ordered edge of the ordinary undirected graph. -/
noncomputable def cycleOrderedEdgeEquiv :
    CycleVertex c L ≃ OrderedEdge (cycleSimpleGraph c L hL) :=
  Equiv.ofBijective (cycleOrderedEdgeIndex c L hL)
    ⟨cycleOrderedEdgeIndex_injective c L hL,
      cycleOrderedEdgeIndex_surjective c L hL⟩

#print axioms CSLIB.FMT.UnguardedFO.cycleOrderedEdgeEquiv

end CSLIB.FMT.UnguardedFO
