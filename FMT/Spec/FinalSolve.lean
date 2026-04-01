import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Game.EF
import FMT.Game.BoundedRadiusEF
import FMT.Types.Factorization
import FMT.Invariants.NonFactorization
import FMT.Bridge.LocalGlobal

namespace FMT.Spec

class FinalSolveSpec where
  dist_semantic :
    ∀ (G : FMT.Graph.Graph), G.V → G.V → Nat
  ball_semantic :
    ∀ (G : FMT.Graph.Graph), Nat → G.V → (G.V → Prop)
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

noncomputable abbrev canonicalFinalSolveSpec : FinalSolveSpec where
  dist_semantic := fun G u v => FMT.Graph.dist G u v
  ball_semantic := fun G R v => fun w => FMT.Graph.dist G v w ≤ R
  indistinguishable_semantic := fun k R => FMT.Game.indistinguishable k R
  factorsThrough_semantic := fun f => FMT.Types.factorsThrough f
  separated_semantic := fun G _ u v R => by
    classical
    exact FMT.Graph.dist G u v > R
  localGlobal_semantic := FMT.Bridge.localToGlobal
  nonFactorization_semantic := FMT.Invariants.nonFactorizingWitness

noncomputable abbrev final_solve_spec : FinalSolveSpec :=
  canonicalFinalSolveSpec

end FMT.Spec
