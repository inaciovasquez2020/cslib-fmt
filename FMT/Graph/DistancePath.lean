import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Nat.find (Classical.decEq _) (fun n => Nonempty (PathLength G u v n)) h)
  else
    none

theorem shortest_path_selector
    (G : Graph) {u v : G.V} {n : Nat}
    (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) := by
  classical
  unfold dist? at h
  by_cases hex : ∃ k, Nonempty (PathLength G u v k)
  · simp [hex] at h
    cases h
    exact Nat.find_spec hex
  · simp [hex] at h

end FMT.Graph
