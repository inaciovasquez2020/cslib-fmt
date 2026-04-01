import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Game.EF
import FMT.Types.LocalType
import FMT.Types.Factorization
import FMT.Examples.Separation
import FMT.Bridge.LocalGlobal
import FMT.Invariants.NonFactorization

namespace FMT.Spec

open Classical

structure FinalSolveSpec where
  dist_semantic : 
    ∀ (G : FMT.Graph.Graph), G.V → G.V → Nat
  ball_semantic : 
    ∀ (G : FMT.Graph.Graph), Nat → G.V → (G.V → Prop)
  indistinguishable_semantic : 
    Nat → Nat → Prop
  factorsThrough_semantic : 
    (FMT.Types.LocalType → Nat) → Prop
  separated_semantic : 
    ∀ (G : FMT.Graph.Graph), G.V → G.V → Nat → Prop
  localGlobal_semantic : 
    Prop
  nonFactorization_semantic : 
    Prop

/-- Realization of the FinalSolve specification using implemented modules -/
noncomputable abbrev canonicalFinalSolveSpec : FinalSolveSpec where
  dist_semantic := fun G u v => 
    let _ : DecidableEq G.V := Classical.typeDecidableEq G.V
    FMT.Graph.dist G u v
  ball_semantic := fun G R v => fun w => 
    let _ : DecidableEq G.V := Classical.typeDecidableEq G.V
    FMT.Graph.dist G v w ≤ R
  indistinguishable_semantic := fun k R => FMT.Game.indistinguishable k R
  factorsThrough_semantic := fun f => FMT.Types.factorsThrough f
  separated_semantic := fun G u v R => 
    let _ : DecidableEq G.V := Classical.typeDecidableEq G.V
    FMT.Graph.dist G u v > R
  localGlobal_semantic := FMT.Bridge.localToGlobal
  nonFactorization_semantic := FMT.Invariants.nonFactorizingWitness

noncomputable abbrev final_solve_spec : FinalSolveSpec :=
  canonicalFinalSolveSpec

end FMT.Spec
