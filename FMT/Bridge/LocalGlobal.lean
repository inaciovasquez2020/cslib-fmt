import FMT.Invariants.NonFactorization

namespace FMT.Bridge

def localToGlobal : Prop :=
  FMT.Types.factorsThrough FMT.Invariants.badF

theorem localToGlobal_holds : localToGlobal :=
  FMT.Invariants.badF_factorsThrough

end FMT.Bridge
