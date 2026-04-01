import FMT.Types.LocalType
import FMT.Invariants.Eval
import FMT.API

namespace FMT.Invariants

theorem eval_coherence (t : FMT.Types.LocalType) :
  FMT.API.evalAPI t = FMT.Invariants.evalLocal t := by
  cases t <;> rfl

end FMT.Invariants
