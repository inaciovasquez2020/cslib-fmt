import FMT.Spec.FinalSolve
import FMT.Graph

namespace FMT.API

/--
Interface to the formal specification for the final solve.
Ensures the Graph type matches the expected structural rigidity invariants.
-/
def final_solve_spec {G : FMT.Graph.Graph} (R : Nat) (u v w : G.V) : Prop :=
  FMT.Spec.separated G R u v w

end FMT.API
