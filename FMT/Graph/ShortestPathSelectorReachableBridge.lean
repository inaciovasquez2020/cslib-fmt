import FMT.Graph.ShortestPathSelector
import FMT.Graph.ExistsMinPathLengthBridge
import FMT.Graph.PathLengthLemmas

namespace FMT.Graph

theorem shortest_path_selector_complete_of_reachable
  (G : Graph) (u v : G.V)
  (h : Reachable G u v) :
  ∃ s, shortest_path_selector G u v = some s := by
  rcases h with ⟨n, hn⟩
  exact shortest_path_selector_complete G u v hn

end FMT.Graph
