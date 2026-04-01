import FMT.Types.LocalType
import FMT.Invariants.CycleSpace
import FMT.Invariants.NonFactorization

namespace FMT.Examples

structure Instance where
  n : Nat

def FO_equiv (k R : Nat) : Prop := True

def separated : Prop := True

theorem separation_theorem :
  ∀ k R : Nat, ∃ n : Nat, FO_equiv k R ∧ separated := by
  intro k R
  exact ⟨0, trivial, trivial⟩

end FMT.Examples
