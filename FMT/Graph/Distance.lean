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

-- reflexivity of distance
theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := by
  apply Nat.find_eq_iff.mpr
  constructor
  · exact ⟨{
      len := 0,
      verts := fun _ => v,
      start := rfl,
      end_ := rfl,
      adjacent := by intro i; cases i
    }, rfl⟩
  · intro m hm
    rcases hm with ⟨w, hw⟩
    cases w.len with
    | zero => exact le_rfl
    | succ k => exact Nat.succ_le_succ (Nat.zero_le k)

end FMT.Graph
