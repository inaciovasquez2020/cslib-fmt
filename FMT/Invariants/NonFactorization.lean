import FMT.Types.Factorization

namespace FMT.Invariants

open FMT.Types

def badF : LocalType → Nat := fun x => if x then 1 else 0

def nonFactorizingWitness : Prop :=
  ∃ f : LocalType → Nat, ¬ factorsThrough f

theorem explicit_nonfactorizing_function :
  ∃ f : LocalType → Nat, ¬ factorsThrough f := by
  refine ⟨badF, ?_⟩
  intro h
  rcases h with ⟨g, hg⟩
  have hff : badF false = badF true := by
    calc
      badF false = g (code false) := hg false
      _ = g (code true) := by simp [code]
      _ = badF true := (hg true).symm
  simp [badF] at hff

theorem nonFactorization_holds : nonFactorizingWitness :=
  explicit_nonfactorizing_function

end FMT.Invariants
