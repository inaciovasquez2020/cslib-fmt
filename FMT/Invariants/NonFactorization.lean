import FMT.Types.Factorization

namespace FMT.Invariants

def nonFactorizingWitness : Prop :=
  ∃ f : FMT.Types.LocalType → Nat, ¬ FMT.Types.factorsThrough f

axiom nonFactorizingWitness_exists : nonFactorizingWitness

end FMT.Invariants
