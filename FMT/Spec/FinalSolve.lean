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
    (FMT.Types.LocalType → Nat) → Prop
  separated_semantic :
    ∀ (G : FMT.Graph.Graph), [DecidableEq G.V] → G.V → G.V → Nat → Prop
  localGlobal_semantic :
    Prop
  nonFactorization_semantic :
    Prop

abbrev canonicalFinalSolveSpec : FinalSolveSpec where
  dist_semantic := fun G u v => FMT.Graph.dist G u v
  ball_semantic := fun G R v => FMT.Graph.Ball (G := G) R
  indistinguishable_semantic := fun k R => FMT.Game.indistinguishable k R
  factorsThrough_semantic := fun f => FMT.Types.factorsThrough f
  separated_semantic := fun G _ u v R => by
    let _ : DecidableEq G.V := Classical.decEq _
    exact FMT.Examples.separated G u v R
  localGlobal_semantic := FMT.Bridge.localToGlobal
  nonFactorization_semantic := FMT.Invariants.nonFactorizingWitness

abbrev final_solve_spec : FinalSolveSpec :=
  canonicalFinalSolveSpec

end FMT.Spec
