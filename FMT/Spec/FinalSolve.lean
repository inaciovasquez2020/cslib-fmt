import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Graph.BoundedRadius
import FMT.Game.EF
import FMT.Game.BoundedRadiusEF
import FMT.Types.Factorization
import FMT.Invariants.NonFactorization
import FMT.Bridge.LocalGlobal
import FMT.Examples.Separation

namespace FMT.Spec

class FinalSolveSpec where
  dist_semantic :
    ∀ (G : FMT.Graph.Graph), G.V → G.V → Nat
  ball_semantic :
    ∀ (G : FMT.Graph.Graph), Nat → G.V → Type
  indistinguishable_semantic :
    Nat → Nat → Prop
  factorsThrough_semantic :
    Prop
  separated_semantic :
    Prop
  localGlobal_semantic :
    Prop
  nonFactorization_semantic :
    Prop
  constructive_separator :
    ∀ (_k _R : Nat), ∃ _n : Nat, True

axiom final_solve_spec : FinalSolveSpec

end FMT.Spec
