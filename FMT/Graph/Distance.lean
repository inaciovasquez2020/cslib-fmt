import FMT.Graph.DistancePath

open Classical

namespace FMT.Graph

noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  match dist? G u v with
  | some n => n
  | none => 0

theorem dist_eq_zero_of_eq (G : Graph) (u : G.V) :
  dist G u u = 0 := by
  unfold dist dist?
  by_cases h : ∃ n, Nonempty (PathLength G u u n)
  · have : dist? G u u = some (Classical.choose h) := by simp [dist?, h]
    simp [dist, this]
  · simp [dist?, h]

end FMT.Graph
