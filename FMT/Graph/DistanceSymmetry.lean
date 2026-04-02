import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse
import FMT.Graph.Distance

namespace FMT.Graph

theorem dist?_symm (G : Graph)
    (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
    (u v : G.V) :
    dist? G u v = dist? G v u := by
  cases huv : dist? G u v with
  | none =>
      cases hvu : dist? G v u with
      | none =>
          rfl
      | some m =>
          exfalso
          have hPvu : Nonempty (PathLength G v u m) := path_of_dist?_some (G := G) hvu
          rcases hPvu with ⟨P⟩
          rcases dist?_le_of_path
              (G := G)
              (u := u) (v := v) (n := m)
              (show Nonempty (PathLength G u v m) from ⟨pathLength_reverse G hsymm P⟩) with
            ⟨d, hd, _⟩
          simp [huv] at hd
  | some n =>
      cases hvu : dist? G v u with
      | none =>
          exfalso
          have hPuv : Nonempty (PathLength G u v n) := path_of_dist?_some (G := G) huv
          rcases hPuv with ⟨P⟩
          rcases dist?_le_of_path
              (G := G)
              (u := v) (v := u) (n := n)
              (show Nonempty (PathLength G v u n) from ⟨pathLength_reverse G hsymm P⟩) with
            ⟨d, hd, _⟩
          simp [hvu] at hd
      | some m =>
          have hPuv : Nonempty (PathLength G u v n) := path_of_dist?_some (G := G) huv
          have hPvu : Nonempty (PathLength G v u m) := path_of_dist?_some (G := G) hvu
          rcases hPuv with ⟨Puv⟩
          rcases hPvu with ⟨Pvu⟩
          rcases dist?_le_of_path
              (G := G)
              (u := v) (v := u) (n := n)
              (show Nonempty (PathLength G v u n) from ⟨pathLength_reverse G hsymm Puv⟩) with
            ⟨d1, hd1, h1⟩
          have hm_le_n : m ≤ n := by
            rw [hvu] at hd1
            cases hd1
            exact h1
          rcases dist?_le_of_path
              (G := G)
              (u := u) (v := v) (n := m)
              (show Nonempty (PathLength G u v m) from ⟨pathLength_reverse G hsymm Pvu⟩) with
            ⟨d2, hd2, h2⟩
          have hn_le_m : n ≤ m := by
            rw [huv] at hd2
            cases hd2
            exact h2
          have h_eq : n = m := by
            omega
          simp [h_eq]

theorem dist_symm (G : Graph)
    (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
    (u v : G.V) :
    dist G u v = dist G v u := by
  unfold dist
  rw [dist?_symm G hsymm u v]

end FMT.Graph
