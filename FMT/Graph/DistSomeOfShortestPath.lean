import FMT.Graph.DistanceCore

namespace FMT.Graph

axiom choose_eq_of_shortest
  (G : Graph) {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  Classical.choose (show ∃ n, Nonempty (PathLength G u v n) from ⟨d, hdpath⟩) = d

theorem dist?_some_of_shortest_path
  (G : Graph) {u v : G.V} {d : Nat}
  (hdpath : Nonempty (PathLength G u v d))
  (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
  dist? G u v = some d := by
  unfold dist?
  have hnon : ∃ n, Nonempty (PathLength G u v n) := ⟨d, hdpath⟩
  simp [hnon, choose_eq_of_shortest G hdpath hdmin]

end FMT.Graph
