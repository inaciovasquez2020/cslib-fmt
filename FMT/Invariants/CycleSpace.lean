namespace FMT.Invariants

structure CycleSpace where
  dim : Nat

def cycleDim (n : Nat) : CycleSpace := ⟨n⟩

theorem cycleDim_nonneg (n : Nat) : 0 ≤ (cycleDim n).dim := by
  omega

end FMT.Invariants
