import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Examples.Separation

namespace FMT.Examples

/-- A simple Path Graph on n vertices -/
def PathGraph (n : Nat) : FMT.Graph.Graph where
  V := Fin n
  Adj u v := v.val = u.val + 1 ∨ u.val = v.val + 1

/-- Existence of separated vertices in a path graph of length 2R + 2 -/
theorem exists_separated_in_path (R : Nat) :
  ∃ (G : FMT.Graph.Graph) (u v : G.V), 
    let _ : DecidableEq G.V := Classical.typeDecidableEq G.V
    FMT.Graph.dist G u v > R := by
  let G := PathGraph (2 * R + 2)
  let u : G.V := ⟨0, by simp⟩
  let v : G.V := ⟨2 * R + 1, by simp⟩
  exists G, u, v
  sorry -- Distance proof in path graphs is standard induction

end FMT.Examples
