import CSLIB.FMT.UnguardedFO.FiniteCycleKernelEquivCandidate

/-!
Support of a concrete SimpleGraph circulation is constant on each cyclic
component after canonical signed edge reindexing.
NOT_RUN pending pinned Lean/Mathlib CI.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

/-- A concrete undirected circulation is nonzero on a canonical edge iff
its indexed inverse is nonzero on the corresponding successor edge. -/
theorem cycleConcreteKernel_support_transport
    (z : LinearMap.ker (simpleGraphBoundary (K := K)
      (cycleSimpleGraph c L hL))) (v : CycleVertex c L) :
    z.val ((cycleOrderedEdgeEquiv c L hL) v) ≠ 0 ↔
      ((cycleConcreteKernelEquiv K c L hL).symm z).val v ≠ 0 := by
  let q := (cycleConcreteKernelEquiv K c L hL).symm z
  have htransport : cycleSignedTransport K c L hL q.val = z.val := by
    have hh := congrArg Subtype.val
      ((cycleConcreteKernelEquiv K c L hL).apply_symm_apply z)
    change cycleSignedTransport K c L hL q.val = z.val at hh
    exact hh
  rw [← htransport]
  simpa only [Equiv.symm_apply_apply] using
    (cycleSignedTransport_ne_zero_iff (K := K) c L hL q.val
      ((cycleOrderedEdgeEquiv c L hL) v))

/-- On any component, a closed circulation uses either all successive
undirected edges or none; there are no partial nonzero circulations. -/
theorem cycleConcreteKernel_component_support_iff
    (z : LinearMap.ker (simpleGraphBoundary (K := K)
      (cycleSimpleGraph c L hL))) (i : Fin c) (x y : ZMod L) :
    z.val ((cycleOrderedEdgeEquiv c L hL) (i, x)) ≠ 0 ↔
      z.val ((cycleOrderedEdgeEquiv c L hL) (i, y)) ≠ 0 := by
  rw [cycleConcreteKernel_support_transport (K := K) c L hL z (i, x),
      cycleConcreteKernel_support_transport (K := K) c L hL z (i, y)]
  let q := (cycleConcreteKernelEquiv K c L hL).symm z
  change q.val (i, x) ≠ 0 ↔ q.val (i, y) ≠ 0
  rw [cycleBoundary_component_constant q i x,
      cycleBoundary_component_constant q i y]

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteKernel_support_transport
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteKernel_component_support_iff

end CSLIB.FMT.UnguardedFO
