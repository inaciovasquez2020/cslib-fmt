import FMT.Types.LocalType
import FMT.Bridge.LocalGlobal

namespace FMT.Examples

def FO_equiv (k R : Nat) (n m : Nat) : Prop :=
  FMT.Types.encode ⟨n, R⟩ = FMT.Types.encode ⟨m, R⟩

def separated (n V E c : Nat) : Prop :=
  FMT.Bridge.localSummary n ≠ FMT.Bridge.globalSummary V E c

theorem separation_concrete :
  ∃ n V E c : Nat, separated n V E c := by
  exact FMT.Bridge.mismatch_possible

end FMT.Examples
