import FMT.Graph.Basic
import FMT.Graph.PathLength

namespace FMT.Graph

noncomputable def shortestLength {G : Graph} (u v : G.V) : Option Nat := by
  classical
  by_cases h : ∃ n, Nonempty (PathLength G u v n)
  · exact some (Nat.find h)
  · exact none

theorem shortest_length_spec
  {G : Graph} {u v : G.V} {n : Nat}
  (h : shortestLength u v = some n) :
  Nonempty (PathLength G u v n) ∧
  ∀ k < n, ¬ Nonempty (PathLength G u v k) := by
  classical
  unfold shortestLength at h
  by_cases hex : ∃ m, Nonempty (PathLength G u v m)
  · simp [hex] at h
    subst n
    refine ⟨Nat.find_spec hex, ?_⟩
    intro k hk hkpath
    exact Nat.not_lt_of_ge (Nat.find_min' hex hkpath) hk
  · simp [hex] at h

end FMT.Graph
