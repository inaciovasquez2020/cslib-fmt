import FMT.Graph.DistancePath

namespace FMT.Graph

variable {G : Graph}

theorem path_existence_to_distance_upper_bound
    {u v : G.V} {n : Nat} (hP : Nonempty (PathLength G u v n)) :
    ∃ d, dist? G u v = some d ∧ d ≤ n :=
  dist?_le_of_path (G := G) hP

theorem shortest_path_exists_of_finite_distance
    {u v : G.V} {n : Nat} (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) :=
  path_of_dist?_some (G := G) h

theorem shortest_path_minimality
    {u v : G.V} {n : Nat} (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) ∧
      ∀ m : Nat, m < n → ¬ Nonempty (PathLength G u v m) := by
  constructor
  · exact path_of_dist?_some (G := G) h
  · intro m hm hmP
    rcases dist?_le_of_path (G := G) (u := u) (v := v) (n := m) hmP with ⟨d, hd, hdm⟩
    have hdn : d = n := by
      rw [hd] at h
      cases h
      rfl
    have hnm : n ≤ m := by
      simpa [hdn] using hdm
    exact Nat.not_lt_of_ge hnm hm

end FMT.Graph
