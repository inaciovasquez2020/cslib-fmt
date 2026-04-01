import FMT.Graph.Basic

namespace FMT.Graph

structure Adj (G : Graph) (u v : G.V) : Prop := mk :: True

inductive Path (G : Graph) : G.V → G.V → Type
| nil  (u : G.V) : Path G u u
| cons {u v w : G.V} :
    Adj G u v → Path G v w → Path G u w

def pathLength {G : Graph} : {u v : G.V} → Path G u v → Nat
| _, _, Path.nil _ => 0
| _, _, Path.cons _ p => Nat.succ (pathLength p)

def dist (G : Graph) (u v : G.V) : Nat :=
  Nat.find (fun n => ∃ p : Path G u v, pathLength p = n)

theorem dist_refl (G : Graph) (v : G.V) :
  dist G v v = 0 := by
  apply Nat.find_eq_iff.mpr
  constructor
  · exact ⟨Path.nil v, rfl⟩
  · intro y h
    cases h with
    | intro p hp =>
      cases p <;> simp at hp <;> exact hp

end FMT.Graph
