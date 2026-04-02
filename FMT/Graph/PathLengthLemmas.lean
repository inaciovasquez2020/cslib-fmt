import FMT.Graph.PathLength

namespace FMT.Graph

universe u

variable {G : Graph}

/-- Reachability via a path witness of some finite length. -/
def Reachable (G : Graph) (u v : G.V) : Prop :=
  ∃ n : Nat, Nonempty (PathLength G u v n)

theorem reachable_refl (u : G.V) : Reachable G u u := by
  refine ⟨0, ?_⟩
  simpa [Reachable] using (pathLength_zero_iff (G := G) (u := u) (v := u)).2 rfl

theorem reachable_of_adj {u v : G.V} (h : G.Adj u v) : Reachable G u v := by
  refine ⟨1, ?_⟩
  exact pathLength_one_of_adj (G := G) h

end FMT.Graph
