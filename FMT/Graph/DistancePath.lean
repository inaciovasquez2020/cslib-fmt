import FMT.Graph.DistSomeOfShortestPath
import FMT.Graph.DistSomeOfPath

namespace FMT.Graph

-- weaken: remove dependence on SLASH / shortest-path oracle
theorem dist_le_of_path
  {G : Graph} {u v : G.V} {n : Nat}
  (h : PathLength G u v n) :
  ∃ d, dist? G u v = some d := by
  classical
  exact ⟨n, dist?_some_of_path (G:=G) (u:=u) (v:=v) h⟩

end FMT.Graph
