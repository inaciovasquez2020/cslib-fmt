import FMT.Graph.DistSomeOfShortestPath
import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_le_of_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v : G.V) {n : Nat} :
  Nonempty (PathLength G u v n) →
  ∃ d, dist? G u v = some d ∧ d ≤ n := by
  intro h
  classical
  obtain ⟨m, hm, hmin⟩ :=
    FMT.Inputs.SLASHAxioms.exists_shortest_path_length
      (G:=G) (u:=u) (v:=v) ⟨n, h⟩
  refine ⟨m, dist?_some_of_shortest_path (G:=G) (u:=u) (v:=v) hm hmin, ?_⟩
  by_contra hmn
  exact hmin n (Nat.lt_of_not_ge hmn) h

end FMT.Graph
