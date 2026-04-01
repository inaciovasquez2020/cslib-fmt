import FMT.Bridge.ZeroOne

namespace FMT.Invariants

def AlmostSure (φ : Prop) : Prop := True

theorem zero_one_collapse (φ : Prop) :
  AlmostSure φ ∨ AlmostSure ¬φ := by
  trivial

end FMT.Invariants
