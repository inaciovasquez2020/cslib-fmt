import FMT.Types.LocalType
import FMT.Invariants.CycleSpace

namespace FMT.Invariants

structure Invariant where
  eval : Nat → Nat

def evalCycle (V E c : Nat) : Nat :=
  E - V + c

def evalLocal (t : FMT.Types.LocalType) : Nat :=
  t.code

theorem eval_consistency :
  ∀ n : Nat, evalLocal ⟨n⟩ = n := by
  intro n
  rfl

end FMT.Invariants
