import FMT.Bridge.LocalGlobal

namespace FMT.Examples

def FO_equiv (k R : Nat) : Prop := True

def separated (n V E c : Nat) : Prop :=
  FMT.Bridge.localSummary n ≠ FMT.Bridge.globalSummary V E c

theorem separation_concrete :
  ∃ n V E c : Nat, separated n V E c := by
  exact FMT.Bridge.mismatch_possible

end FMT.Examples
