import FMT.Graph.DistancePath
import FMT.Graph.PathLengthConcat

namespace FMT.Graph

theorem dist?_triangle
  {G : Graph} [FMT.Inputs.SLASHAxioms G]
  {u v w : G.V} {m n : Nat}
  (huv : dist? (G:=G) u v = some m)
  (hvw : dist? (G:=G) v w = some n) :
  ∃ d, dist? (G:=G) u w = some d ∧ d ≤ m + n := by
  have hpuv : Nonempty (PathLength G u v m) := path_of_dist?_some G huv
  have hpvw : Nonempty (PathLength G v w n) := path_of_dist?_some G hvw
  rcases hpuv with ⟨P⟩
  rcases hpvw with ⟨Q⟩
  exact dist?_le_of_path G u w ⟨pathLength_concat G P Q⟩

end FMT.Graph
