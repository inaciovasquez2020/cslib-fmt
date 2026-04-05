import FMT.Graph.PathLength
import FMT.Graph.ExistsMinPath

namespace FMT.Graph

noncomputable def dist? {G : Graph} (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose (exists_min_pathLength (G:=G) u v h))
  else
    none

end FMT.Graph
