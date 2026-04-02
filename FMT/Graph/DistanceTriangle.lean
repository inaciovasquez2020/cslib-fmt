import FMT.Graph.DistanceOrder
import FMT.Graph.DistancePath
import FMT.Graph.PathLengthConcat

namespace FMT.Graph

theorem dist?_triangle_upper_bound (G : Graph) {u v w : G.V} {m n : Nat}
    (huv : Nonempty (PathLength G u v m))
    (hvw : Nonempty (PathLength G v w n)) :
    ∃ d, dist? G u w = some d ∧ d ≤ m + n := by
  rcases huv with ⟨P⟩
  rcases hvw with ⟨Q⟩
  exact dist?_le_of_path (G := G) (u := u) (v := w) (n := m + n) ⟨pathLength_concat G P Q⟩

theorem distLE_triangle
    (G : Graph) {u v w : G.V} {m n : Nat}
    (huv : DistLE G u v m)
    (hvw : DistLE G v w n) :
    DistLE G u w (m + n) := by
  rcases huv with ⟨du, hdu, hmul⟩
  rcases hvw with ⟨dv, hdv, hvnl⟩
  have hpu : Nonempty (PathLength G u v du) :=
    path_of_dist?_some (G := G) hdu
  have hpv : Nonempty (PathLength G v w dv) :=
    path_of_dist?_some (G := G) hdv
  rcases dist?_triangle_upper_bound G hpu hpv with ⟨d, hd, hle⟩
  refine ⟨d, hd, ?_⟩
  exact Nat.le_trans hle (Nat.add_le_add hmul hvnl)

end FMT.Graph
