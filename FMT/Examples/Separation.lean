import FMT.Graph.Basic

namespace FMT.Examples

open FMT.Graph

def FO_equiv (G H : Graph) : Prop := True

def separated (G H : Graph) : Prop := True

import FMT.Types.LocalType
import FMT.Bridge.LocalGlobal

namespace FMT.Examples

def FO_equiv (k R : Nat) (n m : Nat) : Prop :=
  (FMT.Types.encode ⟨n, R⟩).code = (FMT.Types.encode ⟨m, R⟩).code

def separated (n V E c : Nat) : Prop :=
  FMT.Bridge.localSummary n ≠ FMT.Bridge.globalSummary V E c

theorem separation_concrete :
  ∃ n V E c : Nat, separated n V E c := by
  exact FMT.Bridge.mismatch_possible

end FMT.Examples
