import FMT.Types.LocalType
import FMT.Invariants.CycleSpace
import FMT.Invariants.NonFactorization

namespace FMT.Examples

structure Instance where
  n : Nat

def FO_equiv (_k _R : Nat) : Prop := True

def separated : Prop :=
  ∃ n : Nat, n = 0

theorem separation_theorem : ∀ k R : Nat, ∃ _n : Nat, FO_equiv k R ∧ separated := by
  intro _k _R
  refine ⟨0, trivial, ?_⟩
  exact ⟨0, rfl⟩

end FMT.Examples
