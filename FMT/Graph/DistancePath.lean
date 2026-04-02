import FMT.Graph.PathLengthLemmas
import FMT.Graph.ShortestPathSelector

namespace FMT.Graph

variable {G : Graph}

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  match shortest_path_selector G u v with
  | some s => some s.1
  | none => none

theorem dist?_some_iff {u v : G.V} {n : Nat} :
    dist? G u v = some n ↔
      ∃ s, shortest_path_selector G u v = some s ∧ s.1 = n := by
  unfold dist?
  cases hsel : shortest_path_selector G u v with
  | none =>
      simp
  | some s =>
      simp [hsel]

theorem dist?_none_iff {u v : G.V} :
    dist? G u v = none ↔ shortest_path_selector G u v = none := by
  unfold dist?
  cases hsel : shortest_path_selector G u v with
  | none =>
      simp
  | some s =>
      simp [hsel]

theorem path_of_dist?_some {u v : G.V} {n : Nat} (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) := by
  rcases (dist?_some_iff (G := G) (u := u) (v := v) (n := n)).1 h with ⟨s, hs, hn⟩
  simpa [hn] using s.2.1

theorem dist?_le_of_path {u v : G.V} {n : Nat} (hP : Nonempty (PathLength G u v n)) :
    ∃ d, dist? G u v = some d ∧ d ≤ n := by
  rcases shortest_path_selector_complete G u v hP with ⟨s, hs⟩
  refine ⟨s.1, ?_, ?_⟩
  · unfold dist?
    simp [hs]
  · by_cases hlt : n < s.1
    · exact False.elim ((s.2.2 n hlt) hP)
    · exact Nat.le_of_not_gt hlt

theorem dist?_zero_of_eq {u v : G.V} (h : u = v) : dist? G u v = some 0 := by
  subst v
  have hP : Nonempty (PathLength G u u 0) := by
    simpa using (pathLength_zero_iff G u u).2 rfl
  rcases dist?_le_of_path (G := G) (u := u) (v := u) (n := 0) hP with ⟨d, hd, hle⟩
  have hd0 : d = 0 := Nat.eq_zero_of_le_zero hle
  simpa [hd0] using hd

theorem eq_of_dist?_zero {u v : G.V} (h : dist? G u v = some 0) : u = v := by
  have hP : Nonempty (PathLength G u v 0) := path_of_dist?_some (G := G) h
  simpa using (pathLength_zero_iff G u v).1 hP

theorem dist?_zero_iff_eq {u v : G.V} :
    dist? G u v = some 0 ↔ u = v := by
  constructor
  · exact eq_of_dist?_zero (G := G)
  · intro h
    exact dist?_zero_of_eq (G := G) h

end FMT.Graph
