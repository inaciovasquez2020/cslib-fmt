import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Graph.BoundedRadius
import FMT.Game.EF
import FMT.Types.Factorization
import FMT.Examples.Separation
import FMT.API.FinalSolve

namespace FMT.Examples

axiom G1 : Type
axiom G2 : Type

def sameEF : Prop := FMT.Game.indistinguishable 2 1
def sameSep : Prop := separated

theorem ef_trivializes : sameEF := by
  trivial

theorem sep_trivializes : sameSep := by
  exact ⟨0, rfl⟩

theorem dist_self (G : FMT.Graph.Graph) [DecidableEq G.V] (u : G.V) :
    FMT.Graph.dist G u u = 0 := by
  simp [FMT.Graph.dist]

theorem ball_is_universal (G : FMT.Graph.Graph) (r : Nat) (v : G.V) :
    Nonempty (FMT.Graph.Ball (G := G) r) := by
  exact ⟨v⟩

theorem api_is_axiomatic :
    FMT.API.finalSolveSpec = FMT.Spec.final_solve_spec := by
  rfl

end FMT.Examples
