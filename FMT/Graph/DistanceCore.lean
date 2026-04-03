import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

axiom shortest_path_length
  (G : Graph) (u v : G.V) :
  ∃ d : Nat,
    Nonempty (PathLength G u v d) ∧
    (∀ m, m < d → ¬ Nonempty (PathLength G u v m))

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  some (Classical.choose (shortest_path_length G u v))

theorem shortest_path_selector
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) := by
  unfold dist? at h
  rcases Classical.choose_spec (shortest_path_length G u v) with ⟨hpath, _⟩
  cases h
  exact hpath

theorem path_of_dist?_some
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  Nonempty (PathLength G u v n) :=
  shortest_path_selector G h

theorem dist?_minimal
  (G : Graph) {u v : G.V} {n : Nat}
  (h : dist? G u v = some n) :
  ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  unfold dist? at h
  rcases Classical.choose_spec (shortest_path_length G u v) with ⟨_, hmin⟩
  cases h
  exact hmin

theorem dist?_cases (G : Graph) (u v : G.V) :
  ∃ n, dist? G u v = some n := by
  refine ⟨Classical.choose (shortest_path_length G u v), rfl⟩

end FMT.Graph
