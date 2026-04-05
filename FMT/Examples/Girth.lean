import FMT.Spec.FinalSolve

namespace FMT.Examples

open FMT.Graph
open FMT.Spec

variable {G : Graph}

example (R : Nat) (u v w : G.V)
    (hvw : ∃ d, dist? G v w = some d ∧ d ≤ R)
    (huv : ∀ d, dist? (G:=G) u v = some d → R < d) :
    separated G R u v w := by
  exact ⟨hvw, huv⟩

end FMT.Examples
