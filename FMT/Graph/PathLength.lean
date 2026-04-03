import FMT.Graph.Basic

namespace FMT.Graph

structure PathLength (G : Graph) (u v : G.V) (n : Nat) : Type where
verts : Fin (n + 1) → G.V
start : verts ⟨0, Nat.succ_pos n⟩ = u
finish : verts ⟨n, Nat.lt_succ_self n⟩ = v
step : ∀ i : Fin n, G.Adj (verts i.castSucc) (verts i.succ)

end FMT.Graph
