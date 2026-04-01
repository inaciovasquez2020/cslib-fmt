import FMT.Graph.Basic

namespace FMT.Graph

-- walk with explicit vertex sequence and adjacency constraint
structure Walk (G : Graph) (u v : G.V) :=
  (len : Nat)
  (verts : Fin (len + 1) → G.V)
  (start : verts 0 = u)
  (end_ : verts ⟨len, Nat.lt_succ_self _⟩ = v)
  (adjacent :
    ∀ i : Fin len,
      G.adj (verts ⟨i.val, Nat.lt_trans i.isLt (Nat.lt_succ_self _)⟩)
            (verts ⟨i.val + 1, Nat.succ_lt_succ i.isLt⟩))

-- graph distance as minimal walk length
noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  Nat.find (fun n => ∃ w : Walk G u v, w.len = n)

end FMT.Graph
