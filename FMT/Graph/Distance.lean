import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse
import FMT.Graph.PathLengthConcat

open Classical

namespace FMT.Graph

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

theorem dist_eq_zero_of_eq (G : Graph) (u : G.V) :
  dist G u u = 0 := by
  unfold dist dist?
  by_cases h : ∃ n, Nonempty (PathLength G u u n)
  · simp [h]
  · simp [h]

theorem dist_le_of_pathLength
  (G : Graph) {u v : G.V} {n : Nat}
  (h : Nonempty (PathLength G u v n)) :
  dist G u v ≤ n := by
  classical
  unfold dist dist?
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · simp [hex]
  · cases hex ⟨n, h⟩

theorem dist_symm (G : Graph) (u v : G.V) :
  dist G u v = dist G v u := by
  classical
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
  classical
  unfold dist dist?
  by_cases huv : ∃ m, Nonempty (PathLength G u v m)
  · by_cases hvw : ∃ n, Nonempty (PathLength G v w n)
    · rcases huv with ⟨m, hm⟩
      rcases hvw with ⟨n, hn⟩
      have hcat :
        Nonempty (PathLength G u w (m+n)) :=
        ⟨pathLength_concat G hm.some hn.some⟩
      simp [huv, hvw]
    · simp [hvw]
  · simp [huv]

end FMT.Graph
