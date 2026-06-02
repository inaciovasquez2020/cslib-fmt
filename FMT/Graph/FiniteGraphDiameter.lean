import FMT.Graph.GlobalDistanceAxiomDischarge

namespace FMT.Graph

open Classical

/--
A finite graph is connected when every ordered pair of repo-native vertices has
a realized optional distance value.
-/
def ConnectedGraph
  (G : Graph)
  [Fintype G.V] : Prop :=
  ∀ u w : G.V, ∃ n : Nat, dist? u w = some n

/--
The finite set of all ordered repo-native vertex pairs.
-/
def allVertexPairs
  (G : Graph)
  [Fintype G.V] : Finset (G.V × G.V) :=
  Finset.univ.product Finset.univ

/--
The optional distance attached to one ordered repo-native vertex pair.
-/
noncomputable def pairDistance?
  {G : Graph}
  (p : G.V × G.V) : Option Nat :=
  dist? p.1 p.2

/--
All ordered repo-native vertex pairs are reachable.
-/
def allPairDistancesReachable
  (G : Graph)
  [Fintype G.V] : Prop :=
  ∀ p ∈ allVertexPairs G, ∃ n : Nat, pairDistance? p = some n

/--
Finite set of realized pairwise distances.

Unreachable pairs contribute `0`; the surrounding `finiteGraphDiameter?`
definition returns `none` unless every pair is reachable, so these fallback
zeros do not affect connected cases.
-/
noncomputable def pairDistanceValues
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V] : Finset Nat :=
  (allVertexPairs G).image
    (fun p =>
      match pairDistance? p with
      | some n => n
      | none => 0)

/--
A small local maximum operator on lists of natural numbers.

The empty-list convention is `0`.
-/
def natListMax : List Nat → Nat
  | [] => 0
  | n :: ns => max n (natListMax ns)

theorem le_natListMax_of_mem
  {xs : List Nat}
  {n : Nat}
  (h : n ∈ xs) :
  n ≤ natListMax xs := by
  induction xs with
  | nil =>
      cases h
  | cons head tail ih =>
      simp [List.mem_cons] at h
      cases h with
      | inl hEq =>
          rw [hEq]
          exact Nat.le_max_left head (natListMax tail)
      | inr hMem =>
          exact Nat.le_trans (ih hMem) (Nat.le_max_right head (natListMax tail))

/--
Option-valued finite graph diameter.

For finite disconnected graphs, this returns `none`.
For finite connected graphs, this returns the maximum realized pairwise
distance.
For the empty repo-native vertex-pair set, the maximum convention is `0`.
-/
noncomputable def finiteGraphDiameter?
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V] : Option Nat := by
  classical
  exact
    if allPairDistancesReachable G then
      some (natListMax (pairDistanceValues G).toList)
    else
      none

theorem connected_implies_all_pair_distances_reachable
  (G : Graph)
  [Fintype G.V]
  (hG : ConnectedGraph G) :
  allPairDistancesReachable G := by
  intro p hp
  exact hG p.1 p.2

theorem finite_connected_graph_diameter_exists
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (hG : ConnectedGraph G) :
  ∃ d : Nat, finiteGraphDiameter? G = some d := by
  classical
  refine ⟨natListMax (pairDistanceValues G).toList, ?_⟩
  simp [finiteGraphDiameter?, connected_implies_all_pair_distances_reachable G hG]


theorem finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (h : ¬ allPairDistancesReachable G) :
  finiteGraphDiameter? G = none := by
  classical
  simp [finiteGraphDiameter?, h]

theorem distance_mem_pairDistanceValues
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (u w : G.V)
  (n : Nat)
  (hdist : dist? u w = some n) :
  n ∈ pairDistanceValues G := by
  classical
  refine Finset.mem_image.mpr ?_
  refine ⟨(u, w), ?_, ?_⟩
  · simp [allVertexPairs]
  · simp [pairDistance?, hdist]

theorem distance_le_diameter_of_finite_connected
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (hG : ConnectedGraph G)
  (u w : G.V)
  (n d : Nat)
  (hdist : dist? u w = some n)
  (hdiam : finiteGraphDiameter? G = some d) :
  n ≤ d := by
  classical
  have hmem : n ∈ pairDistanceValues G :=
    distance_mem_pairDistanceValues G u w n hdist

  have hlist : n ∈ (pairDistanceValues G).toList := by
    simpa using hmem

  have hreachable : allPairDistancesReachable G :=
    connected_implies_all_pair_distances_reachable G hG

  simp [finiteGraphDiameter?, hreachable] at hdiam
  subst d

  exact le_natListMax_of_mem hlist

end FMT.Graph
