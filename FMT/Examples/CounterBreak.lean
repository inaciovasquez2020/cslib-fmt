import FMT.API.FinalSolve
import FMT.Examples.Separation

namespace FMT.Examples

def sameEF : Prop := FMT.Game.indistinguishable 2 1

theorem ef_trivializes : sameEF := by
  unfold sameEF FMT.Game.indistinguishable
  exact ⟨rfl, rfl⟩

theorem sep_trivializes :
    ∃ n : Nat, n = 0 := by
  exact ⟨0, rfl⟩

theorem dist_self (G : FMT.Graph.Graph) [DecidableEq G.V] (u : G.V) :
    FMT.Graph.dist G u u = 0 := by
  simp [FMT.Graph.dist]

theorem api_is_axiomatic :
    FMT.API.finalSolveSpec = FMT.Spec.final_solve_spec := by
  rfl

end FMT.Examples
