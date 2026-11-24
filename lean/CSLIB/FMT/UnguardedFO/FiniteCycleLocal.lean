import Mathlib
import CSLIB.FMT.UnguardedFO.FiniteCycleChain

namespace CSLIB.FMT.UnguardedFO

/-- The undirected adjacency of the concrete logical cycle witness. -/
def cycleAdjacent (c L : Nat) (u v : CycleVertex c L) : Prop :=
  (cycleShift c L).shift 1 u = v ∨ (cycleShift c L).shift (-1) u = v

/-- This is exactly the interpretation of the binary relation in the EF witness. -/
theorem cycleAdjacent_interp (c L : Nat) (a : Fin 2 → CycleVertex c L) :
    (shiftGraph (cycleShift c L)).interp () a ↔ cycleAdjacent c L (a 0) (a 1) :=
  Iff.rfl

def cycleClosedBall (c L : Nat) (v u : CycleVertex c L) : Prop :=
  u = v ∨ cycleAdjacent c L v u

def cycleSuccessor (c L : Nat) (v : CycleVertex c L) : CycleVertex c L :=
  (cycleShift c L).shift 1 v

/-- Both endpoints of every active indexed edge must be in the induced ball. -/
def CycleBallSupported {K : Type*} [Field K] {c L : Nat}
    (v : CycleVertex c L) (z : LinearMap.ker (cycleBoundary K c L)) : Prop :=
  ∀ e : CycleVertex c L, z.val e ≠ 0 →
    cycleClosedBall c L v e ∧ cycleClosedBall c L v (cycleSuccessor c L e)

/-- Displacement two leaves a closed one-ball when the length is at least four. -/
theorem cycleShift_two_outside_ball (c L : Nat) (hL : 4 ≤ L)
    (v : CycleVertex c L) :
    ¬ cycleClosedBall c L v ((cycleShift c L).shift 2 v) := by
  have hf : FreeAt (cycleShift c L) 3 :=
    cycleShift_free c L 3 (by omega)
  intro h
  rcases h with h | h
  · have hz := (hf v 2 (by omega) (by omega)).mp h
    omega
  · rcases h with h | h
    · have he := (shift_target_iff (cycleShift c L) 2 1 v v).mp h
      have hz := (hf v (-2+1) (by omega) (by omega)).mp he
      omega
    · have he := (shift_target_iff (cycleShift c L) 2 (-1) v v).mp h
      have hz := (hf v (-2+(-1)) (by omega) (by omega)).mp he
      omega

/-- A circulation supported in any closed one-ball vanishes identically.
Only the source-endpoint condition is needed for this argument. -/
theorem cycleBallSupported_zero {K : Type*} [Field K] {c L : Nat} [NeZero L]
    (hL : 4 ≤ L) (v : CycleVertex c L)
    (z : LinearMap.ker (cycleBoundary K c L))
    (hs : CycleBallSupported v z) : z = 0 := by
  apply Subtype.ext
  funext e
  change z.val e = 0
  by_contra hn
  have hb := (hs e hn).1
  have hi : e.1 = v.1 := by
    rcases hb with he | he
    · exact congrArg Prod.fst he
    · rcases he with he | he
      · exact (congrArg Prod.fst he).symm
      · exact (congrArg Prod.fst he).symm
  let w := (cycleShift c L).shift 2 v
  have hw : w.1 = v.1 := rfl
  have hc : z.val e = z.val w := by
    calc
      z.val e = z.val (e.1, 0) := cycleBoundary_component_constant z e.1 e.2
      _ = z.val (w.1, 0) := by rw [hi, hw]
      _ = z.val w := (cycleBoundary_component_constant z w.1 w.2).symm
  have hnw : z.val w ≠ 0 := by
    intro hz
    exact hn (hc.trans hz)
  exact cycleShift_two_outside_ball c L hL v (hs w hnw).1

/-- The span of genuine closed-one-ball-supported circulations. -/
def cycleLocalSpace (K : Type*) [Field K] (c L : Nat) :
    Submodule K (LinearMap.ker (cycleBoundary K c L)) :=
  Submodule.span K {z | ∃ v : CycleVertex c L, CycleBallSupported v z}

theorem cycleLocalSpace_eq_bot (K : Type*) [Field K] (c L : Nat) [NeZero L]
    (hL : 4 ≤ L) : cycleLocalSpace K c L = ⊥ := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    intro z hz
    obtain ⟨v, hv⟩ := hz
    exact Submodule.mem_bot.mpr (cycleBallSupported_zero hL v z hv)
  · exact bot_le

#print axioms cycleAdjacent_interp
#print axioms cycleShift_two_outside_ball
#print axioms cycleBallSupported_zero
#print axioms cycleLocalSpace_eq_bot

end CSLIB.FMT.UnguardedFO
