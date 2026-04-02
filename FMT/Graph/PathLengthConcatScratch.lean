import FMT.Graph.PathLength
import FMT.Graph.PathLengthAccessors
import FMT.Graph.PathLengthLemmas

namespace FMT.Graph

def concatVerts {G : Graph} {u v w : G.V} {m n : Nat}
    (P : PathLength G u v m) (Q : PathLength G v w n) :
    Fin (m + n + 1) → G.V :=
  fun i =>
    if h : i.1 < m + 1 then
      P.verts ⟨i.1, h⟩
    else
      Q.verts ⟨i.1 - m, by
        have himn : i.1 < m + n + 1 := i.2
        omega⟩

def pathLength_concat_scratch (G : Graph) {u v w : G.V} {m n : Nat} :
    PathLength G u v m → PathLength G v w n → PathLength G u w (m + n) := by
  intro P Q
  refine
    { verts := concatVerts P Q
      start := ?_
      finish := ?_
      step := ?_ }
  · simpa [concatVerts] using P.start
  · cases n with
    | zero =>
        have hvw : v = w := by
          exact Q.start.symm.trans Q.finish
        simp [concatVerts, P.finish, hvw]
    | succ n_prev =>
        have hlast : ¬ (m + (n_prev + 1) < m + 1) := by
          omega
        simp [concatVerts, hlast, Q.finish]
  · intro i
    by_cases hleft : i.1 < m
    · have hcur : i.1 < m + 1 := by omega
      have hnext : i.1 + 1 < m + 1 := by omega
      simpa [concatVerts, hcur, hnext] using P.step ⟨i.1, hleft⟩
    · by_cases hmid : i.1 = m
      · cases n with
        | zero =>
            exfalso
            omega
        | succ n_prev =>
            have hcur : i.1 < m + 1 := by omega
            have hnext : ¬ (i.1 + 1 < m + 1) := by omega
            have hjoin :
                concatVerts P Q ⟨i.1, Nat.lt_trans i.2 (Nat.lt_succ_self (m + (n_prev + 1)))⟩ = v := by
              simpa [concatVerts, hmid, hcur] using P.finish
            have hidx : i.1 + 1 - m = 1 := by
              omega
            have hnextv :
                concatVerts P Q ⟨i.1 + 1, Nat.succ_lt_succ i.2⟩ =
                  Q.verts ⟨1, Nat.succ_lt_succ (Nat.succ_pos n_prev)⟩ := by
              simp [concatVerts, hnext, hidx]
            have hadj0 : G.Adj (Q.verts ⟨0, Nat.succ_pos (n_prev + 1)⟩)
                                (Q.verts ⟨1, Nat.succ_lt_succ (Nat.succ_pos n_prev)⟩) := by
              simpa using (PathLength.start_adj Q)
            have hadj : G.Adj v (Q.verts ⟨1, Nat.succ_lt_succ (Nat.succ_pos n_prev)⟩) := by
              have hsq := hadj0
              rw [Q.start] at hsq
              exact hsq
            exact hjoin.symm ▸ hnextv.symm ▸ hadj
      · have hcur : ¬ (i.1 < m + 1) := by
          omega
        have hnext : ¬ (i.1 + 1 < m + 1) := by
          omega
        have hi : i.1 - m < n := by
          have hi_top : i.1 < m + n := i.2
          omega
        have hsucc : (i.1 + 1) - m = (i.1 - m) + 1 := by
          omega
        simpa [concatVerts, hcur, hnext, hsucc] using Q.step ⟨i.1 - m, hi⟩

end FMT.Graph
