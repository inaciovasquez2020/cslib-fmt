import FMT.Graph.PathLength
import FMT.Graph.PathLengthLemmas
import Mathlib.Data.Nat.Find
import Mathlib.Data.Option.Basic

namespace FMT.Graph

universe u

variable {G : Graph}

/-- Path-based distance with explicit disconnectedness. -/
def dist? (G : Graph) (u v : G.V) : Option Nat :=
  if h : ∃ n : Nat, Nonempty (PathLength G u v n) then
    some (Nat.find h)
  else
    none

theorem dist?_some_iff {u v : G.V} {n : Nat} :
    dist? G u v = some n ↔
      (∃ h : ∃ m : Nat, Nonempty (PathLength G u v m),
        Nat.find h = n) := by
  unfold dist?
  by_cases h : ∃ m : Nat, Nonempty (PathLength G u v m)
  · simp [h]
  · simp [h]

theorem dist?_none_iff {u v : G.V} :
    dist? G u v = none ↔ ¬ ∃ n : Nat, Nonempty (PathLength G u v n) := by
  unfold dist?
  by_cases h : ∃ n : Nat, Nonempty (PathLength G u v n)
  · simp [h]
  · simp [h]

/-- Extract a path witness from a finite distance value. -/
theorem path_of_dist?_some {u v : G.V} {n : Nat} (h : dist? G u v = some n) :
    Nonempty (PathLength G u v n) := by
  rcases (dist?_some_iff (G := G) (u := u) (v := v) (n := n)).1 h with ⟨hex, hfind⟩
  have hspec := Nat.find_spec hex
  simpa [hfind] using hspec

/-- Any path witness gives an upper bound on the shortest path length. -/
theorem dist?_le_of_path {u v : G.V} {n : Nat} (hP : Nonempty (PathLength G u v n)) :
    ∃ d, dist? G u v = some d ∧ d ≤ n := by
  let hex : ∃ m : Nat, Nonempty (PathLength G u v m) := ⟨n, hP⟩
  refine ⟨Nat.find hex, ?_, Nat.find_min' hex n hP⟩
  unfold dist?
  simp [hex]

/-- Separation at distance zero. -/
theorem dist?_zero_of_eq {u v : G.V} (h : u = v) : dist? G u v = some 0 := by
  subst v
  have h0 : ∃ n : Nat, Nonempty (PathLength G u u n) := ⟨0, by
    simpa using (pathLength_zero_iff (G := G) (u := u) (v := u)).2 rfl⟩
  unfold dist?
  simp [h0, Nat.find_eq_iff]
  constructor
  · exact Nat.zero_le
  · intro m hm
    have : Nonempty (PathLength G u u m) := hm
    rcases this with ⟨P⟩
    simpa using (pathLength_zero_iff (G := G) (u := u) (v := u)).1 ⟨P⟩

/-- Distance zero implies equality of endpoints. -/
theorem eq_of_dist?_zero {u v : G.V} (h : dist? G u v = some 0) : u = v := by
  have hP : Nonempty (PathLength G u v 0) := path_of_dist?_some (G := G) h
  simpa using (pathLength_zero_iff (G := G) (u := u) (v := v)).1 hP

theorem dist?_zero_iff_eq {u v : G.V} :
    dist? G u v = some 0 ↔ u = v := by
  constructor
  · exact eq_of_dist?_zero (G := G)
  · intro h
    exact dist?_zero_of_eq (G := G) h

end FMT.Graph
