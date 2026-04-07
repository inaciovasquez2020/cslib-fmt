import FMT.Graph.Distance
import FMT.Graph.DistancePath

namespace FMT.Graph

theorem dist_eq_of_no_shorter_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n))
  (hmin : ∀ m, m < n → ¬ Nonempty (PathLength G u v m)) :
  ∃ d, dist? (G:=G) u v = some d ∧ d = n := by
  rcases dist?_le_of_path G hpath with ⟨d, hd, hle⟩
  have hpd : Nonempty (PathLength G u v d) := path_of_dist?_some G hd
  have hnd : ¬ d < n := by
    intro hlt
    exact hmin d hlt hpd
  have hge : n ≤ d := Nat.le_of_not_gt hnd
  have hEq : d = n := Nat.le_antisymm hle hge
  exact ⟨d, hd, hEq⟩

theorem dist?_some_iff_shortest
  (G : Graph) [Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
  dist? (G:=G) u v = some n ↔
    Nonempty (PathLength G u v n) ∧
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  constructor
  · intro h
    constructor
    · exact path_of_dist?_some G h
    · intro m hm
      intro hpm
      rcases dist?_le_of_path G hpm with ⟨d, hd, hdm⟩
      rw [h] at hd
      cases hd
      exact Nat.not_lt_of_ge hdm hm
  · intro h
    rcases h with ⟨hpath, hmin⟩
    rcases dist_eq_of_no_shorter_path G hpath hmin with ⟨d, hd, hEq⟩
    simpa [hEq] using hd

end FMT.Graph
