import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse

namespace FMT.Graph

theorem dist?_symm
    (G : Graph)
    (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
    (u v : G.V) :
    dist? G u v = dist? G v u := by
  cases huv : dist? G u v with
  | none =>
      cases hvu : dist? G v u with
      | none =>
          simp [hvu]
      | some m =>
          exfalso
          have hP : Nonempty (PathLength G v u m) := path_of_dist?_some (G := G) hvu
          have hR : Nonempty (PathLength G u v m) := by
            rcases hP with ⟨P⟩
            exact ⟨pathLength_reverse G hsymm P⟩
          rcases dist?_le_of_path (G := G) (u := u) (v := v) (n := m) hR with ⟨d, hd, _⟩
          simp [huv] at hd
  | some n =>
      cases hvu : dist? G v u with
      | none =>
          exfalso
          have hP : Nonempty (PathLength G u v n) := path_of_dist?_some (G := G) huv
          have hR : Nonempty (PathLength G v u n) := by
            rcases hP with ⟨P⟩
            exact ⟨pathLength_reverse G hsymm P⟩
          rcases dist?_le_of_path (G := G) (u := v) (v := u) (n := n) hR with ⟨d, hd, _⟩
          simp [hvu] at hd
      | some m =>
          have hPuv : Nonempty (PathLength G u v n) := path_of_dist?_some (G := G) huv
          have hPvu : Nonempty (PathLength G v u m) := path_of_dist?_some (G := G) hvu
          rcases dist?_le_of_path (G := G) (u := v) (v := u) (n := n) (by
            rcases hPuv with ⟨P⟩
            exact ⟨pathLength_reverse G hsymm P⟩) with ⟨d1, hd1, h1⟩
          rcases dist?_le_of_path (G := G) (u := u) (v := v) (n := m) (by
            rcases hPvu with ⟨P⟩
            exact ⟨pathLength_reverse G hsymm P⟩) with ⟨d2, hd2, h2⟩
          have hm_le_n : m ≤ n := by
            rw [hvu] at hd1
            cases hd1
            simpa using h1
          have hn_le_m : n ≤ m := by
            rw [huv] at hd2
            cases hd2
            simpa using h2
          have hmn : m = n := Nat.le_antisymm hm_le_n hn_le_m
          simp [hvu, hmn]

end FMT.Graph
