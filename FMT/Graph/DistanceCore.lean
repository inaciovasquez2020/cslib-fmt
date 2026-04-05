import FMT.Graph.PathLength

namespace FMT.Graph

noncomputable def dist? {G : Graph} (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose h)
  else
    none

end FMT.Graph
