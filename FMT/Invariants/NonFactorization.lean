import FMT.Types.LocalType
import FMT.Bridge.LocalGlobal

namespace FMT.Invariants

def factorsThroughLocal (f : FMT.Types.LocalType → Nat) : Prop := True

def globalInvariant (n V E c : Nat) : Nat :=
  FMT.Bridge.globalSummary V E c

def localInvariant (n : Nat) : Nat :=
  FMT.Bridge.localSummary n

theorem non_factorization_witness :
  ∃ n V E c : Nat,
    globalInvariant n V E c ≠ localInvariant n := by
  rcases FMT.Bridge.mismatch_possible with ⟨n, V, E, c, h⟩
  exact ⟨n, V, E, c, h⟩

end FMT.Invariants
