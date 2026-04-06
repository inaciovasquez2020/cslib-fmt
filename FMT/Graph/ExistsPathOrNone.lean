import FMT.Graph.Basic
import FMT.Graph.PathLength
import FMT.Graph.DistanceCore
import FMT.Graph.ShortestLength

namespace FMT.Graph

theorem exists_path_or_none
  {G : Graph} (u v : G.V) :
  (∃ n, Nonempty (PathLength G u v n)) ∨ dist? u v = none := by
  classical
  by_cases h : ∃ n, Nonempty (PathLength G u v n)
  · exact Or.inl h
  · exact Or.inr (by
      unfold dist?
      unfold shortestLength
      simp [h])

end FMT.Graph
