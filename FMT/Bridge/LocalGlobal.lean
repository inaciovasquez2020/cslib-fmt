import FMT.Invariants.Eval

namespace FMT.Bridge

def localSummary (n : Nat) : Nat :=
  FMT.Invariants.evalLocal ⟨n⟩

def globalSummary (V E c : Nat) : Nat :=
  FMT.Invariants.evalCycle V E c

theorem mismatch_possible :
  ∃ n V E c : Nat, localSummary n ≠ globalSummary V E c := by
  exact ⟨0, 0, 1, 0, by decide⟩

end FMT.Bridge
