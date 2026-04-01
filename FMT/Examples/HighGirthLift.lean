import FMT.Graph.Basic

namespace FMT.Examples

open FMT.Graph

-- cycle graph on Fin n
def cycleGraph (n : Nat) : Graph :=
{ V := Fin n,
  adj := fun i j =>
    (j = ⟨(i.val + 1) % n, by
      have := Nat.mod_lt (i.val + 1) (Nat.succ_pos _)
      simpa using this⟩) ∨
    (i = ⟨(j.val + 1) % n, by
      have := Nat.mod_lt (j.val + 1) (Nat.succ_pos _)
      simpa using this⟩) }

-- girth parameter (placeholder)
def girth (G : Graph) : Nat := 0

-- explicit high-girth family (to refine girth proof)
def HighGirthFamily (n : Nat) : Graph :=
  cycleGraph (n + 3)

end FMT.Examples
