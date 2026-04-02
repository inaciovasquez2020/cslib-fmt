import FMT.Graph.ExistsMinPathLength

namespace FMT.Graph

noncomputable def shortest_path_selector
  (G : Graph) (u v : G.V) :
  Option { n : Nat // Nonempty (PathLength G u v n) ∧
    ∀ m : Nat, m < n → ¬ Nonempty (PathLength G u v m) } := by
  classical
  by_cases h : ∃ n : Nat, Nonempty (PathLength G u v n)
  · let hs := exists_min_pathLength G u v h
    exact some ⟨Classical.choose hs, (Classical.choose_spec hs).1, (Classical.choose_spec hs).2⟩
  · exact none

theorem shortest_path_selector_complete
  (G : Graph) (u v : G.V) {n : Nat}
  (hP : Nonempty (PathLength G u v n)) :
  ∃ s, shortest_path_selector G u v = some s := by
  classical
  let h : ∃ m : Nat, Nonempty (PathLength G u v m) := ⟨n, hP⟩
  let hs := exists_min_pathLength G u v h
  refine ⟨⟨Classical.choose hs, (Classical.choose_spec hs).1, (Classical.choose_spec hs).2⟩, ?_⟩
  unfold shortest_path_selector
  simp [h]

end FMT.Graph
