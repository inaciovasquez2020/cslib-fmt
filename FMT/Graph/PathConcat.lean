import FMT.Graph.PathLength

namespace FMT.Graph

theorem path_concat
  {G : Graph} {u v w : G.V} {m n : Nat} :
  PathLength G u v m → PathLength G v w n → PathLength G u w (m + n) := by
  intro p q
  classical
  refine
  { verts := fun i =>
      if h : i.1 ≤ m then
        p.verts ⟨i.1, by omega⟩
      else
        q.verts ⟨i.1 - m, by omega⟩
    start := by
      simp
      simpa using p.start
    finish := by
      have hm : ¬ m + n ≤ m := by omega
      simp [hm]
      have : m + n - m = n := by omega
      simpa [this] using q.finish
    step := ?_ }
  intro i
  by_cases h : i.1.succ ≤ m
  · have hi : i.1 ≤ m := Nat.le_trans (Nat.le_of_lt_succ i.2) h
    simp [h, hi]
    simpa using p.step ⟨i.1, by omega⟩
  · have hi : ¬ i.1 ≤ m := by omega
    simp [h, hi]
    have : G.Adj (q.verts ⟨i.1 - m, by omega⟩) (q.verts ⟨i.1.succ - m, by omega⟩) := by
      simpa [Nat.succ_sub hi] using q.step ⟨i.1 - m, by omega⟩
    simpa [Nat.succ_sub hi] using this

end FMT.Graph
