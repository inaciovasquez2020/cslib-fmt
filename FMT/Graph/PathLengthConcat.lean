import FMT.Graph.PathLength

namespace FMT.Graph

def pathLength_concat (G : Graph) {u v w : G.V} {m n : Nat}
    (P : PathLength G u v m) (Q : PathLength G v w n) :
    PathLength G u w (m + n) :=
  let verts (i : Fin (m + n + 1)) : G.V :=
    if h : i.val ≤ m then
      P.verts ⟨i.val, by omega⟩
    else
      Q.verts ⟨i.val - m, by omega⟩
  {
    verts := verts,
    start := by
      simp [verts]
      exact P.start,
    finish := by
      simp [verts]
      split_ifs with h
      · have : m + n = m := by omega
        subst this
        have : n = 0 := by omega
        subst this
        simp at *
        trans v
        · exact P.finish
        · exact Q.finish
      · have : m + n - m = n := by omega
        simp [this]
        exact Q.finish,
    step := by
      intro i
      simp [verts]
      split_ifs with h1 h2 h3
      · -- Case: both i and i+1 are in P
        exact P.step ⟨i.val, by omega⟩
      · -- Case: i is the junction (i = m)
        have hi_eq_m : i.val = m := by omega
        have hi1_not_le_m : ¬(i.val + 1 ≤ m) := by omega
        -- This uses P.finish = v and Q.start = v
        rw [hi_eq_m]
        simp [hi1_not_le_m]
        have hP_fin : P.verts ⟨m, by omega⟩ = v := P.finish
        have hQ_start : Q.verts ⟨0, by omega⟩ = v := Q.start
        rw [hP_fin, hQ_start]
        exact Q.step ⟨0, by omega⟩ -- This assumes Q is non-empty if we are moving past m
        -- Actually, the logic needs to verify if n=0 or not. 
        -- If n > 0, the next vertex is Q.verts 1.
        -- If n = 0, this case shouldn't be reachable as i < m + n.
        sorry 
      · -- Case: both are in Q
        exact Q.step ⟨i.val - m, by omega⟩
  }

end FMT.Graph
