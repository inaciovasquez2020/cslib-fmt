import FMT.Graph.DistancePath

namespace FMT.Graph

theorem dist?_exists_of_path
  (G : Graph) {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n)) :
  ∃ d, dist? (G:=G) u v = some d := by
  rcases dist?_cases G u v with ⟨d, hd⟩ | hnone
  · exact ⟨d, hd⟩
  · exfalso
    unfold dist? at hnone
    by_cases hex : ∃ m, Nonempty (PathLength G u v m)
    · simp [hex] at hnone
    · exact hex ⟨n, hpath⟩

end FMT.Graph
