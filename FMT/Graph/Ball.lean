import FMT.Graph.DistRefl
import FMT.Inputs.ConstructiveSLASHAxioms

namespace FMT.Graph

def Ball (G : Graph) (u : G.V) (r : Nat) : Set G.V :=
  {v | ∃ d, dist? (G:=G) u v = some d ∧ d ≤ r}

theorem memBall_iff
    (G : Graph) [Inputs.SLASHAxioms G] (u v : G.V) (r : Nat) :
    v ∈ Ball G u r ↔ ∃ d, dist? (G:=G) u v = some d ∧ d ≤ r := by
  rfl

theorem center_mem_ball
    (G : Graph) [Inputs.SLASHAxioms G] (u : G.V) (r : Nat) :
    u ∈ Ball G u r := by
  exact ⟨0, dist?_refl G u, Nat.zero_le r⟩

theorem ball_mono
    (G : Graph) [Inputs.SLASHAxioms G] (u : G.V) {r s : Nat}
    (hrs : r ≤ s) :
    Ball G u r ⊆ Ball G u s := by
  intro v hv
  rcases hv with ⟨d, hd, hdr⟩
  exact ⟨d, hd, Nat.le_trans hdr hrs⟩

end FMT.Graph
