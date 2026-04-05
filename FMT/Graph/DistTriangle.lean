import FMT.Graph.DistancePath
import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_triangle
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v w : G.V) {a b : Nat} :
  dist? G u v = some a →
  dist? G v w = some b →
  ∃ c, dist? G u w = some c ∧ c ≤ a + b := by
  intro huv hvw
  classical
  obtain ⟨p1⟩ := path_of_dist?_some (G:=G) (u:=u) (v:=v) huv
  obtain ⟨p2⟩ := path_of_dist?_some (G:=G) (u:=v) (v:=w) hvw
  have hcat : Nonempty (PathLength G u w (a + b)) := ⟨PathLength.concat p1 p2⟩
  exact dist?_le_of_path (G:=G) (u:=u) (v:=w) hcat

end FMT.Graph
