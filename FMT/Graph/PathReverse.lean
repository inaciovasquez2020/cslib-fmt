import FMT.Graph.PathLength

namespace FMT.Graph

theorem path_reverse
  {G : Graph} (hSymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  {u v : G.V} {n : Nat} :
  PathLength G u v n → PathLength G v u n := by
  intro p
  classical
  refine
  { verts := fun i => p.verts ⟨n - i.1, by
      have hi : i.1 ≤ n := Nat.le_of_lt_succ i.2
      exact Nat.lt_succ_of_le (Nat.sub_le _ _)⟩
    start := by simpa using p.finish
    finish := by simpa using p.start
    step := ?_ }
  intro i
  have hi : i.1 < n := i.2
  have hidx : n - Nat.succ i.1 < n + 1 := by omega
  have hidx' : n - i.1 < n + 1 := by omega
  have hs : G.Adj (p.verts ⟨n - i.1, hidx'⟩) (p.verts ⟨n - Nat.succ i.1, hidx⟩) := by
    have := p.step ⟨n - Nat.succ i.1, by omega⟩
    simpa using this
  exact hSymm _ _ hs

end FMT.Graph
