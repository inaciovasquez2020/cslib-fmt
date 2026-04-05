import FMT.Graph.Basic
import Mathlib

namespace FMT.Graph

structure PathLength (G : Graph) (u v : G.V) (n : Nat) : Type where
  verts  : Fin (n + 1) → G.V
  start  : verts ⟨0, Nat.succ_pos n⟩ = u
  finish : verts ⟨n, Nat.lt_succ_self n⟩ = v
  step   : ∀ i : Fin n, G.Adj (verts i.castSucc) (verts i.succ)

def PathLength.concat
    {G : Graph} {u v w : G.V} {m n : Nat}
    (p : PathLength G u v m) (q : PathLength G v w n) :
    PathLength G u w (m + n) where
  verts i :=
    if h : i.1 ≤ m then
      p.verts ⟨i.1, Nat.lt_succ_of_le h⟩
    else
      q.verts ⟨i.1 - m, by omega⟩
  start := by
    simp
    exact p.start
  finish := by
    cases n with
    | zero =>
        simp
        have hqv : q.verts ⟨0, by omega⟩ = v := q.start
        have hqw : q.verts ⟨0, by omega⟩ = w := q.finish
        rw [← hqw, hqv]
        exact p.finish
    | succ n =>
        have h : ¬ (m + n.succ ≤ m) := by omega
        simp [h]
        exact q.finish
  step i := by
    by_cases hcur : i.1 ≤ m
    · by_cases hnext : i.1.succ ≤ m
      · simp [hcur, hnext]
        exact p.step ⟨i.1, by omega⟩
      · -- Join point: i.1 = m
        have him : i.1 = m := by omega
        simp [hcur, hnext, him]
        -- Bridge the paths directly to avoid rewriting v
        have h_bridge : p.verts ⟨m, by omega⟩ = q.verts ⟨0, by omega⟩ := 
          p.finish.trans q.start.symm
        rw [h_bridge]
        exact q.step ⟨0, by omega⟩
    · have hnext : ¬ i.1.succ ≤ m := by omega
      simp [hcur, hnext]
      -- Use convert or explicit rewrites for the q indices
      have hidx : i.1.succ - m = (i.1 - m) + 1 := by omega
      let s := q.step ⟨i.1 - m, by omega⟩
      simpa [hidx] using s

def PathLength.reverse
    {G : Graph} {u v : G.V} {n : Nat}
    (hAdjSymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
    (p : PathLength G u v n) :
    PathLength G v u n where
  verts i := p.verts ⟨n - i.1, by omega⟩
  start := by
    simp
    exact p.finish
  finish := by
    simp
    exact p.start
  step i := by
    let k := n - (i.1 + 1)
    have hk : k < n := by
      omega
    have h_symm := hAdjSymm _ _ (p.step ⟨k, hk⟩)
    have hleft : (⟨k, hk⟩ : Fin n).succ = ⟨n - i.1, by omega⟩ := by
      apply Fin.ext
      change k + 1 = n - i.1
      simp [k]
      omega
    have hright : (⟨k, hk⟩ : Fin n).castSucc = ⟨n - (i.1 + 1), by omega⟩ := by
      apply Fin.ext
      rfl
    simpa [hleft, hright] using h_symm

end FMT.Graph
