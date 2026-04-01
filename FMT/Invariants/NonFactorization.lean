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
    localInvariant n ≠ globalInvariant n V E c := by
  exact FMT.Bridge.mismatch_possible

end FMT.Invariants
