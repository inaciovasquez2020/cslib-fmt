import FMT.Graph.DistanceOrder
import FMT.Graph.Distance

namespace FMT.Graph

def InBoundedRadius (G : Graph) (v u : G.V) (r : Nat) : Prop :=
  ∃ d, dist? G v u = some d ∧ d ≤ r

def BoundedRadius (G : Graph) (v : G.V) (r : Nat) : Type _ :=
  { u : G.V // InBoundedRadius G v u r }

theorem inBoundedRadius_of_distLE
    (G : Graph) (v u : G.V) (r : Nat)
    (h : DistLE G v u r) :
    InBoundedRadius G v u r := by
  exact h

theorem dist_le_of_inBoundedRadius
    (G : Graph) (v u : G.V) (r : Nat)
    (h : InBoundedRadius G v u r) :
    dist G v u ≤ r := by
  rcases h with ⟨d, hd, hdr⟩
  simpa [dist, hd] using hdr

end FMT.Graph
