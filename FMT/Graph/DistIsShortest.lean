import FMT.Graph.DistanceCore
import FMT.Graph.ExistsMinPath

namespace FMT.Graph

theorem dist_is_shortest
  {G : Graph} (u v : G.V) :
  dist? (G:=G) u v = none ∨
  ∃ d, dist? (G:=G) u v = some d ∧
       ∀ m, m < d → ¬ Nonempty (PathLength G u v m) := by
  classical
  unfold dist?
  by_cases h : ∃ n, Nonempty (PathLength G u v n)
  · right
    refine ⟨Classical.choose (exists_min_pathLength (G:=G) u v h), ?_, ?_⟩
    · simp [h]
    · exact (Classical.choose_spec (exists_min_pathLength (G:=G) u v h)).2
  · left
    simp [h]

end FMT.Graph
