import FMT.Graph.DistancePath
import FMT.Graph.PathLengthReverse

namespace FMT.Graph

theorem dist?_symm
  {G : Graph} [FMT.Inputs.SLASHAxioms G]
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  (u v : G.V) :
  dist? (G:=G) u v = dist? (G:=G) v u := by
  classical
  cases huv : dist? (G:=G) u v with
  | none =>
      cases hvu : dist? (G:=G) v u with
      | none => rfl
      | some n =>
          have hpvu : Nonempty (PathLength G v u n) := path_of_dist?_some G hvu
          rcases hpvu with ⟨P⟩
          have hpuv : Nonempty (PathLength G u v n) := ⟨pathLength_reverse G hsymm P⟩
          rcases dist?_le_of_path G u v hpuv with ⟨d, hd, _⟩
          rw [huv] at hd
  | some m =>
      cases hvu : dist? (G:=G) v u with
      | none =>
          have hpuv : Nonempty (PathLength G u v m) := path_of_dist?_some G huv
          rcases hpuv with ⟨P⟩
          have hpvu : Nonempty (PathLength G v u m) := ⟨pathLength_reverse G hsymm P⟩
          rcases dist?_le_of_path G v u hpvu with ⟨d, hd, _⟩
          rw [hvu] at hd
      | some n =>
          have hpuv : Nonempty (PathLength G u v m) := path_of_dist?_some G huv
          have hpvu : Nonempty (PathLength G v u n) := path_of_dist?_some G hvu
          rcases hpuv with ⟨Puv⟩
          rcases hpvu with ⟨Pvu⟩
          have hpvu_from_m : Nonempty (PathLength G v u m) :=
            ⟨pathLength_reverse G hsymm Puv⟩
          have hpuv_from_n : Nonempty (PathLength G u v n) :=
            ⟨pathLength_reverse G hsymm Pvu⟩
          have hnle : n ≤ m := by
            rcases dist?_le_of_path G v u hpvu_from_m with ⟨d, hd, hle⟩
            rw [hvu] at hd
            cases hd
            exact hle
          have hmle : m ≤ n := by
            rcases dist?_le_of_path G u v hpuv_from_n with ⟨d, hd, hle⟩
            rw [huv] at hd
            cases hd
            exact hle
          have hmn : m = n := Nat.le_antisymm hmle hnle
          rw [hmn]

end FMT.Graph
