import FMT.Graph.DistanceCore
import FMT.Graph.PathLength
import FMT.Graph.ExistsMinPath

namespace FMT.Graph

theorem dist?_some_of_shortest_path
  {G : Graph} {u v : G.V} {d : Nat} :
  Nonempty (PathLength G u v d) →
  (∀ m, m < d → ¬ Nonempty (PathLength G u v m)) →
  dist? (G:=G) u v = some d := by
  classical
  intro hd hmin
  unfold dist?
  have h : ∃ n, Nonempty (PathLength G u v n) := ⟨d, hd⟩
  simp [h]
  have hchoose :=
    Classical.choose_spec (exists_min_pathLength (G:=G) u v h)
  have hEq : Classical.choose (exists_min_pathLength (G:=G) u v h) = d := by
    apply Nat.le_antisymm
    · exact Nat.le_of_not_gt (by
        intro hlt
        exact hmin _ hlt hchoose.1)
    · exact Nat.le_of_not_gt (by
        intro hlt
        exact hchoose.2 _ hlt hd)
  simpa [hEq]

end FMT.Graph
