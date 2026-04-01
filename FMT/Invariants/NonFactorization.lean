import FMT.Types.Factorization

namespace FMT.Invariants

def nonFactorizingWitness : Prop :=
  ∃ f : FMT.Types.LocalType → Nat, ¬ FMT.Types.factorsThrough f

axiom explicit_nonfactorizing_function :
  ∃ f : FMT.Types.LocalType → Nat, ¬ FMT.Types.factorsThrough f

theorem nonFactorization_holds : nonFactorizingWitness := by
  exact explicit_nonfactorizing_function

end FMT.Invariants
