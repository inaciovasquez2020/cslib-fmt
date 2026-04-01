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
      G.Adj (verts ⟨i.val, Nat.lt_trans i.isLt (Nat.lt_succ_self _)⟩)
            (verts ⟨i.val + 1, Nat.succ_lt_succ i.isLt⟩))

-- graph distance as minimal walk length
noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  Nat.find (fun n => ∃ w : Walk G u v, w.len = n)

-- reflexivity
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

-- triangle inequality (via walk concatenation)
theorem dist_triangle (G : Graph) (u v w : G.V) :
  dist G u w ≤ dist G u v + dist G v w := by
  apply Nat.find_le
  rcases Nat.find_spec (G := G) (u := u) (v := v) with ⟨wu, hu⟩
  rcases Nat.find_spec (G := G) (u := v) (v := w) with ⟨wv, hv⟩
  refine ⟨{
    len := wu.len + wv.len,
    verts := fun i =>
      if h : i.val ≤ wu.len then
        wu.verts ⟨i.val, by
          have := i.isLt
          exact Nat.lt_of_le_of_lt h (Nat.lt_succ_self _)⟩
      else
        wv.verts ⟨i.val - wu.len, by
          have := i.isLt
          exact Nat.sub_lt (Nat.lt_succ_self _) (Nat.pos_of_lt this)⟩,
    start := by simpa using wu.start,
    end_ := by simpa using wv.end_,
    adjacent := by
      intro i
      by_cases h : i.val < wu.len
      · simpa using wu.Adjacent ⟨i.val, h⟩
      · have : i.val - wu.len < wv.len := by
          have := i.isLt
          exact Nat.sub_lt (Nat.lt_succ_self _) (Nat.pos_of_lt this)
        simpa using wv.Adjacent ⟨i.val - wu.len, this⟩
  }, by
    simp [hu, hv]⟩

end FMT.Graph
