import FMT.Graph.Basic
import FMT.Graph.PathLength
import FMT.Graph.DistanceCore
import FMT.Graph.ShortestLength

namespace FMT.Graph

theorem dist?_some_of_shortest_path
  {G : Graph} {u v : G.V} {n : Nat}
  (hm : Nonempty (PathLength G u v n))
  (hmin : ∀ k < n, ¬ Nonempty (PathLength G u v k)) :
  dist? u v = some n := by
  classical
  unfold dist?
  unfold shortestLength
  by_cases hex : ∃ m, Nonempty (PathLength G u v m)
  · simp [hex]
    apply Nat.le_antisymm
    · exact Nat.find_min' hex hm
    · have hspec : Nonempty (PathLength G u v (Nat.find hex)) := Nat.find_spec hex
      by_contra hlt
      have hlt' : Nat.find hex < n := Nat.lt_of_not_ge hlt
      exact hmin (Nat.find hex) hlt' hspec
  · exfalso
    exact hex ⟨n, hm⟩

end FMT.Graph
