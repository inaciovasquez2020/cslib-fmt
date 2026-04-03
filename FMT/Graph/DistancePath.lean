import FMT.Graph.PathLength

open Classical

namespace FMT.Graph

noncomputable def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n, Nonempty (PathLength G u v n) then
    some (Classical.choose h)
  else
    none

theorem shortest_path_selector
    (G : Graph) {u v : G.V} {n : Nat}
    (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) := by
  unfold dist? at h
  split_ifs at h with hex
  · injection h with hn
    subst hn
    exact Classical.choose_spec hex
  · exact absurd h (by simp)

end FMT.Graph
