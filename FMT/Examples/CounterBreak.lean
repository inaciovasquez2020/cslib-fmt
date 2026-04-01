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
def sameSep (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : Prop := separated G u v R

def sameFO (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : Prop := FO_equiv G u v R

theorem ef_trivializes : sameEF := by
  trivial

theorem sep_trivializes (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : sameSep G u v R ↔ FMT.Graph.dist G u v > R := by
  rfl

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
