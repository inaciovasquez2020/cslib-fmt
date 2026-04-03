import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse
import FMT.Graph.PathLengthConcat

namespace FMT.Graph

def dist (G : Graph) (u v : G.V) : Nat :=
  Option.getD (dist? G u v) 0

theorem dist_eq_zero_of_eq (G : Graph) (u : G.V) :
  dist G u u = 0 := by
  unfold dist dist?
  simp

theorem dist_le_of_pathLength
  (G : Graph) {u v : G.V} {n : Nat}
  (h : Nonempty (PathLength G u v n)) :
  dist G u v ≤ n := by
  unfold dist dist?
  split_ifs with hex
  · have hmin := Nat.find_min' hex
    exact hmin n h
  · cases h with
    | intro p =>
      cases p

theorem dist_symm (G : Graph) (u v : G.V) :
  dist G u v = dist G v u := by
  unfold dist dist?
  by_cases h₁ : ∃ n, Nonempty (PathLength G u v n)
  · have h₂ : ∃ n, Nonempty (PathLength G v u n) := by
      rcases h₁ with ⟨n, h⟩
      exact ⟨n, ⟨pathLength_reverse G h.some⟩⟩
    simp [h₁, h₂]
  · have h₂ : ¬ ∃ n, Nonempty (PathLength G v u n) := by
      intro h
      rcases h with ⟨n, h'⟩
      have : Nonempty (PathLength G u v n) :=
        ⟨pathLength_reverse G h'.some⟩
      contradiction
    simp [h₁, h₂]

theorem dist_triangle (G : Graph) (u v w : G.V) :
  dist G u w ≤ dist G u v + dist G v w := by
  unfold dist dist?
  by_cases huv : ∃ n, Nonempty (PathLength G u v n)
  · by_cases hvw : ∃ n, Nonempty (PathLength G v w n)
    · rcases huv with ⟨m, hm⟩
      rcases hvw with ⟨n, hn⟩
      have hcat :
        Nonempty (PathLength G u w (m+n)) :=
        ⟨pathLength_concat G hm.some hn.some⟩
      have := Nat.find_min' (by exact huv)
      have := this (m+n) hcat
      exact this.trans (Nat.le_add_left _ _)
    · simp [hvw]
  · simp [huv]

end FMT.Graph
