import FMT.Graph.PathLength

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

end FMT.Graph
