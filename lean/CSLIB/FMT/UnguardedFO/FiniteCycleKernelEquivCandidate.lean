import CSLIB.FMT.UnguardedFO.FiniteCycleBoundaryCommuteCandidate

/-!
Exact kernel transport between the indexed cyclic boundary and the genuine
undirected SimpleGraph incidence boundary. The signed boundary identity
is imported, not assumed. New theorem is NOT_RUN until isolated Lean CI.
-/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable (K : Type*) [Field K] (c L : Nat) (hL : 4 ≤ L)
variable [LinearOrder (CycleVertex c L)] [NeZero L]

/-- Signed reindexing induces a genuine linear equivalence on cycle kernels. -/
noncomputable def cycleConcreteKernelEquiv :
    LinearMap.ker (cycleBoundary K c L) ≃ₗ[K]
      LinearMap.ker (simpleGraphBoundary (K := K)
        (cycleSimpleGraph c L hL)) where
  toFun z := ⟨cycleSignedTransport K c L hL z.val, by
    apply LinearMap.mem_ker.mpr
    rw [cycleSignedTransport_boundary (K := K) c L hL]
    exact LinearMap.mem_ker.mp z.property⟩
  invFun z := ⟨(cycleSignedTransport K c L hL).symm z.val, by
    apply LinearMap.mem_ker.mpr
    calc
      cycleBoundary K c L
          ((cycleSignedTransport K c L hL).symm z.val) =
        simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)
          (cycleSignedTransport K c L hL
            ((cycleSignedTransport K c L hL).symm z.val)) :=
          (cycleSignedTransport_boundary (K := K) c L hL _).symm
      _ = simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL)
            z.val := by rw [LinearEquiv.apply_symm_apply]
      _ = 0 := LinearMap.mem_ker.mp z.property⟩
  left_inv z := by
    apply Subtype.ext
    change (cycleSignedTransport K c L hL).symm
      (cycleSignedTransport K c L hL z.val) = z.val
    exact (cycleSignedTransport K c L hL).symm_apply_apply z.val
  right_inv z := by
    apply Subtype.ext
    change cycleSignedTransport K c L hL
      ((cycleSignedTransport K c L hL).symm z.val) = z.val
    exact (cycleSignedTransport K c L hL).apply_symm_apply z.val
  map_add' z w := by
    apply Subtype.ext
    change cycleSignedTransport K c L hL (z.val + w.val) =
      cycleSignedTransport K c L hL z.val +
        cycleSignedTransport K c L hL w.val
    exact map_add (cycleSignedTransport K c L hL) z.val w.val
  map_smul' a z := by
    apply Subtype.ext
    change cycleSignedTransport K c L hL (a • z.val) =
      a • cycleSignedTransport K c L hL z.val
    exact map_smul (cycleSignedTransport K c L hL) a z.val

/-- The concrete undirected graph has one independent cycle per component. -/
theorem cycleConcreteKernel_finrank :
    Module.finrank K (LinearMap.ker
      (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) = c := by
  calc
    _ = Module.finrank K (LinearMap.ker (cycleBoundary K c L)) :=
      (cycleConcreteKernelEquiv K c L hL).finrank_eq.symm
    _ = c := cycleKernel_finrank K c L

#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteKernelEquiv
#print axioms CSLIB.FMT.UnguardedFO.cycleConcreteKernel_finrank

end CSLIB.FMT.UnguardedFO
