import FMT.Invariants.NonFactorization

namespace FMT.Examples

open FMT.Invariants
open FMT.Types

example : ¬ factorsThrough badF := by
  intro h
  have hneq : badF LocalType.zero ≠ badF LocalType.one := by
    simp [badF]
  have heq : badF LocalType.zero = badF LocalType.one := by
    rcases h with ⟨g, hg⟩
    calc
      badF LocalType.zero = g (code LocalType.zero) := hg LocalType.zero
      _ = g (code LocalType.one) := by simp [code]
      _ = badF LocalType.one := (hg LocalType.one).symm
  exact hneq heq

end FMT.Examples
