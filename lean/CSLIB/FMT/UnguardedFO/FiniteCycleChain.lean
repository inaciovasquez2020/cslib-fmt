import Mathlib
import CSLIB.FMT.UnguardedFO.FiniteCycleEF

namespace CSLIB.FMT.UnguardedFO

/-- One oriented edge per vertex: its target is the successor in the same
cyclic component. This uses the very carrier of the logical witness. -/
abbrev CycleVertex (c L : Nat) := Fin c × ZMod L

def cycleBoundary (K : Type*) [Field K] (c L : Nat) :
    (CycleVertex c L → K) →ₗ[K] (CycleVertex c L → K) where
  toFun z v := z (v.1, v.2 - 1) - z v
  map_add' z w := by
    funext v
    change (z (v.1, v.2 - 1) + w (v.1, v.2 - 1)) - (z v + w v) =
      (z (v.1, v.2 - 1) - z v) + (w (v.1, v.2 - 1) - w v)
    ring
  map_smul' a z := by
    funext v
    change a * z (v.1, v.2 - 1) - a * z v =
      a * (z (v.1, v.2 - 1) - z v)
    ring

theorem cycleBoundary_successor_constant {K : Type*} [Field K] {c L : Nat}
    (z : LinearMap.ker (cycleBoundary K c L)) (i : Fin c) (x : ZMod L) :
    z.val (i, x+1) = z.val (i,x) := by
  have hz := congrFun (LinearMap.mem_ker.mp z.property) (i,x+1)
  change z.val (i, x+1-1) - z.val (i,x+1) = 0 at hz
  rw [add_sub_cancel_right] at hz
  exact (sub_eq_zero.mp hz).symm

theorem cycleBoundary_component_constant {K : Type*} [Field K] {c L : Nat}
    [NeZero L] (z : LinearMap.ker (cycleBoundary K c L))
    (i : Fin c) (x : ZMod L) : z.val (i,x) = z.val (i,0) := by
  obtain ⟨n, rfl⟩ := ZMod.natCast_zmod_surjective x
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Nat.cast_succ, cycleBoundary_successor_constant z i, ih]

/-- The kernel consists exactly of independent constant circulations, one
per component. No assumption about kernel dimension is used. -/
def cycleKernelEquiv (K : Type*) [Field K] (c L : Nat) [NeZero L] :
    LinearMap.ker (cycleBoundary K c L) ≃ₗ[K] (Fin c → K) where
  toFun z i := z.val (i,0)
  invFun a := ⟨fun v => a v.1, by
    apply LinearMap.mem_ker.mpr
    funext v
    change a v.1 - a v.1 = 0
    exact sub_self _⟩
  left_inv z := by
    apply Subtype.ext
    funext v
    exact (cycleBoundary_component_constant z v.1 v.2).symm
  right_inv a := by rfl
  map_add' z w := by rfl
  map_smul' a z := by rfl

theorem cycleKernel_finrank (K : Type*) [Field K] (c L : Nat) [NeZero L] :
    Module.finrank K (LinearMap.ker (cycleBoundary K c L)) = c := by
  calc
    _ = Module.finrank K (Fin c → K) := (cycleKernelEquiv K c L).finrank_eq
    _ = c := by rw [Module.finrank_fintype_fun_eq_card, Fintype.card_fin]

#print axioms cycleBoundary_component_constant
#print axioms cycleKernelEquiv
#print axioms cycleKernel_finrank

end CSLIB.FMT.UnguardedFO
