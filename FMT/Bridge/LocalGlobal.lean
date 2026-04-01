import FMT.Examples.Separation

namespace FMT.Bridge

def localToGlobal : Prop :=
  ∀ (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat),
    FMT.Examples.separated G u v R → ¬ FMT.Examples.FO_equiv G u v R

theorem localToGlobal_witness : localToGlobal := by
  intro G _ u v R hsep
  exact FMT.Examples.separated_not_fo_equiv G u v R hsep

end FMT.Bridge
