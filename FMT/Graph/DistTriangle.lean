import FMT.Graph.DistSomeOfShortestPath
import FMT.Graph.PathLength

namespace FMT.Graph

theorem dist?_triangle
  {G : Graph} {u v w : G.V} :
  ∀ d1 d2,
  dist? G u v = some d1 →
  dist? G v w = some d2 →
  ∃ d3, dist? G u w = some d3 ∧ d3 ≤ d1 + d2 := by
  intro d1 d2 huv hvw
  classical
  obtain ⟨p1⟩ := path_of_dist?_some (G:=G) (u:=u) (v:=v) huv
  obtain ⟨p2⟩ := path_of_dist?_some (G:=G) (u:=v) (v:=w) hvw
  have hcat := PathLength.concat p1 p2
  refine ⟨_, ?_, ?_⟩
  · exact (d1 + d2)
  · exact dist?_some_of_path (G:=G) (u:=u) (v:=w) hcat
  · exact Nat.le_refl _
end FMT.Graph
