import FMT.Types.Factorization

namespace FMT.Invariants

def nonFactorizingWitness : Prop :=
  ∃ f : FMT.Types.LocalType → Nat, ¬ FMT.Types.factorsThrough f

theorem explicit_nonfactorizing_function :
  ∃ f : FMT.Types.LocalType → Nat, ¬ FMT.Types.factorsThrough f := by
  refine ⟨fun b => cond b 1 0, ?_⟩
  intro h
  rcases h with ⟨g, hg⟩
  have h0 : 0 = g 0 := by
    simpa [FMT.Types.code] using hg false
  have h1 : 1 = g 0 := by
    simpa [FMT.Types.code] using hg true
  have : (0 : Nat) = 1 := by
    calc
      0 = g 0 := h0
      _ = 1 := h1.symm
  exact Nat.zero_ne_one this

theorem nonFactorization_holds : nonFactorizingWitness := by
  exact explicit_nonfactorizing_function

end FMT.Invariants
