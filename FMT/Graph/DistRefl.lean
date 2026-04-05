import FMT.Graph.PathLength
import FMT.Graph.DistanceCore
import FMT.Graph.DistSomeOfShortestPath
import Mathlib

namespace FMT.Graph

def nilPath (G : Graph) (u : G.V) : PathLength G u u 0 where
  verts _ := u
  start := rfl
  finish := rfl
  step := by
    intro i
    exact Fin.elim0 i

theorem dist?_refl (G : Graph) (u : G.V) :
  dist? G u u = some 0 := by
  apply dist?_some_of_shortest_path
  · exact ⟨nilPath G u⟩
  · intro m hm
    omega

end FMT.Graph
