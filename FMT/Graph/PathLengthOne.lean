import FMT.Graph.PathLength

namespace FMT.Graph

theorem pathLength_one_of_adj (G : Graph) {u v : G.V} (h : G.Adj u v) :
    Nonempty (PathLength G u v 1) := by
  refine ⟨⟨(fun i => if i.1 = 0 then u else v), ?_, ?_, ?_⟩⟩
  · simp
  · simp
  · intro i
    cases i using Fin.cases with
    | zero =>
        simpa
    | succ j =>
        exact False.elim (Nat.not_lt_zero _ j.2)

end FMT.Graph
