import FMT.Graph.DistanceOrder
import FMT.Graph.DistTriangle

namespace FMT.Graph

theorem distLE_triangle
  (G : Graph) [FMT.Inputs.SLASHAxioms G]
  {u v w : G.V} {m n : Nat}
  (huv : DistLE G u v m)
  (hvw : DistLE G v w n) :
  DistLE G u w (m + n) := by
  rcases huv with ⟨du, hdu, hdu_le⟩
  rcases hvw with ⟨dv, hdv, hdv_le⟩
  rcases dist?_triangle (G:=G) (u:=u) (v:=v) (w:=w) hdu hdv with ⟨d, hd, hle⟩
  exact ⟨d, hd, Nat.le_trans hle (Nat.add_le_add hdu_le hdv_le)⟩

end FMT.Graph
