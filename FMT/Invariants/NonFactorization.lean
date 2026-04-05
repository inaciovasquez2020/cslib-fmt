import FMT.Types.Factorization

namespace FMT.Invariants

open FMT.Types

def badF : LocalType → Nat
| .zero => 0
| .one  => 1

def nonFactorizingWitness : Prop :=
  ∃ f : LocalType → Nat, ¬ factorsThrough f

theorem explicit_nonfactorizing_function :
  ∃ f : LocalType → Nat, ¬ factorsThrough f := by
  refine ⟨badF, ?_⟩
  intro h
  rcases h with ⟨g, hg⟩
  have hff : badF LocalType.zero = badF LocalType.one := by
    calc
      badF LocalType.zero = g (code LocalType.zero) := hg LocalType.zero
      _ = g (code LocalType.one) := by simp [code]
      _ = badF LocalType.one := (hg LocalType.one).symm
  simp [badF] at hff

theorem nonFactorization_holds : nonFactorizingWitness :=
  explicit_nonfactorizing_function

end FMT.Invariants
