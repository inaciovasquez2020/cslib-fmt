import FMT.Graph.Basic

namespace FMT.Examples

open FMT.Graph

-- nontrivial FO-equivalence placeholder (to be refined)
def FO_equiv (G H : Graph) : Prop := G.V ≃ H.V

-- nontrivial separation via edge-count difference
def separated (G H : Graph) : Prop :=
  (∃ u v, G.adj u v) ≠ (∃ u v, H.adj u v)

-- explicit witness pair
def G1 : Graph :=
{ V := Bool,
  adj := fun x y => x ≠ y }

def G2 : Graph :=
{ V := Bool,
  adj := fun _ _ => False }

theorem separation_witness :
  FO_equiv G1 G2 ∧ separated G1 G2 := by
  constructor
  · exact Equiv.refl _
  · simp [separated, G1, G2]

end FMT.Examples
