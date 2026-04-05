import FMT.Invariants.NonFactorization

namespace FMT.Bridge

def localToGlobal : Prop :=
  FMT.Invariants.nonFactorizingWitness

theorem localToGlobal_holds : localToGlobal :=
  FMT.Invariants.nonFactorization_holds

end FMT.Bridge
