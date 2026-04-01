import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Graph.BoundedRadius
import FMT.Game.EF
import FMT.Types.Factorization
import FMT.Examples.Separation
import FMT.API.FinalSolve

namespace FMT.Examples

axiom G1 G2 : Type

def sameEF : Prop := FMT.Game.indistinguishable 2 1
def sameSep : Prop := separated

theorem ef_trivializes : sameEF := by
  trivial

theorem sep_trivializes : sameSep := by
  trivial

theorem dist_collapses (G : FMT.Graph.Graph) (u v : G.V) :
    FMT.Graph.dist G u v = 0 := by
  rfl

theorem ball_is_universal (G : FMT.Graph.Graph) (r : Nat) (v : G.V) :
    Nonempty (FMT.Graph.Ball G r v) := by
  exact ⟨v, trivial⟩

theorem api_is_axiomatic :
    FMT.API.finalSolveSpec = FMT.Spec.final_solve_spec := by
  rfl

end FMT.Examples
