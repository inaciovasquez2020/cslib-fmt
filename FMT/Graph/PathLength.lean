import FMT.Graph.Basic

namespace FMT.Graph

structure PathLength (G : Graph) (u v : G.V) (n : Nat) : Type where
  verts : Fin (n + 1) → G.V
  start : verts ⟨0, Nat.succ_pos _⟩ = u
  finish : verts ⟨n, Nat.lt_succ_self n⟩ = v
  step :
    ∀ i : Fin n,
      G.Adj (verts ⟨i.1, Nat.lt_trans i.2 (Nat.lt_succ_self n)⟩)
            (verts ⟨i.1 + 1, Nat.succ_lt_succ i.2⟩)

end FMT.Graph
