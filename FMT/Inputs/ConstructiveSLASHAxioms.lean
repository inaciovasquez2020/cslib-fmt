import FMT.Graph.DistanceCore
import FMT.Graph.DistSomeOfShortestPath
import FMT.Inputs.SLASH_Axioms
import Mathlib

namespace FMT.Inputs

open Classical
open FMT.Graph

theorem exists_shortest_path_length_constructive
    (G : Graph) (u v : G.V) :
    (∃ n, Nonempty (PathLength G u v n)) →
    ∃ n, Nonempty (PathLength G u v n) ∧
      ∀ m, m < n → ¬ Nonempty (PathLength G u v m) :=
  exists_min_pathLength G u v

theorem dist_is_shortest_constructive
    {G : Graph} {u v : G.V} {n : Nat}
    (h : dist? G u v = some n) :
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) :=
  dist?_minimal G h

theorem dist_le_of_path_constructive
    {G : Graph} {u v : G.V} {n : Nat}
    (hpath : Nonempty (PathLength G u v n)) :
    ∃ d, dist? G u v = some d ∧ d ≤ n := by
  let hex : ∃ k, Nonempty (PathLength G u v k) := ⟨n, hpath⟩
  let d : Nat := Classical.choose (exists_min_pathLength G u v hex)
  refine ⟨d, ?_, ?_⟩
  · simp [dist?, hex, d]
  · have hspec := Classical.choose_spec (exists_min_pathLength G u v hex)
    by_cases h : n < d
    · exact (False.elim (hspec.2 n h hpath))
    · exact Nat.le_of_not_gt h

noncomputable def dist_bound_of_path_constructive
    {G : Graph} {u v : G.V} {n : Nat}
    (hpath : Nonempty (PathLength G u v n)) : Nat :=
  Classical.choose (dist_le_of_path_constructive hpath)

theorem dist_some_of_shortest_path_constructive
    {G : Graph} {u v : G.V} {d : Nat}
    (hdpath : Nonempty (PathLength G u v d))
    (hdmin : ∀ m, m < d → ¬ Nonempty (PathLength G u v m)) :
    dist? G u v = some d :=
  dist?_some_of_shortest_path G hdpath hdmin

theorem dist_symm_of_adj_symm
    (G : Graph)
    (hAdjSymm : ∀ a b : G.V, G.Adj a b → G.Adj b a) :
    ∀ u v : G.V, dist? G u v = dist? G v u := by
  intro u v
  by_cases huv : ∃ n, Nonempty (PathLength G u v n)
  · obtain ⟨nuv, hp_uv, hmin_uv⟩ :=
      exists_shortest_path_length_constructive G u v huv
    have hvu : ∃ n, Nonempty (PathLength G v u n) := by
      exact ⟨nuv, ⟨PathLength.reverse hAdjSymm hp_uv.some⟩⟩
    obtain ⟨nvu, hp_vu, hmin_vu⟩ :=
      exists_shortest_path_length_constructive G v u hvu
    have hle1 : nuv ≤ nvu := by
      by_contra h
      exact hmin_uv nvu (lt_of_not_ge h) ⟨PathLength.reverse hAdjSymm hp_vu.some⟩
    have hle2 : nvu ≤ nuv := by
      by_contra h
      exact hmin_vu nuv (lt_of_not_ge h) ⟨PathLength.reverse hAdjSymm hp_uv.some⟩
    have heq : nuv = nvu := Nat.le_antisymm hle1 hle2
    rw [dist_some_of_shortest_path_constructive hp_uv hmin_uv]
    symm
    exact dist_some_of_shortest_path_constructive
      (by simpa [heq] using hp_vu)
      (by simpa [heq] using hmin_vu)
  · have hvu : ¬ ∃ n, Nonempty (PathLength G v u n) := by
      intro hvu
      rcases hvu with ⟨n, hp⟩
      exact huv ⟨n, ⟨PathLength.reverse hAdjSymm hp.some⟩⟩
    simp [dist?, huv, hvu]

theorem dist_triangle_constructive
    (G : Graph) (u v w : G.V) {a b : Nat}
    (huv : dist? G u v = some a)
    (hvw : dist? G v w = some b) :
    ∃ c, dist? G u w = some c ∧ c ≤ a + b := by
  have hpu : Nonempty (PathLength G u v a) := path_of_dist?_some G huv
  have hpv : Nonempty (PathLength G v w b) := path_of_dist?_some G hvw
  exact dist_le_of_path_constructive
    (G := G) (u := u) (v := w) (n := a + b) ⟨PathLength.concat hpu.some hpv.some⟩

@[reducible]
noncomputable def undirectedGraphInstance
    (G : Graph)
    (hAdjSymm : ∀ a b : G.V, G.Adj a b → G.Adj b a) :
    SLASHAxioms G where
  exists_shortest_path_length := exists_shortest_path_length_constructive G
  dist_is_shortest := dist_is_shortest_constructive
  dist_symm := dist_symm_of_adj_symm G hAdjSymm
  dist_triangle := dist_triangle_constructive G
  dist_le_of_path := dist_le_of_path_constructive
  dist_bound_of_path := dist_bound_of_path_constructive

@[reducible]
noncomputable def liftWithSymmetry
    (G : Graph)
    (hDistSymm : ∀ u v : G.V, dist? G u v = dist? G v u) :
    SLASHAxioms G where
  exists_shortest_path_length := exists_shortest_path_length_constructive G
  dist_is_shortest := dist_is_shortest_constructive
  dist_symm := hDistSymm
  dist_triangle := dist_triangle_constructive G
  dist_le_of_path := dist_le_of_path_constructive
  dist_bound_of_path := dist_bound_of_path_constructive

end FMT.Inputs
