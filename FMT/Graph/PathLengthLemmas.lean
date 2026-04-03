import FMT.Graph.PathLength
import FMT.Graph.PathLengthOne

namespace FMT.Graph

theorem pathLength_zero_iff (G : Graph) (u v : G.V) :
    Nonempty (PathLength G u v 0) ↔ u = v := by
  constructor
  · intro h
    rcases h with ⟨h⟩
    exact h.start.symm.trans h.finish
  · intro huv
    refine ⟨⟨fun _ => u, rfl, ?_, ?_⟩⟩
    · simp [huv]
    · intro i
      exact False.elim (Nat.not_lt_zero _ i.2)

def Reachable (G : Graph) (u v : G.V) : Prop :=
  ∃ n : Nat, Nonempty (PathLength G u v n)

theorem reachable_refl (G : Graph) (u : G.V) : Reachable G u u := by
  refine ⟨0, ?_⟩
  simpa [Reachable] using (pathLength_zero_iff G u u).2 rfl

theorem reachable_of_adj (G : Graph) {u v : G.V} (h : G.Adj u v) : Reachable G u v := by
  refine ⟨1, ?_⟩
  exact pathLength_one_of_adj G h

end FMT.Graph
