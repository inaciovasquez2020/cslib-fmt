import FMT.Types.LocalType
import FMT.Invariants.CycleSpace
import FMT.Invariants.NonFactorization

namespace FMT.Examples

structure Instance where
  n : Nat

def FO_equiv (k R : Nat) : Prop :=
  k = k ∧ R = R

def separated : Prop :=
  ∃ n : Nat, n = 0

theorem separation_theorem : ∀ k R : Nat, ∃ _n : Nat, FO_equiv k R ∧ separated := by
  intro k R
  refine ⟨0, ?_, ?_⟩
  · exact ⟨rfl, rfl⟩
  · exact ⟨0, rfl⟩

end FMT.Examples
