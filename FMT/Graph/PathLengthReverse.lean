import FMT.Graph.PathLength
import FMT.Graph.PathLengthAccessors
import FMT.Graph.PathLengthReverseScratch

namespace FMT.Graph

def pathLength_reverse
  (G : Graph)
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  {u v : G.V} {n : Nat} :
  PathLength G u v n → PathLength G v u n := by
  intro P
  refine
    { verts := fun i => P.verts (revFin i)
      start := ?_
      finish := ?_
      step := ?_ }
  ·
    have hlast : (revFin ⟨0, Nat.succ_pos n⟩).1 = n := by
      simp [revFin]
    simpa [revFin, hlast] using P.finish
  ·
    have hzero : (revFin ⟨n, Nat.lt_succ_self n⟩).1 = 0 := by
      simp [revFin]
    simpa [revFin, hzero] using P.start
  ·
    intro i
    have hi1 : i.1 + 1 ≤ n := Nat.succ_le_of_lt i.2
    have hn : 0 < n := Nat.lt_of_lt_of_le (Nat.succ_pos _) hi1
    let j : Fin n := ⟨n - (i.1 + 1), by
      have : n - (i.1 + 1) < n := Nat.sub_lt hn (Nat.succ_pos _)
      simpa using this⟩
    have hrev_succ_val :
        (revFin ⟨i.1 + 1, Nat.succ_lt_succ i.2⟩).1 = j.1 := by
      simp [revFin, j]
    have hcalc : n - i.1 = j.1 + 1 := by
      have : n - i.1 = (n - (i.1 + 1)) + 1 := by
        omega
      simpa [j] using this
    have hrev_curr_val :
        (revFin ⟨i.1, Nat.lt_trans i.2 (Nat.lt_succ_self n)⟩).1 = j.1 + 1 := by
      simp [revFin, hcalc]
    have hstep := P.step j
    change G.Adj (P.verts ⟨n - i.1, Nat.lt_succ_of_le (Nat.sub_le _ _)⟩)
      (P.verts ⟨n - (i.1 + 1), Nat.lt_succ_of_le (Nat.sub_le _ _)⟩)
    have hleft :
        P.verts ⟨n - i.1, Nat.lt_succ_of_le (Nat.sub_le _ _)⟩
          =
        P.verts ⟨j.1 + 1, Nat.succ_lt_succ j.2⟩ := by
      congr
    have hright :
        P.verts ⟨n - (i.1 + 1), Nat.lt_succ_of_le (Nat.sub_le _ _)⟩
          =
        P.verts ⟨j.1, Nat.lt_trans j.2 (Nat.lt_succ_self n)⟩ := by
      congr
    rw [hleft, hright]
    exact hsymm _ _ hstep

end FMT.Graph
